//Ref : https://javiercbk.github.io/json_to_dart/

class DashboardModel {
  bool status;
  String message;
  List<Data> data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  int payStatus;
  List<PayScale> payScale;
  int recentAnnouncementCount;
  int unreadMessagesCount;
  List<RecentAnnouncements> recentAnnouncements;
  List<UnreadMessages> unreadMessages;

  Data(
      {this.payStatus,
      this.payScale,
      this.recentAnnouncementCount,
      this.unreadMessagesCount,
      this.recentAnnouncements,
      this.unreadMessages});

  Data.fromJson(Map<String, dynamic> json) {
    payStatus = json['payStatus'];
    if (json['payScale'] != null) {
      payScale = new List<PayScale>();
      json['payScale'].forEach((v) {
        payScale.add(new PayScale.fromJson(v));
      });
    }
    recentAnnouncementCount = json['recentAnnouncement_count'];
    unreadMessagesCount = json['unread_messages_count'];
    if (json['recentAnnouncements'] != null) {
      recentAnnouncements = new List<RecentAnnouncements>();
      json['recentAnnouncements'].forEach((v) {
        recentAnnouncements.add(new RecentAnnouncements.fromJson(v));
      });
    }
    if (json['unreadMessages'] != null) {
      unreadMessages = new List<UnreadMessages>();
      json['unreadMessages'].forEach((v) {
        unreadMessages.add(new UnreadMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payStatus'] = this.payStatus;
    if (this.payScale != null) {
      data['payScale'] = this.payScale.map((v) => v.toJson()).toList();
    }
    data['recentAnnouncement_count'] = this.recentAnnouncementCount;
    data['unread_messages_count'] = this.unreadMessagesCount;
    if (this.recentAnnouncements != null) {
      data['recentAnnouncements'] =
          this.recentAnnouncements.map((v) => v.toJson()).toList();
    }
    if (this.unreadMessages != null) {
      data['unreadMessages'] =
          this.unreadMessages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayScale {
  String scale;
  String value;

  PayScale({this.scale, this.value});

  PayScale.fromJson(Map<String, dynamic> json) {
    scale = json['scale'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scale'] = this.scale;
    data['value'] = this.value;
    return data;
  }
}

class RecentAnnouncements {
  String avatarURL;
  String username;
  int userId;
  String messageBody;
  int messageType;
  String createdTime;

  RecentAnnouncements(
      {this.avatarURL,
      this.username,
      this.userId,
      this.messageBody,
      this.messageType,
      this.createdTime});

  RecentAnnouncements.fromJson(Map<String, dynamic> json) {
    avatarURL = json['avatarURL'];
    username = json['username'];
    userId = json['userId'];
    messageBody = json['messageBody'];
    messageType = json['messageType'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarURL'] = this.avatarURL;
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['messageBody'] = this.messageBody;
    data['messageType'] = this.messageType;
    data['createdTime'] = this.createdTime;
    return data;
  }
}

class UnreadMessages {
  int type;
  String avatarURL;
  String body;
  int fromUserId;
  String fromUserName;
  String time;
  String subject;

  UnreadMessages(
      {this.type,
      this.avatarURL,
      this.body,
      this.fromUserId,
      this.fromUserName,
      this.time,
      this.subject});

  UnreadMessages.fromJson(Map<String, dynamic> json) {
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
