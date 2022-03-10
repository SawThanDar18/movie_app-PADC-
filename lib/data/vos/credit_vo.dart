import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'credit_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO, adapterName: "CreditVOAdapter")
class CreditVO {

  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "id")
  @HiveField(1)
  int? id;

  @JsonKey(name: "popularity")
  @HiveField(2)
  double? popularity;

  @JsonKey(name: "gender")
  @HiveField(3)
  int? gender;

  @JsonKey(name: "known_for_department")
  @HiveField(4)
  String? knownForDepartment;

  @JsonKey(name: "name")
  @HiveField(5)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(6)
  String? profilePath;

  @JsonKey(name: "original_name")
  @HiveField(7)
  String? originalName;

  @JsonKey(name: "cast_id")
  @HiveField(8)
  int? castId;

  @JsonKey(name: "character")
  @HiveField(9)
  String? character;

  @JsonKey(name: "credit_id")
  @HiveField(10)
  String? creditId;

  @JsonKey(name: "order")
  @HiveField(11)
  int? order;

  CreditVO(
      this.adult,
      this.id,
      this.popularity,
      this.gender,
      this.knownForDepartment,
      this.name,
      this.profilePath,
      this.originalName,
      this.castId,
      this.character,
      this.creditId,
      this.order);

  factory CreditVO.fromJson(Map<String, dynamic> json) => _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);

}