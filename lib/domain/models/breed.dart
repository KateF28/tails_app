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
}
