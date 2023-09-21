import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class AppTheme {
  final Color? appBarColor;
  final Color? backArrowColor;
  final Color? backgroundColor;
  final Color? replyDialogColor;
  final Color? replyTitleColor;
  final Color? textFieldBackgroundColor;

  final Color? outgoingChatBubbleColor;

  final Color? inComingChatBubbleColor;

  final Color? inComingChatBubbleTextColor;
  final Color? repliedMessageColor;
  final Color? repliedTitleTextColor;
  final Color? textFieldTextColor;

  final Color? closeIconColor;
  final Color? shareIconBackgroundColor;

  final Color? sendButtonColor;
  final Color? cameraIconColor;
  final Color? galleryIconColor;
  final Color? recordIconColor;
  final Color? stopIconColor;
  final Color? swipeToReplyIconColor;
  final Color? replyMessageColor;
  final Color? appBarTitleTextStyle;
  final Color? messageReactionBackGroundColor;
  final Color? messageTimeIconColor;
  final Color? messageTimeTextColor;
  final Color? reactionPopupColor;
  final Color? replyPopupColor;
  final Color? replyPopupButtonColor;
  final Color? replyPopupTopBorderColor;
  final Color? reactionPopupTitleColor;
  final Color? flashingCircleDarkColor;
  final Color? flashingCircleBrightColor;
  final Color? waveformBackgroundColor;
  final Color? waveColor;
  final Color? replyMicIconColor;
  final Color? messageReactionBorderColor;

  final Color? verticalBarColor;
  final Color? chatHeaderColor;
  final Color? themeIconColor;
  final Color? shareIconColor;
  final double? elevation;
  final Color? linkPreviewIncomingChatColor;
  final Color? linkPreviewOutgoingChatColor;
  final TextStyle? linkPreviewIncomingTitleStyle;
  final TextStyle? linkPreviewOutgoingTitleStyle;
  final TextStyle? incomingChatLinkTitleStyle;
  final TextStyle? outgoingChatLinkTitleStyle;
  final TextStyle? outgoingChatLinkBodyStyle;
  final TextStyle? incomingChatLinkBodyStyle;

  AppTheme({
    this.cameraIconColor,
    this.galleryIconColor,
    this.flashingCircleDarkColor,
    this.flashingCircleBrightColor,
    this.outgoingChatLinkBodyStyle,
    this.incomingChatLinkBodyStyle,
    this.incomingChatLinkTitleStyle,
    this.outgoingChatLinkTitleStyle,
    this.linkPreviewOutgoingChatColor,
    this.linkPreviewIncomingChatColor,
    this.linkPreviewIncomingTitleStyle,
    this.linkPreviewOutgoingTitleStyle,
    this.repliedTitleTextColor,
    this.swipeToReplyIconColor,
    this.textFieldTextColor,
    this.reactionPopupColor,
    this.replyPopupButtonColor,
    this.replyPopupTopBorderColor,
    this.reactionPopupTitleColor,
    this.appBarColor,
    this.backArrowColor,
    this.backgroundColor,
    this.replyDialogColor,
    this.replyTitleColor,
    this.textFieldBackgroundColor,
    this.outgoingChatBubbleColor,
    this.inComingChatBubbleColor,
    this.inComingChatBubbleTextColor,
    this.repliedMessageColor,
    this.closeIconColor,
    this.shareIconBackgroundColor,
    this.sendButtonColor,
    this.replyMessageColor,
    this.appBarTitleTextStyle,
    this.messageReactionBackGroundColor,
    this.messageReactionBorderColor,
    this.verticalBarColor,
    this.chatHeaderColor,
    this.themeIconColor,
    this.shareIconColor,
    this.elevation,
    this.messageTimeIconColor,
    this.messageTimeTextColor,
    this.replyPopupColor,
    this.recordIconColor,
    this.stopIconColor,
    this.waveformBackgroundColor,
    this.waveColor,
    this.replyMicIconColor,
  });
}

