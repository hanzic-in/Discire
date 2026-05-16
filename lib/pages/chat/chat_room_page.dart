import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input.dart';
import 'widgets/chat_wallpaper.dart';
import 'widgets/chat_room_header.dart';

class ChatRoomPage extends StatefulWidget {
  final String name;

  const ChatRoomPage({
    super.key,
    required this.name,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      "text": "Halo 👋",
      "isMe": false,
      "time": "09:12",
    },
    {
      "text": "Hai!",
      "isMe": true,
      "time": "09:13",
    },
    {
      "text": "Lagi ngapain?",
      "isMe": false,
      "time": "09:14",
    },
  ];

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        "text": text,
        "isMe": true,
        "time": "Now",
      });
    });

    controller.clear();

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Scaffold(
      backgroundColor: theme.background,
      resizeToAvoidBottomInset: false,

      body: ChatWallpaper(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              ChatRoomHeader(
                name: widget.name,
              ),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    AppSpacing.lg,
                    AppSpacing.screenPadding,
                    120,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];

                    return ChatBubble(
                      message: msg['text'],
                      isMe: msg['isMe'],
                      time: msg['time'],
                    );
                  },
                ),
              ),

              AnimatedPadding(
                duration: const Duration(
                  milliseconds: 250,
                ),

                curve: Curves.easeOutCubic,
                padding: EdgeInsets.only(
                  bottom:
                  MediaQuery.of(context)
                  .viewInsets
                  .bottom,
                ),
                
                child: ChatInput(
                  controller: controller,
                  onSend: sendMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
