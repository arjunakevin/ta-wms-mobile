class MovementOrder {
  late int id;
  late String reference;
  late String documentableType;
  late int documentableId;
  late String date;
  late String createdAt;
  late String updatedAt;
  late String dateFormatted;

  MovementOrder({
    required this.id,
    required this.reference,
    required this.documentableType,
    required this.documentableId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.dateFormatted
  });

  MovementOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    documentableType = json['documentable_type'];
    documentableId = json['documentable_id'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateFormatted = json['date_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['documentable_type'] = this.documentableType;
    data['documentable_id'] = this.documentableId;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date_formatted'] = this.dateFormatted;
    return data;
  }
}
