import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:tails_app/presentation/widgets/breeds_list.dart';
import 'package:tails_app/utils/environment.dart';
import 'package:tails_app/utils/isolate_inference.dart';

/// This is main screen page/view content
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const modelPath = 'assets/tfmodel/mobilenet_v1_1.0_224.tflite';
  static const labelsPath = 'assets/tfmodel/mobilenet_v1_1.0_224.txt';
  Interpreter? interpreter;
  List<String>? labels;
  IsolateInference isolateInference = IsolateInference();
  Tensor? inputTensor;
  Tensor? outputTensor;
  File? _imageFile;
  ImagePicker imagePicker = ImagePicker();
  String? imagePath;
  img.Image? image;
  Map<String, double>? classification;

  @override
  void initState() {
    initHelper();
    super.initState();
  }

  // Load model
  Future<void> _loadModel() async {
    final options = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      options.addDelegate(XNNPackDelegate());
    }
    // Use GPU Delegate
    // doesn't work on emulator
    // if (Platform.isAndroid) {
    //   options.addDelegate(GpuDelegateV2());
    // }
    // Use Metal Delegate
    if (Platform.isIOS) {
      options.addDelegate(GpuDelegate());
    }

    // Load model from assets
    Interpreter loadedInterpreter =
        await Interpreter.fromAsset(modelPath, options: options);
    setState(() {
      interpreter = loadedInterpreter;
      // Get tensor input shape [1, 224, 224, 3]
      inputTensor = loadedInterpreter.getInputTensors().first;
      // Get tensor output shape [1, 1001]
      outputTensor = loadedInterpreter.getOutputTensors().first;
    });
  }

  // Load labels from assets
  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(labelsPath);
    setState(() {
      labels = labelTxt.split('\n');
    });
  }

  Future<void> initHelper() async {
    _loadLabels();
    _loadModel();
    await isolateInference.start();
  }

  // Clean old results when press take picture button
  void cleanResult() {
    setState(() {
      imagePath = null;
      _imageFile = null;
      image = null;
      classification = null;
    });
  }

  Future<Map<String, double>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;
    return results;
  }

  // inference still image
  Future<Map<String, double>> inferenceImage(img.Image imageInput) async {
    var isolateModel = InferenceModel(imageInput, interpreter!.address, labels!,
        inputTensor!.shape, outputTensor!.shape);
    return _inference(isolateModel);
  }

  // Process picked image
  Future<void> processImage() async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = File(imagePath!).readAsBytesSync();

      // Decode image using package:image/image.dart (https://pub.dev/image)
      img.Image? decodedImage = img.decodeImage(imageData);
      setState(() {
        image = decodedImage;
      });
      classification = await inferenceImage(decodedImage!);
      setState(() {});
    }
  }

  Future<void> close() async {
    isolateInference.close();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

// TODO: separate image picker widget, fix no image selected width on init
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Environment.bgColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(color: Environment.bgColor),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(2, 2),
                              spreadRadius: 2,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: (_imageFile != null)
                            ? Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                                height: 200,
                              )
                            : Image.network(
                                'https://i.imgur.com/sUFH1Aq.png',
                                fit: BoxFit.cover,
                                height: 200,
                              )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          cleanResult();
                          final result = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );

                          setState(() {
                            imagePath = result?.path;
                            if (result != null) {
                              _imageFile = File(result.path);
                            }
                          });
                          processImage();
                        },
                        child: Text(AppLocalizations.of(context)!.selectImage),
                      ),
                    ),
                    if (classification != null)
                      ...(classification!.entries.toList()
                            ..sort(
                              (a, b) => a.value.compareTo(b.value),
                            ))
                          .reversed
                          .take(2)
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "${e.key[0].toUpperCase()}${e.key.substring(1)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${(e.value * 100).toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const BreedsListWidget(),
          ],
        );
      },
    );
  }
}
