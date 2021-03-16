class MessageModel {
  bool status;
  String message;
  List<Data> data;

  MessageModel({this.status, this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool isOnline;
  int userId;
  String username;
  String avatarURL;
  int messageType;
  String messageBody;
  String sentTime;
  bool isRead;
  int messageCount;

  Data(
      {this.isOnline,
      this.userId,
      this.username,
      this.avatarURL,
      this.messageType,
      this.messageBody,
      this.sentTime,
      this.isRead,
      this.messageCount});

  Data.fromJson(Map<String, dynamic> json) {
    isOnline = json['isOnline'];
    userId = json['userId'];
    username = json['username'];
    avatarURL = json['avatarURL'];
    messageType = json['messageType'];
    messageBody = json['messageBody'];
    sentTime = json['sentTime'];
    isRead = json['isRead'];
    messageCount = json['messageCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnline'] = this.isOnline;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['avatarURL'] = this.avatarURL;
    data['messageType'] = this.messageType;
    data['messageBody'] = this.messageBody;
    data['sentTime'] = this.sentTime;
    data['isRead'] = this.isRead;
    data['messageCount'] = this.messageCount;
    return data;
  }
}