import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllUserModel {
  bool? status;
  String? message;
  List<Users>? users;
  int? totalCount;
  int? totalPages;
  int? currentPage;

  GetAllUserModel(
      {this.status,
        this.message,
        this.users,
        this.totalCount,
        this.totalPages,
        this.currentPage});

  GetAllUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? phone;
  String? email;
  bool? status;
  String? password;
  String? createdAt;
  String? updatedAt;
  bool? isPremium;

  Users(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.isPremium});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isPremium'] = this.isPremium;
    return data;
  }
}

class User{

  String? userId;
  String? aadharNo;
  String? area;
  String? bloodGroup;
  String? city;
  DateTime? dob;
  String? fName;
  String? lName;
  String? mName;
  String? gender;
  String? image;
  String? phone;
  bool? isVerified;
  String? code;

  User(
      {
     this.userId,
     this.aadharNo,
     this.area,
     this.bloodGroup,
     this.city,
     this.dob,
     this.fName,
     this.lName,
     this.mName,
     this.gender,
     this.image,
     this.phone,
     this.isVerified,
     this.code,
});

  User.fromJson(Map<String, dynamic> json) {
   userId = json['user_id'];
   aadharNo  = json['aadhar_no'];
   area  = json['area'];
   bloodGroup = json['blood_group'];
   city = json['city'];
   dob= json['date_of_birth'];
   fName = json['first_name'];
   lName = json['last_name'];
   mName = json['middle_name'];
  gender = json['gender'];
  image = json['image'];
  phone = json['phone_number'];
  isVerified = json['is_verified'];
  code = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['aadhar_no'] = this.aadharNo;
    data['blood_group'] = this.bloodGroup;
    data['city'] = this.city;
    data['date_of_birth'] = this.dob;
    data['first_name'] = this.fName;
    data['last_name'] = this.lName;
    data['middle_name'] = this.mName;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['phone_number'] = this.phone;
    data['is_verified'] = this.isVerified;
    data['referral_code'] = this.code;
    return data;
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return User(
      userId: data?['user_id'],
      aadharNo: data?['aadhar_no'],
      area: data?['area'],
      bloodGroup: data?['blood_group'],
      city: data?['city'],
      dob: (data?['date_of_birth'] as Timestamp?)?.toDate(),
      fName: data?['first_name'],
      lName: data?['last_name'],
      mName: data?['middle_name'],
      gender: data?['gender'],
      image: data?['image'],
      phone: data?['phone_number'],
      isVerified: data?['is_verified'],
      code: data?['referral_code'],
    );
  }
}