class DarkTheme extends AppTheme {
  DarkTheme({
    Color flashingCircleDarkColor = Colors.grey,
    Color flashingCircleBrightColor = const Color(0xffeeeeee),
    TextStyle incomingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkTitleStyle = const TextStyle(color: Colors.white),
    TextStyle outgoingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    TextStyle incomingChatLinkBodyStyle = const TextStyle(color: Colors.white),
    double elevation = 1,
    Color repliedTitleTextColor = Colors.white,
    Color? swipeToReplyIconColor = Colors.white,
    Color textFieldTextColor = Colors.white,
    Color appBarColor = const Color(0xff1d1b25),
    Color backArrowColor = Colors.white,
    Color backgroundColor = const Color(0xff272336),
    Color replyDialogColor = const Color(0xff272336),
    Color linkPreviewOutgoingChatColor = const Color(0xff272336),
    Color linkPreviewIncomingChatColor = const Color(0xff9f85ff),
    TextStyle linkPreviewIncomingTitleStyle = const TextStyle(),
    TextStyle linkPreviewOutgoingTitleStyle = const TextStyle(),
    Color replyTitleColor = Colors.white,
    Color textFieldBackgroundColor = const Color(0xff383152),
    Color outgoingChatBubbleColor = const Color(0xff9f85ff),
    Color inComingChatBubbleColor = const Color(0xff383152),
    Color reactionPopupColor = const Color(0xff383152),
    Color replyPopupColor = const Color(0xff383152),
    Color replyPopupButtonColor = Colors.white,
    Color replyPopupTopBorderColor = Colors.black54,
    Color reactionPopupTitleColor = Colors.white,
    Color inComingChatBubbleTextColor = Colors.white,
    Color repliedMessageColor = const Color(0xff9f85ff),
    Color closeIconColor = Colors.white,
    Color shareIconBackgroundColor = const Color(0xff383152),
    Color sendButtonColor = Colors.white,
    Color cameraIconColor = const Color(0xff757575),
    Color galleryIconColor = const Color(0xff757575),
    Color recorderIconColor = const Color(0xff757575),
    Color stopIconColor = const Color(0xff757575),
    Color replyMessageColor = Colors.grey,
    Color appBarTitleTextStyle = Colors.white,
    Color messageReactionBackGroundColor = const Color(0xff383152),
    Color messageReactionBorderColor = const Color(0xff272336),
    Color verticalBarColor = const Color(0xff383152),
    Color chatHeaderColor = Colors.white,
    Color themeIconColor = Colors.white,
    Color shareIconColor = Colors.white,
    Color messageTimeIconColor = Colors.white,
    Color messageTimeTextColor = Colors.white,
    Color waveformBackgroundColor = const Color(0xff383152),
    Color waveColor = Colors.white,
    Color replyMicIconColor = Colors.white,
  }) : super(
          closeIconColor: closeIconColor,
          verticalBarColor: verticalBarColor,
          textFieldBackgroundColor: textFieldBackgroundColor,
          replyTitleColor: replyTitleColor,
          replyDialogColor: replyDialogColor,
          backgroundColor: backgroundColor,
          appBarColor: appBarColor,
          appBarTitleTextStyle: appBarTitleTextStyle,
          backArrowColor: backArrowColor,
          chatHeaderColor: chatHeaderColor,
          inComingChatBubbleColor: inComingChatBubbleColor,
          inComingChatBubbleTextColor: inComingChatBubbleTextColor,
          messageReactionBackGroundColor: messageReactionBackGroundColor,
          messageReactionBorderColor: messageReactionBorderColor,
          outgoingChatBubbleColor: outgoingChatBubbleColor,
          repliedMessageColor: repliedMessageColor,
          replyMessageColor: replyMessageColor,
          sendButtonColor: sendButtonColor,
          shareIconBackgroundColor: shareIconBackgroundColor,
          themeIconColor: themeIconColor,
          shareIconColor: shareIconColor,
          elevation: elevation,
          messageTimeIconColor: messageTimeIconColor,
          messageTimeTextColor: messageTimeTextColor,
          textFieldTextColor: textFieldTextColor,
          repliedTitleTextColor: repliedTitleTextColor,
          swipeToReplyIconColor: swipeToReplyIconColor,
          reactionPopupColor: reactionPopupColor,
          replyPopupColor: replyPopupColor,
          replyPopupButtonColor: replyPopupButtonColor,
          replyPopupTopBorderColor: replyPopupTopBorderColor,
          reactionPopupTitleColor: reactionPopupTitleColor,
          linkPreviewOutgoingChatColor: linkPreviewOutgoingChatColor,
          linkPreviewIncomingChatColor: linkPreviewIncomingChatColor,
          linkPreviewIncomingTitleStyle: linkPreviewIncomingTitleStyle,
          linkPreviewOutgoingTitleStyle: linkPreviewOutgoingTitleStyle,
          incomingChatLinkBodyStyle: incomingChatLinkBodyStyle,
          incomingChatLinkTitleStyle: incomingChatLinkTitleStyle,
          outgoingChatLinkBodyStyle: outgoingChatLinkBodyStyle,
          outgoingChatLinkTitleStyle: outgoingChatLinkTitleStyle,
          flashingCircleDarkColor: flashingCircleDarkColor,
          flashingCircleBrightColor: flashingCircleBrightColor,
          galleryIconColor: galleryIconColor,
          cameraIconColor: cameraIconColor,
          recordIconColor: recorderIconColor,
          stopIconColor: stopIconColor,
          waveformBackgroundColor: waveformBackgroundColor,
          waveColor: waveColor,
          replyMicIconColor: replyMicIconColor,
        );
}

