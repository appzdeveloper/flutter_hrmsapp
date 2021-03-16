class ChatModel {
  bool status;
  String message;
  List<ChatData> data;

  ChatModel({this.status, this.message, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<ChatData>();
      json['data'].forEach((v) {
        data.add(new ChatData.fromJson(v));
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

class ChatData {
  int type;
  String avatarURL;
  String body;
  int fromUserId;
  String fromUserName;
  String time;
  String subject;

  ChatData(
      {this.type,
      this.avatarURL,
      this.body,
      this.fromUserId,
      this.fromUserName,
      this.time,
      this.subject});

  ChatData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    avatarURL = json['avatarURL'];
    body = json['body'];
    fromUserId = json['fromUserId'];
    fromUserName = json['fromUserName'];
    time = json['time'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['avatarURL'] = this.avatarURL;
    data['body'] = this.body;
    data['fromUserId'] = this.fromUserId;
    data['fromUserName'] = this.fromUserName;
    data['time'] = this.time;
    data['subject'] = this.subject;
    return data;
  }
}
