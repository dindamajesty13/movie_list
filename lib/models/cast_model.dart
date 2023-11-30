import 'package:movie_list/app/api_config.dart';

import '../entities/cast.dart';

class CastModel extends Cast {
  const CastModel({
    required super.name,
    required super.profileUrl,
    required super.gender,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'],
      profileUrl: getProfileImageUrl(json),
      gender: json['gender'],
    );
  }
}

String getProfileImageUrl(Map<String, dynamic> json) {
  if (json['profile_path'] != null) {
    return ApiConfig.baseProfileUrl + json['profile_path'];
  } else {
    return ApiConfig.castPlaceHolder;
  }
}
