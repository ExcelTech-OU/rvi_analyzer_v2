class OrderResponse {
  final String status;
  final String statusDescription;
  final List<Order> orders;

  OrderResponse({
    required this.status,
    required this.statusDescription,
    required this.orders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'],
      statusDescription: json['statusDescription'],
      orders: (json['orders'] as List)
          .map((order) => Order.fromJson(order))
          .toList(),
    );
  }
}

class Order {
  final String id;
  final String soNumber;
  final String orderId;
  final String createdBy;
  final DateTime createdDateTime;

  Order({
    required this.id,
    required this.soNumber,
    required this.orderId,
    required this.createdBy,
    required this.createdDateTime,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      soNumber: json['soNumber'],
      orderId: json['orderId'],
      createdBy: json['createdBy'],
      createdDateTime: DateTime.parse(json['createdDateTime']),
    );
  }
}
