// ignore_for_file: file_names
class Getinstallation {
  List<Message>? message;

  Getinstallation({this.message});

  Getinstallation.fromJson(Map<String, dynamic> json) {
    if (json['Message'] != null) {
      message = <Message>[];
      json['Message'].forEach((v) {
        message!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['Message'] = message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? message;

  Message({this.message});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
