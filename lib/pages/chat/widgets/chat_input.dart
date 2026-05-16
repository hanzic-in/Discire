import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final FocusNode focusNode = FocusNode();

  bool hasText = false;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onTextChanged);

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  void _onTextChanged() {
    final typing =
        widget.controller.text.trim().isNotEmpty;

    if (typing != hasText) {
      setState(() {
        hasText = typing;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _onTextChanged,
    );

    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        0,
        12,
        24,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [

          // MAIN INPUT
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 220,
              ),

              curve: Curves.easeOutCubic,

              margin: EdgeInsets.only(
                right: isFocused ? 10 : 0,
              ),

              constraints: const BoxConstraints(
                minHeight: 58,
                maxHeight: 140,
              ),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              decoration: BoxDecoration(
                color:
                    theme.card.withOpacity(0.88),

                borderRadius:
                    BorderRadius.circular(32),

                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.04),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.20),

                    blurRadius: 20,
                    offset: const Offset(
                      0,
                      8,
                    ),
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [

                  // EMOJI
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      right: 12,
                    ),

                    child: FaIcon(
                      FontAwesomeIcons
                          .faceSmile,
                      size: 20,
                      color: theme
                          .textSecondary
                          .withOpacity(0.85),
                    ),
                  ),

                  // TEXTFIELD
                  Expanded(
                    child: TextField(
                      controller:
                          widget.controller,

                      focusNode: focusNode,

                      minLines: 1,
                      maxLines: 5,

                      cursorColor:
                          AppColors.primaryLight,

                      style:
                          AppTextStyles.body(
                        context,
                      ),

                      decoration:
                          InputDecoration(
                        border:
                            InputBorder.none,

                        isCollapsed: true,

                        hintText:
                            'Message on Relio...',

                        hintStyle:
                            AppTextStyles
                                .bodySecondary(
                          context,
                        ),

                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ATTACH
                  AnimatedSwitcher(
                    duration:
                        const Duration(
                      milliseconds: 180,
                    ),

                    transitionBuilder:
                        (
                          child,
                          animation,
                        ) {
                      return FadeTransition(
                        opacity: animation,

                        child:
                            ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },

                    child: hasText
                        ? const SizedBox
                            .shrink()

                        : Padding(
                            key:
                                const ValueKey(
                              'attach',
                            ),

                            padding:
                                EdgeInsets.only(
                              right:
                                  isFocused
                                      ? 2
                                      : 0,
                            ),

                            child: FaIcon(
                              FontAwesomeIcons
                                  .paperclip,

                              size: 19,

                              color: theme
                                  .textSecondary
                                  .withOpacity(
                                    0.85,
                                  ),
                            ),
                          ),
                  ),

                  // MIC INSIDE (IDLE)
                  if (!isFocused)
                    Padding(
                      padding:
                          const EdgeInsets.only(
                        left: 18,
                      ),

                      child: FaIcon(
                        FontAwesomeIcons
                            .microphone,

                        size: 20,

                        color: theme
                            .textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // SEND / MIC OUTSIDE
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 220,
            ),

            transitionBuilder:
                (child, animation) {
              return FadeTransition(
                opacity: animation,

                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },

            child: isFocused
                ? hasText
                    ? _sendButton(theme)
                    : _voiceButton(theme)

                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _voiceButton(
    AppThemeExtension theme,
  ) {
    return Container(
      key: const ValueKey('voice'),

      height: 58,
      width: 58,

      decoration: BoxDecoration(
        color: theme.card.withOpacity(0.92),

        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.22),

            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Center(
        child: FaIcon(
          FontAwesomeIcons.microphone,
          size: 20,
          color: theme.textPrimary,
        ),
      ),
    );
  }

  Widget _sendButton(
    AppThemeExtension theme,
  ) {
    return GestureDetector(
      key: const ValueKey('send'),

      onTap: widget.onSend,

      child: Container(
        height: 58,
        width: 58,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryLight,
              AppColors.primary,
            ],
          ),

          shape: BoxShape.circle,
        ),

        child: const Center(
          child: Icon(
            Icons.send_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
