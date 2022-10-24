import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SaveReadData {
  SaveReadData(this.type, this.products);

  int type;
  List<bool> products;

  factory SaveReadData.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}