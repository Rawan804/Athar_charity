class MyNotification {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final bool isUrgent;
  final DateTime createdAt;
  final String status;
  final String submittedAt;
  final String targetName; // جديد
  final double amount;
  MyNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.isUrgent,
    required this.status,
    required this.submittedAt,
    required this.targetName,
    required this.amount
  });

  factory MyNotification.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final extra = data['extra'] ?? {};

    return MyNotification(
      id: json['id'] ?? '',
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      isUrgent: extra['is_urgent'] ?? false,
      status: extra['status'] ?? '',
      submittedAt: extra['submitted_at'] ?? '',
      targetName: extra['target_name'] ?? '',
      amount: double.tryParse(extra['amount'].toString()) ?? 0.0,

      isRead: json['read_at'] != null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

}
