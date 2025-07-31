class NotificationModel {
  final int id;
  final String message;
  final bool isRead;
  final String type;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.message,
    required this.isRead,
    required this.type,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'],
      isRead: json['is_read'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}