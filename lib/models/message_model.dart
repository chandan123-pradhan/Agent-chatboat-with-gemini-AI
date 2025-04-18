class MessageModel {
  final String text;
  final bool isMe;

  MessageModel({required this.text, required this.isMe});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isMe': isMe,
    };
  }

  factory MessageModel.fromJson(Map<dynamic, dynamic> json) {
    return MessageModel(
      text: json['text'],
      isMe: json['isMe'],
    );
  }
}
