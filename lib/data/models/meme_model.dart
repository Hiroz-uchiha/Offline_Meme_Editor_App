import 'package:meme_editor_app_offline_first_flutter_application/domain/entities/meme.dart';

class MemeModel extends MemeEntity {
  MemeModel(
      {required super.id,
      required super.name,
      required super.url,
      required super.width,
      required super.height,
      required super.box_count,
      required super.captions});

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        url: json['url'] ?? "",
        width: json['width'] ?? "",
        height: json["height"] ?? "",
        box_count: json["box_count"] ?? "",
        captions: json["captions"] ?? "");
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'width': width,
        'height': height,
        'box_count': box_count,
        'captions': captions
      };
}
