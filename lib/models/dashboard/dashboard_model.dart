
class ChartData {
  ChartData({ required this.x, required this.y});

  final String x;

  int y;
}

class DashBoardModel {
  bool? status;
  String? message;
  Dashboard? dashboard;
  List<LatestUsers>? latestUsers;
  List<UsersActivities>? usersActivities;

  DashBoardModel(
      {this.status,
        this.message,
        this.dashboard,
        this.latestUsers,
        this.usersActivities});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dashboard = json['dashboard'] != null
        ? new Dashboard.fromJson(json['dashboard'])
        : null;
    if (json['latestUsers'] != null) {
      latestUsers = <LatestUsers>[];
      json['latestUsers'].forEach((v) {
        latestUsers!.add(new LatestUsers.fromJson(v));
      });
    }
    if (json['usersActivities'] != null) {
      usersActivities = <UsersActivities>[];
      json['usersActivities'].forEach((v) {
        usersActivities!.add(new UsersActivities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.toJson();
    }
    if (this.latestUsers != null) {
      data['latestUsers'] = this.latestUsers!.map((v) => v.toJson()).toList();
    }
    if (this.usersActivities != null) {
      data['usersActivities'] =
          this.usersActivities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  int? listOfUsers;
  int? paidSubscriber;
  int? salesFromSubs;
  int? salesFromEcom;

  Dashboard(
      {this.listOfUsers,
        this.paidSubscriber,
        this.salesFromSubs,
        this.salesFromEcom});

  Dashboard.fromJson(Map<String, dynamic> json) {
    listOfUsers = json['listOfUsers'];
    paidSubscriber = json['paidSubscriber'];
    salesFromSubs = json['salesFromSubs'];
    salesFromEcom = json['salesFromEcom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listOfUsers'] = this.listOfUsers;
    data['paidSubscriber'] = this.paidSubscriber;
    data['salesFromSubs'] = this.salesFromSubs;
    data['salesFromEcom'] = this.salesFromEcom;
    return data;
  }
}

class LatestUsers {
  int? id;
  String? name;
  String? phone;
  String? email;
  bool? status;
  String? password;
  String? createdAt;
  String? updatedAt;

  LatestUsers(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.password,
        this.createdAt,
        this.updatedAt});

  LatestUsers.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class UsersActivities {
  String? month;
  int? count;

  UsersActivities({this.month, this.count});

  UsersActivities.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['count'] = this.count;
    return data;
  }
}


class DashBoardHeader{
  String? image;
  String? heading;
  String? numbers;
  String? percentage;
  DashBoardHeader({required this.image,required this.heading,required this.numbers,required this.percentage});
}
