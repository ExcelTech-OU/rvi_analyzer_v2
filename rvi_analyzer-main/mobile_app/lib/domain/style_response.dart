import 'package:flutter/foundation.dart';

class StyleResponse {
  final String status;
  final String statusDescription;
  final List<Style> styles;

  StyleResponse({
    required this.status,
    required this.statusDescription,
    required this.styles,
  });

  factory StyleResponse.fromJson(Map<String, dynamic> json) {
    return StyleResponse(
      status: json['status'] as String,
      statusDescription: json['statusDescription'] as String,
      styles: (json['styles'] as List)
          .map((styleJson) => Style.fromJson(styleJson))
          .toList(),
    );
  }
}

class Style {
  final String id;
  final String name;
  final String customer;
  final String plant;
  final List<String> admins;
  final String createdBy;
  final DateTime createdDateTime;

  Style({
    required this.id, // Use @required for non-nullable fields
    required this.name,
    required this.customer,
    required this.plant,
    required this.admins,
    required this.createdBy,
    required this.createdDateTime,
  });

  factory Style.fromJson(Map<String, dynamic> json) {
    return Style(
      id: json['_id'] as String,
      name: json['name'] as String,
      customer: json['customer'] as String,
      plant: json['plant'] as String,
      admins: (json['admin'] as List).map((admin) => admin as String).toList(),
      createdBy: json['createdBy'] as String,
      createdDateTime: DateTime.parse(json['createdDateTime'] as String),
    );
  }
}
