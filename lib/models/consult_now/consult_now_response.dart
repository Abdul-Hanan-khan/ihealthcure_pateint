class ConsultNowResponse {
  int? status;
  String? errorMessage;
  Data? data;

  ConsultNowResponse({this.status, this.errorMessage, this.data});

  ConsultNowResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    data = json['Data'] != null ?  Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? merchantID;
  String? password;
  String? integeritySalt;
  String? returnURL;
  String? environment;
  String? postURL;
  String? amount;
  String? bankID;
  String? productID;
  String? billReference;
  String? description;
  String? language;
  String? txnCurrency;
  String? txnRefNumber;
  String? txnDateTime;
  String? txnExpiryDateTime;
  String? txnType;
  String? version;
  String? subMerchantID;
  String? discountedAmount;
  String? discountedBank;
  String? ppmpf1;
  String? ppmpf2;
  String? ppmpf3;
  String? ppmpf4;
  String? ppmpf5;
  String? secureHash;
  String? ppCustomerID;
  String? ppCustomerEmail;
  String? ppCustomerMobile;

  Data(
      {this.merchantID,
      this.password,
      this.integeritySalt,
      this.returnURL,
      this.environment,
      this.postURL,
      this.amount,
      this.bankID,
      this.productID,
      this.billReference,
      this.description,
      this.language,
      this.txnCurrency,
      this.txnRefNumber,
      this.txnDateTime,
      this.txnExpiryDateTime,
      this.txnType,
      this.version,
      this.subMerchantID,
      this.discountedAmount,
      this.discountedBank,
      this.ppmpf1,
      this.ppmpf2,
      this.ppmpf3,
      this.ppmpf4,
      this.ppmpf5,
      this.secureHash,
      this.ppCustomerID,
      this.ppCustomerEmail,
      this.ppCustomerMobile});

  Data.fromJson(Map<String, dynamic> json) {
    merchantID = json['MerchantID'];
    password = json['Password'];
    integeritySalt = json['IntegeritySalt'];
    returnURL = json['ReturnURL'];
    environment = json['Environment'];
    postURL = json['PostURL'];
    amount = json['Amount'];
    bankID = json['BankID'];
    productID = json['ProductID'];
    billReference = json['BillReference'];
    description = json['Description'];
    language = json['Language'];
    txnCurrency = json['TxnCurrency'];
    txnRefNumber = json['TxnRefNumber'];
    txnDateTime = json['TxnDateTime'];
    txnExpiryDateTime = json['TxnExpiryDateTime'];
    txnType = json['TxnType'];
    version = json['Version'];
    subMerchantID = json['SubMerchantID'];
    discountedAmount = json['DiscountedAmount'];
    discountedBank = json['DiscountedBank'];
    ppmpf1 = json['ppmpf_1'];
    ppmpf2 = json['ppmpf_2'];
    ppmpf3 = json['ppmpf_3'];
    ppmpf4 = json['ppmpf_4'];
    ppmpf5 = json['ppmpf_5'];
    secureHash = json['SecureHash'];
    ppCustomerID = json['pp_CustomerID'];
    ppCustomerEmail = json['pp_CustomerEmail'];
    ppCustomerMobile = json['pp_CustomerMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MerchantID'] = merchantID;
    data['Password'] = password;
    data['IntegeritySalt'] = integeritySalt;
    data['ReturnURL'] = returnURL;
    data['Environment'] = environment;
    data['PostURL'] = postURL;
    data['Amount'] = amount;
    data['BankID'] = bankID;
    data['ProductID'] = productID;
    data['BillReference'] = billReference;
    data['Description'] = description;
    data['Language'] = language;
    data['TxnCurrency'] = txnCurrency;
    data['TxnRefNumber'] = txnRefNumber;
    data['TxnDateTime'] = txnDateTime;
    data['TxnExpiryDateTime'] = txnExpiryDateTime;
    data['TxnType'] = txnType;
    data['Version'] = version;
    data['SubMerchantID'] = subMerchantID;
    data['DiscountedAmount'] = discountedAmount;
    data['DiscountedBank'] = discountedBank;
    data['ppmpf_1'] = ppmpf1;
    data['ppmpf_2'] = ppmpf2;
    data['ppmpf_3'] = ppmpf3;
    data['ppmpf_4'] = ppmpf4;
    data['ppmpf_5'] = ppmpf5;
    data['SecureHash'] = secureHash;
    data['pp_CustomerID'] = ppCustomerID;
    data['pp_CustomerEmail'] = ppCustomerEmail;
    data['pp_CustomerMobile'] = ppCustomerMobile;
    return data;
  }
}