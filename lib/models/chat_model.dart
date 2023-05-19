class ChatModel {
  String chatMsg;
  int index;
  ChatModel({required this.chatMsg, required this.index});

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(chatMsg: json["msg"], index: json["chatIndex"]);
}
