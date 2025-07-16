class MemeEntity {
  final String id;
  final String name;
  final String url;
  final int width;
  final int height;
  final int box_count;
  final int captions;

  MemeEntity(
      {required this.id,
      required this.name,
      required this.url,
      required this.width,
      required this.height,
      required this.box_count,
      required this.captions});
}