class LightTheme extends AppTheme {
  LightTheme({
    Color flashingCircleDarkColor = const Color(0xffEE5366),
    Color flashingCircleBrightColor = const Color(0xffFCD8DC),
    TextStyle incomingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkTitleStyle = const TextStyle(color: Colors.black),
    TextStyle outgoingChatLinkBodyStyle = const TextStyle(color: Colors.grey),
    TextStyle incomingChatLinkBodyStyle = const TextStyle(color: Colors.grey),
    Color textFieldTextColor = Colors.black,
    Color repliedTitleTextColor = Colors.black,
    Color swipeToReplyIconColor = Colors.black,
    double elevation = 2,
    Color appBarColor = Colors.white,
    Color backArrowColor = const Color(0xffEE5366),
    Color backgroundColor = const Color(0xffeeeeee),
    Color replyDialogColor = const Color(0xffFCD8DC),
    Color linkPreviewOutgoingChatColor = const Color(0xffFCD8DC),
    Color linkPreviewIncomingChatColor = const Color(0xFFEEEEEE),
    TextStyle linkPreviewIncomingTitleStyle = const TextStyle(),
    TextStyle linkPreviewOutgoingTitleStyle = const TextStyle(),
    Color replyTitleColor = const Color(0xffEE5366),
    Color reactionPopupColor = Colors.white,
    Color replyPopupColor = Colors.white,
    Color replyPopupButtonColor = Colors.black,
    Color replyPopupTopBorderColor = const Color(0xFFBDBDBD),
    Color reactionPopupTitleColor = Colors.grey,
    Color textFieldBackgroundColor = Colors.white,
    Color outgoingChatBubbleColor = const Color(0xffEE5366),
    Color inComingChatBubbleColor = Colors.white,
    Color inComingChatBubbleTextColor = Colors.black,
    Color repliedMessageColor = const Color(0xffff8aad),
    Color closeIconColor = Colors.black,
    Color shareIconBackgroundColor = const Color(0xFFE0E0E0),
    Color sendButtonColor = const Color(0xffEE5366),
    Color cameraIconColor = Colors.black,
    Color galleryIconColor = Colors.black,
    Color replyMessageColor = Colors.black,
    Color appBarTitleTextStyle = Colors.black,
    Color messageReactionBackGroundColor = const Color(0xFFEEEEEE),
    Color messageReactionBorderColor = Colors.white,
    Color verticalBarColor = const Color(0xffEE5366),
    Color chatHeaderColor = Colors.black,
    Color themeIconColor = Colors.black,
    Color shareIconColor = Colors.black,
    Color messageTimeIconColor = Colors.black,
    Color messageTimeTextColor = Colors.black,
    Color recorderIconColor = Colors.black,
    Color stopIconColor = Colors.black,
    Color waveformBackgroundColor = Colors.white,
    Color waveColor = Colors.black,
    Color replyMicIconColor = Colors.black,
  }) : super(
          reactionPopupColor: reactionPopupColor,
          closeIconColor: closeIconColor,
          verticalBarColor: verticalBarColor,
          textFieldBackgroundColor: textFieldBackgroundColor,
          replyTitleColor: replyTitleColor,
          replyDialogColor: replyDialogColor,
          backgroundColor: backgroundColor,
          appBarColor: appBarColor,
          appBarTitleTextStyle: appBarTitleTextStyle,
          backArrowColor: backArrowColor,
          chatHeaderColor: chatHeaderColor,
          inComingChatBubbleColor: inComingChatBubbleColor,
          inComingChatBubbleTextColor: inComingChatBubbleTextColor,
          messageReactionBackGroundColor: messageReactionBackGroundColor,
          messageReactionBorderColor: messageReactionBorderColor,
          outgoingChatBubbleColor: outgoingChatBubbleColor,
          repliedMessageColor: repliedMessageColor,
          replyMessageColor: replyMessageColor,
          sendButtonColor: sendButtonColor,
          shareIconBackgroundColor: shareIconBackgroundColor,
          themeIconColor: themeIconColor,
          shareIconColor: shareIconColor,
          elevation: elevation,
          messageTimeIconColor: messageTimeIconColor,
          messageTimeTextColor: messageTimeTextColor,
          textFieldTextColor: textFieldTextColor,
          repliedTitleTextColor: repliedTitleTextColor,
          swipeToReplyIconColor: swipeToReplyIconColor,
          replyPopupColor: replyPopupColor,
          replyPopupButtonColor: replyPopupButtonColor,
          replyPopupTopBorderColor: replyPopupTopBorderColor,
          reactionPopupTitleColor: reactionPopupTitleColor,
          linkPreviewOutgoingChatColor: linkPreviewOutgoingChatColor,
          linkPreviewIncomingChatColor: linkPreviewIncomingChatColor,
          linkPreviewIncomingTitleStyle: linkPreviewIncomingTitleStyle,
          linkPreviewOutgoingTitleStyle: linkPreviewOutgoingTitleStyle,
          incomingChatLinkBodyStyle: incomingChatLinkBodyStyle,
          incomingChatLinkTitleStyle: incomingChatLinkTitleStyle,
          outgoingChatLinkBodyStyle: outgoingChatLinkBodyStyle,
          outgoingChatLinkTitleStyle: outgoingChatLinkTitleStyle,
          flashingCircleDarkColor: flashingCircleDarkColor,
          flashingCircleBrightColor: flashingCircleBrightColor,
          galleryIconColor: galleryIconColor,
          cameraIconColor: cameraIconColor,
          stopIconColor: stopIconColor,
          recordIconColor: recorderIconColor,
          waveformBackgroundColor: waveformBackgroundColor,
          waveColor: waveColor,
          replyMicIconColor: replyMicIconColor,
        );
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, this.onClose}) : super(key: key);
  final VoidCallBack? onClose;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AppTheme theme = LightTheme();
  bool isDarkTheme = false;
  final currentUser = ChatUser(
    id: '1',
    name: 'Flutter',
    profilePhoto: Data.profileImage,
  );
  final _chatController = ChatController(
    initialMessageList: Data.messageList,
    scrollController: ScrollController(),
    chatUsers: [
      ChatUser(
        id: '2',
        name: 'Simform',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '3',
        name: 'Jhon',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '4',
        name: 'Mike',
        profilePhoto: Data.profileImage,
      ),
      ChatUser(
        id: '5',
        name: 'Rich',
        profilePhoto: Data.profileImage,
      ),
    ],
  );

  void _showHideTypingIndicator() {
    _chatController.setTypingIndicator = !_chatController.showTypingIndicator;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChatView(
        currentUser: currentUser,
        chatController: _chatController,
        onSendTap: _onSendTap,
        featureActiveConfig: const FeatureActiveConfig(
          lastSeenAgoBuilderVisibility: true,
          receiptsBuilderVisibility: true,
        ),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(
            loadingIndicatorColor: theme.outgoingChatBubbleColor,
          ),
          onReloadButtonTap: () {},
        ),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),
        appBar: ChatViewAppBar(
          leading: checkDevice(size.width, null, SizedBox.shrink(), SizedBox.shrink()) ,
          padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
          elevation: theme.elevation,
          backGroundColor: theme.appBarColor,
          profilePicture: Data.profileImage,
          backArrowColor: theme.backArrowColor,
          chatTitle: "Văn Thắng",
          chatTitleTextStyle: TextStyle(
            color: theme.appBarTitleTextStyle,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.25,
          ),
          userStatus: "đang hoạt động",
          userStatusTextStyle: const TextStyle(color: Colors.grey),
          actions: [
            IconButton(
              onPressed: _onThemeIconTap,
              icon: Icon(
                isDarkTheme
                    ? Icons.brightness_4_outlined
                    : Icons.dark_mode_outlined,
                color: theme.themeIconColor,
              ),
            ),
            IconButton(
              tooltip: 'Toggle TypingIndicator',
              onPressed: _showHideTypingIndicator,
              icon: Icon(
                Icons.keyboard,
                color: theme.themeIconColor,
              ),
            ),
            if(size.width > mobileWidth) IconButton(
              onPressed: widget.onClose,
              icon: Icon(
                Icons.close,
                color: theme.themeIconColor,
              ),
            ),
          ],
        ),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(
              color: theme.chatHeaderColor,
              fontSize: 17,
            ),
          ),
          backgroundColor: theme.backgroundColor,
        ),
        sendMessageConfig: SendMessageConfiguration(
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraIconColor: theme.cameraIconColor,
            galleryIconColor: theme.galleryIconColor,
          ),
          replyMessageColor: theme.replyMessageColor,
          defaultSendButtonColor: theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint("message status $status");
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: theme.textFieldTextColor),
          ),
          micIconColor: theme.replyMicIconColor,
          voiceRecordingConfiguration: VoiceRecordingConfiguration(
            backgroundColor: theme.waveformBackgroundColor,
            recorderIconColor: theme.recordIconColor,
            waveStyle: WaveStyle(
              showMiddleLine: false,
              waveColor: theme.waveColor ?? Colors.white,
              extendWaveform: true,
            ),
          ),
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              bodyStyle: theme.outgoingChatLinkBodyStyle,
              titleStyle: theme.outgoingChatLinkTitleStyle,
            ),
            receiptsWidgetConfig:
                const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
                decoration: TextDecoration.underline,
              ),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle,
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            color: theme.inComingChatBubbleColor,
          ),
        ),
        replyPopupConfig: ReplyPopupConfiguration(
          backgroundColor: theme.replyPopupColor,
          buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
          topBorderColor: theme.replyPopupTopBorderColor,
        ),
        reactionPopupConfig: ReactionPopupConfiguration(
          shadow: BoxShadow(
            color: isDarkTheme ? Colors.black54 : Colors.grey.shade400,
            blurRadius: 20,
          ),
          backgroundColor: theme.reactionPopupColor,
        ),
        messageConfig: MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
            reactedUserCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionCountTextStyle:
                TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.backgroundColor,
              reactedUserTextStyle: TextStyle(
                color: theme.inComingChatBubbleTextColor,
              ),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.inComingChatBubbleColor,
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black12 : Colors.grey.shade200,
                    offset: const Offset(0, 20),
                    blurRadius: 40,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: ShareIconConfiguration(
              defaultIconBackgroundColor: theme.shareIconBackgroundColor,
              defaultIconColor: theme.shareIconColor,
            ),
          ),
        ),
        profileCircleConfig: const ProfileCircleConfiguration(
          profileImageUrl: Data.profileImage,
        ),
        repliedMessageConfig: RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
            enableHighlightRepliedMsg: true,
            highlightColor: Colors.pinkAccent.shade100,
            highlightScale: 1.1,
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.25,
          ),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        ),
        swipeToReplyConfig: SwipeToReplyConfiguration(
          replyIconColor: theme.swipeToReplyIconColor,
        ),
      ),
    );
  }

  void _onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final id = int.parse(Data.messageList.last.id) + 1;
    _chatController.addMessage(
      Message(
        id: id.toString(),
        createdAt: DateTime.now(),
        message: message,
        sendBy: currentUser.id,
        replyMessage: replyMessage,
        messageType: messageType,
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatController.initialMessageList.last.setStatus =
          MessageStatus.undelivered;
    });
    Future.delayed(const Duration(seconds: 1), () {
      _chatController.initialMessageList.last.setStatus = MessageStatus.read;
    });
  }

  void _onThemeIconTap() {
    setState(() {
      if (isDarkTheme) {
        theme = LightTheme();
        isDarkTheme = false;
      } else {
        theme = DarkTheme();
        isDarkTheme = true;
      }
    });
  }
}

