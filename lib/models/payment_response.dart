class PaymentResponse {
  int? status;
  List<PaymentMethod>? data;

  PaymentResponse({this.status, this.data});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <PaymentMethod>[];
      json['Data'].forEach((v) {
        data!.add(PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethod {
  String? id;
  String? name;
  String? imagePath;
  bool? isWeb;
  bool? isMobile;
  bool? isHIMS;
  String? description;
  int? paymentMethodValue;

  PaymentMethod(
      {this.id,
      this.name,
      this.imagePath,
      this.isWeb,
      this.isMobile,
      this.isHIMS,
      this.description,
      this.paymentMethodValue});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    imagePath = json['ImagePath'];
    isWeb = json['IsWeb'];
    isMobile = json['IsMobile'];
    isHIMS = json['IsHIMS'];
    description = json['Description'];
    paymentMethodValue = json['PaymentMethodValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['ImagePath'] = imagePath;
    data['IsWeb'] = isWeb;
    data['IsMobile'] = isMobile;
    data['IsHIMS'] = isHIMS;
    data['Description'] = description;
    data['PaymentMethodValue'] = paymentMethodValue;
    return data;
  }
}
