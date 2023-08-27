import 'blood_group.dart';
import 'location_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contact_info.g.dart';

abstract class ContactInfo extends Equatable {
  String get id;
  String? get name;
  String? get phone;
  LatLong? get locationCoordinates;
  BloodGroup? get bloodGroup;
  const ContactInfo();
  @override
  List<Object?> get props => [id, name, phone, locationCoordinates, bloodGroup];
}

@JsonSerializable()
class OnlineContactInfo extends ContactInfo {
  @override
  final String id;
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final LatLong? locationCoordinates;
  @override
  final BloodGroup? bloodGroup;
  final bool? isAnonVolunteer;
  const OnlineContactInfo(
      {required this.id,
      this.name,
      this.phone,
      this.locationCoordinates,
      this.bloodGroup,
      this.isAnonVolunteer});

  Map<String, dynamic> toJson() => _$OnlineContactInfoToJson(this);

  factory OnlineContactInfo.fromJson(Map<String, dynamic> json) =>
      _$OnlineContactInfoFromJson(json);
}
