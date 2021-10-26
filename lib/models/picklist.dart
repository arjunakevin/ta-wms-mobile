class Picklist {
  late int id;
  late String reference;
  late String date;
  late String clientCode;
  late List<Outstanding> outstanding;

  Picklist({
    required this.id,
    required this.reference,
    required this.date,
    required this.clientCode,
    required this.outstanding
  });

  Picklist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    date = json['date'];
    clientCode = json['client_code'];
    if (json['outstanding'] != null) {
      outstanding = <Outstanding>[];
      json['outstanding'].forEach((v) {
        outstanding.add(Outstanding.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['date'] = this.date;
    data['client_code'] = this.clientCode;
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
  late String locationCode;

  Outstanding({
    required this.productCode,
    required this.description,
    required this.baseQuantity,
    required this.locationCode
  });

  Outstanding.fromJson(Map<String, dynamic> json) {
    productCode = json['product_code'];
    description = json['description'];
    baseQuantity = json['base_quantity'];
    locationCode = json['location_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_code'] = this.productCode;
    data['description'] = this.description;
    data['base_quantity'] = this.baseQuantity;
    data['location_code'] = this.locationCode;
    return data;
  }
}
