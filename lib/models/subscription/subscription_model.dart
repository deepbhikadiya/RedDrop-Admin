class SubscriptionModel {
  bool? status;
  String? message;
  List<Plans>? plans;

  SubscriptionModel({this.status, this.message, this.plans});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  int? id;
  String? image;
  String? title;
  List<String>? benefits;
  String? durationTitle;
  String? duration;
  String? price;
  String? finalPrice;
  String? savePercent;
  String? createdAt;
  String? updatedAt;

  Plans(
      {this.id,
        this.image,
        this.title,
        this.benefits,
        this.durationTitle,
        this.duration,
        this.price,
        this.finalPrice,
        this.savePercent,
        this.createdAt,
        this.updatedAt});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    benefits = json['benefits'].cast<String>();
    durationTitle = json['durationTitle'];
    duration = json['duration'].toString();
    price = json['price'].toString();
    finalPrice = json['finalPrice'].toString();
    savePercent = json['savePercent'].toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['benefits'] = this.benefits;
    data['durationTitle'] = this.durationTitle;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['finalPrice'] = this.finalPrice;
    data['savePercent'] = this.savePercent;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
