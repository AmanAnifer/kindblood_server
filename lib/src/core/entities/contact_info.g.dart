// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineContactInfo _$OnlineContactInfoFromJson(Map<String, dynamic> json) =>
    OnlineContactInfo(
      id: json['id'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      locationCoordinates: json['locationCoordinates'] == null
          ? null
          : LatLong.fromJson(
              json['locationCoordinates'] as Map<String, dynamic>),
      bloodGroup: $enumDecodeNullable(_$BloodGroupEnumMap, json['bloodGroup']),
      isAnonVolunteer: json['isAnonVolunteer'] as bool?,
    );

Map<String, dynamic> _$OnlineContactInfoToJson(OnlineContactInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'locationCoordinates': instance.locationCoordinates,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup],
      'isAnonVolunteer': instance.isAnonVolunteer,
    };

const _$BloodGroupEnumMap = {
  BloodGroup.APositive: 'APositive',
  BloodGroup.ANegative: 'ANegative',
  BloodGroup.ABPositive: 'ABPositive',
  BloodGroup.ABNegative: 'ABNegative',
  BloodGroup.BPositive: 'BPositive',
  BloodGroup.BNegative: 'BNegative',
  BloodGroup.OPositive: 'OPositive',
  BloodGroup.ONegative: 'ONegative',
  BloodGroup.Other: 'Other',
  BloodGroup.Unknown: 'Unknown',
};
