class GetUserDetailModel {
  bool? status;
  String? message;
  UserDetail? userDetail;
  List<SubscriptionHistory>? subscriptionHistory;

  GetUserDetailModel(
      {this.status, this.message, this.userDetail, this.subscriptionHistory});

  GetUserDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetail = json['user'] != null ? UserDetail.fromJson(json['user']) : null;
    if (json['subscriptionHistory'] != null) {
      subscriptionHistory = <SubscriptionHistory>[];
      json['subscriptionHistory'].forEach((v) {
        subscriptionHistory!.add(SubscriptionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userDetail != null) {
      data['user'] = userDetail!.toJson();
    }
    if (subscriptionHistory != null) {
      data['subscriptionHistory'] =
          subscriptionHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetail {
  int? id;
  String? name;
  String? phone;
  String? email;
  bool? status;
  String? password;
  String? createdAt;
  String? updatedAt;

  UserDetail(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.password,
        this.createdAt,
        this.updatedAt});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['status'] = status;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SubscriptionHistory {
  int? id;
  int? userId;
  int? planId;
  String? orderId;
  bool? status;
  String? purchasedAt;
  String? expireOn;
  String? createdAt;
  String? updatedAt;
  String? price;

  SubscriptionHistory(
      {this.id,
        this.userId,
        this.planId,
        this.orderId,
        this.status,
        this.purchasedAt,
        this.expireOn,
        this.createdAt,
        this.updatedAt,
        this.price});

  SubscriptionHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    planId = json['planId'];
    orderId = json['orderId'];
    status = json['status'];
    purchasedAt = json['purchasedAt'];
    expireOn = json['expireOn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['planId'] = planId;
    data['orderId'] = orderId;
    data['status'] = status;
    data['purchasedAt'] = purchasedAt;
    data['expireOn'] = expireOn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['price'] = price;
    return data;
  }
}
