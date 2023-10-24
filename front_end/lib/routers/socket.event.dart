class SocketEvent {
  //from client
  static String sendMsgToGroup = "client-msg-group";
  static String typingGroup = "client-msg-typing-group";
  static String typedGroup = "client-msg-typed-group";
  static String initialMessage = 'client-msg-init-group';

  //from sever
  static String onMsgGroup = "sever-msg-group";
  static String onMsgTypingGroup = "sever-msg-typing-group";
  static String onMsgTypedGroup = "sever-msg-typed-group";
  static String onInitialMessage = 'sever-msg-init-group';

  static String onNotiMsgGroup = "sever-msg-noti";
}
