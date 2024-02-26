import 'package:flutter/foundation.dart';

class PurchaseOrderResponse {
  final String status;
  final String statusDescription;
  final List<PurchaseOrder> customerPOs;

  PurchaseOrderResponse({
    required this.status,
    required this.statusDescription,
    required this.customerPOs,
  });

  factory PurchaseOrderResponse.fromJson(Map<String, dynamic> json) {
    final customerPOs = (json['customerPOs'] as List)
            ?.map((po) => PurchaseOrder.fromJson(po))
            .toList() ??
        [];
    return PurchaseOrderResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      customerPOs: customerPOs,
    );
  }
}

class PurchaseOrder {
  final String name;
  final String rawMaterial;
  final String createdBy;
  final DateTime createdDateTime;

  PurchaseOrder({
    required this.name,
    required this.rawMaterial,
    required this.createdBy,
    required this.createdDateTime,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      name: json['name'],
      rawMaterial: json['rawMaterial'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
    );
  }
}
