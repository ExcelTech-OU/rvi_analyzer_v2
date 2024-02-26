import 'package:flutter/foundation.dart';

class CustomerResponse {
  final String status;
  final String statusDescription;
  final List<Customer> customers;

  const CustomerResponse({
    required this.status,
    required this.statusDescription,
    required this.customers,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      customers: (json['customers'] as List)
          .map((customer) => Customer.fromJson(customer))
          .toList(),
    );
  }
}

class Customer {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdDateTime;

  const Customer({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdDateTime,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      name: json['name'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
    );
  }
}
