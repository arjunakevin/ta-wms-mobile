class GoodReceive {
  late int id;
  late String reference;
  late String clientCode;
  late String status;
  late String notes;
  late List<Outstanding> outstanding;

  GoodReceive({
    required this.id,
    required this.reference,
    required this.clientCode,
    required this.status,
    required this.notes,
    required this.outstanding
  });

  GoodReceive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    clientCode = json['client_code'];
    status = json['status'];
    notes = json['notes'];
    if (json['outstanding'] != null) {
      outstanding = <Outstanding>[];
      json['outstanding'].forEach((v) {
        outstanding.add(Outstanding.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['client_code'] = this.clientCode;
    data['status'] = this.status;
    data['notes'] = this.notes;
    if (this.outstanding != null) {
      data['outstanding'] = this.outstanding.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outstanding {
  late String productCode;
  late String description;
  late String baseQuantity;

  Outstanding({
    required this.productCode,
    required this.description,
    required this.baseQuantity
  });

  Outstanding.fromJson(Map<String, dynamic> json) {
    productCode = json['product_code'];
    description = json['description'];
    baseQuantity = json['base_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_code'] = this.productCode;
    data['description'] = this.description;
    data['base_quantity'] = this.baseQuantity;
    return data;
  }
}
