class TransferModel {
    int? id;
    String? from;
    String? to;
    String? sender;
    String? receiver;
    String? meal;
    DateTime? createdAt;

    TransferModel({
        this.id,
        this.from,
        this.to,
        this.sender,
        this.receiver,
        this.meal,
        this.createdAt,
    });

    factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        sender: json["sender"],
        receiver: json["receiver"],
        meal: json["meal"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "sender": sender,
        "receiver": receiver,
        "meal": meal,
        "createdAt": createdAt?.toIso8601String(),
    };
}
