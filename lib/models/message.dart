class Message{
  String text;
  String date;
  bool isSentByMe;

  Message(
      this.text,
      this.date,
      this.isSentByMe,
      );

  static List<Message> generatePatient(){
    return[
      Message('Hola',DateTime.now().subtract(Duration(minutes: 1)).toString(),false),
      Message('Hola',DateTime.now().subtract(Duration(minutes: 1)).toString(),true),

    ];
  }

}