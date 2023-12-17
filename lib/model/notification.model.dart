class NotificationModel {
  int? id;
  String? to;
   String? from;
  String? content;
  String? type;
  bool? read;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.to,
    this.from,
    this.content,
    this.type,
    this.read,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        to: json["to"],
        from: json["from"],
        content: json["content"],
        type: json["type"],
        read: json["read"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "to": to,
        "from": from,
        "content": content,
        "type": type,
        "read": read,
        "createdAt": createdAt?.toIso8601String(),
      };
}
