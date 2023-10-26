import 'dart:convert';

class Breed {
  final String title;
  final String ukTitle;
  final String imgUrl;
  final String id;
  String status;

  Breed({
    required this.title,
    required this.ukTitle,
    required this.imgUrl,
    required this.id,
    this.status = 'initial',
  });

  static Map<String, dynamic> toMap(Breed breed) {
    return {
      'title': breed.title,
      'ukTitle': breed.ukTitle,
      'imgUrl': breed.imgUrl,
      'id': breed.id,
      'status': breed.status,
    };
  }

  factory Breed.fromJson(Map<String, dynamic> jsonData) {
    return Breed(
      title: jsonData['title'],
      ukTitle: jsonData['ukTitle'],
      imgUrl: jsonData['imgUrl'],
      id: jsonData['id'],
      status: jsonData['status'],
    );
  }

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
      title: map['title'],
      ukTitle: map['ukTitle'],
      imgUrl: map['imgUrl'],
      id: map['id'],
      status: map['status'],
    );
  }

  static String encode(List<Breed> breeds) => json.encode(
        breeds
            .map<Map<String, dynamic>>((breed) => Breed.toMap(breed))
            .toList(),
      );

  static List<Breed> decode(String breeds) =>
      (json.decode(breeds) as List<dynamic>)
          .map<Breed>((item) => Breed.fromJson(item))
          .toList();
}
