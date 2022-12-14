class SanaliraModel {
  SanaliraModel({
    required this.response,
    required this.data,
  });
  late final Response response;
  late final List<BankData> data;

  SanaliraModel.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response']);
    data = List.from(json['data']).map((e) => BankData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['response'] = response.toJson();
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Response {
  Response({
    required this.code,
    required this.message,
  });
  late final int code;
  late final String message;

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}

class BankData {
  BankData({
    required this.bankName,
    required this.bankIban,
    required this.bankAccountName,
    required this.descriptionNo,
  });
  late final String bankName;
  late final String bankIban;
  late final String bankAccountName;
  late final String descriptionNo;

  BankData.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    bankIban = json['bankIban'];
    bankAccountName = json['bankAccountName'];
    descriptionNo = json['descriptionNo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bankName'] = bankName;
    _data['bankIban'] = bankIban;
    _data['bankAccountName'] = bankAccountName;
    _data['descriptionNo'] = descriptionNo;
    return _data;
  }
}
