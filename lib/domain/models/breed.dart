import 'dart:convert';

class Breed {
  final String id;
  final String title;
  final String ukTitle;
  final String imgUrl;
  String status;

  Breed({
    required this.id,
    required this.title,
    required this.ukTitle,
    required this.imgUrl,
    this.status = 'initial',
  });

  static Map<String, dynamic> toMap(Breed breed) {
    return {
      'id': breed.id,
      'title': breed.title,
      'ukTitle': breed.ukTitle,
      'imgUrl': breed.imgUrl,
      'status': breed.status,
    };
  }

  factory Breed.fromJson(Map<String, dynamic> jsonData) {
    return Breed(
      id: jsonData['id'],
      title: jsonData['title'],
      ukTitle: jsonData['ukTitle'],
      imgUrl: jsonData['imgUrl'],
      status: jsonData['status'],
    );
  }

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
      id: map['id'],
      title: map['title'],
      ukTitle: map['ukTitle'],
      imgUrl: map['imgUrl'],
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
