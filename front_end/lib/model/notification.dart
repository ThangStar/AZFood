class Notification {
  final int id;
  final String content;
  final String assetImage;
  final bool opened;
  final String date;

  Notification(
      {required this.id,
      required this.content,
      required this.assetImage,
      required this.date,
      required this.opened});
}
