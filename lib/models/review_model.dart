

import 'package:movie_list/app/api_config.dart';

import '../entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.authorName,
    required super.authorUserName,
    required super.avatarUrl,
    required super.rating,
    required super.content,
    required super.elapsedTime,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      authorName: json['author'],
      authorUserName: '@${json['author_details']['username']}',
      avatarUrl: getAvatarUrl(json['author_details']['avatar_path']),
      rating: json['author_details']['rating'] != null
          ? json['author_details']['rating'] / 2
          : -1,
      content: json['content'],
      elapsedTime: getElapsedTime(json['created_at']),
    );
  }
}

String getAvatarUrl(String? path) {
  if (path != null) {
    if (path.startsWith('/https://www.gravatar.com/avatar')) {
      return path.substring(1);
    } else {
      return ApiConfig.baseAvatarUrl + path;
    }
  } else {
    return ApiConfig.avatarPlaceHolder;
  }
}

String getElapsedTime(String date) {
  DateTime reviewDate = DateTime.parse(date);
  DateTime today = DateTime.now();

  Duration diff = today.difference(reviewDate);
  if (diff.inDays >= 365) {
    int years = diff.inDays ~/ 365;
    return '${years}y';
  } else if (diff.inDays >= 30) {
    int months = diff.inDays ~/ 30;
    return '${months}mo';
  } else if (diff.inDays >= 7) {
    int weeks = diff.inDays ~/ 7;
    return '${weeks}w';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays}d';
  } else if (diff.inHours >= 1) {
    int hours = diff.inHours ~/ 24;
    return '${hours}h';
  } else if (diff.inMinutes >= 1) {
    int minutes = diff.inDays ~/ 60;
    return '${minutes}min';
  } else {
    return 'Now';
  }
}