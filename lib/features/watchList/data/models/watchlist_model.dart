import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistModel {
  final String id;
  final String title;
  final String posterUrl;
  final DateTime addedDate;

  WatchlistModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.addedDate,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) {
    return WatchlistModel(
      id: json['id'] as String,
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String,
      addedDate: (json['addedDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
      'addedDate': addedDate,
    };
  }
}