class Data {
  static const profileImage =
      "https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png";
  static final messageList = [
    Message(
      id: '1',
      message: "Hi!",
      createdAt: DateTime.now(),
      sendBy: '1',
      // userId of who sends the message
      status: MessageStatus.read,
    ),
    Message(
      id: '2',
      message: "Hi!",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
    Message(
      id: '3',
      message: "We can meet?I am free",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '4',
      message: "Can you write the time and place of the meeting?",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
    ),
    Message(
      id: '5',
      message: "That's fine",
      createdAt: DateTime.now(),
      sendBy: '2',
      reaction: Reaction(reactions: ['\u{2764}'], reactedUserIds: ['1']),
      status: MessageStatus.read,
    ),
    Message(
      id: '6',
      message: "When to go ?",
      createdAt: DateTime.now(),
      sendBy: '3',
      status: MessageStatus.read,
    ),
    Message(
      id: '7',
      message: "I guess Simform will reply",
      createdAt: DateTime.now(),
      sendBy: '4',
      status: MessageStatus.read,
    ),
    Message(
      id: '8',
      message: "https://bit.ly/3JHS2Wl",
      createdAt: DateTime.now(),
      sendBy: '2',
      reaction: Reaction(
        reactions: ['\u{2764}', '\u{1F44D}', '\u{1F44D}'],
        reactedUserIds: ['2', '3', '4'],
      ),
      status: MessageStatus.read,
      replyMessage: const ReplyMessage(
        message: "Can you write the time and place of the meeting?",
        replyTo: '1',
        replyBy: '2',
        messageId: '4',
      ),
    ),
    Message(
      id: '9',
      message: "Done",
      createdAt: DateTime.now(),
      sendBy: '1',
      status: MessageStatus.read,
      reaction: Reaction(
        reactions: [
          '\u{2764}',
          '\u{2764}',
          '\u{2764}',
        ],
        reactedUserIds: ['2', '3', '4'],
      ),
    ),
    Message(
      id: '10',
      message: "Thank you!!",
      status: MessageStatus.read,
      createdAt: DateTime.now(),
      sendBy: '1',
      reaction: Reaction(
        reactions: ['\u{2764}', '\u{2764}', '\u{2764}', '\u{2764}'],
        reactedUserIds: ['2', '4', '3', '1'],
      ),
    ),
    Message(
      id: '11',
      message: "https://miro.medium.com/max/1000/0*s7of7kWnf9fDg4XM.jpeg",
      createdAt: DateTime.now(),
      messageType: MessageType.image,
      sendBy: '1',
      reaction: Reaction(reactions: ['\u{2764}'], reactedUserIds: ['2']),
      status: MessageStatus.read,
    ),
    Message(
      id: '12',
      message: "🤩🤩",
      createdAt: DateTime.now(),
      sendBy: '2',
      status: MessageStatus.read,
    ),
  ];
}
