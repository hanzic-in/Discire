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

class _ChatInputState extends State<ChatInput>
    with TickerProviderStateMixin {
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

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          14,
          0,
          14,
          12,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [

            // MAIN COMPOSER
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 320,
                ),

                curve: Curves.easeOutQuart,

                margin: EdgeInsets.only(
                  right: isFocused ? 6 : 0,
                ),

                constraints: const BoxConstraints(
                  minHeight: 64,
                  maxHeight: 150,
                ),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  color:
                      theme.card.withOpacity(0.94),

                  borderRadius:
                      BorderRadius.circular(
                    34,
                  ),

                  border: Border.all(
                    color: Colors.white
                        .withOpacity(0.045),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.22),

                      blurRadius: 24,
                      offset: const Offset(
                        0,
                        10,
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
                        right: 14,
                      ),

                      child: FaIcon(
                        FontAwesomeIcons
                            .faceSmile,

                        size: 23,

                        color: theme
                            .textSecondary
                            .withOpacity(0.9),
                      ),
                    ),

                    // TEXT FIELD
                    Expanded(
                      child: TextField(
                        controller:
                            widget.controller,

                        focusNode: focusNode,

                        minLines: 1,
                        maxLines: 5,

                        cursorColor:
                            AppColors.primary,

                        style:
                            AppTextStyles.body(
                          context,
                        ),

                        decoration:
                            InputDecoration(
                          border:
                              InputBorder.none,

                          isCollapsed: true,

                          filled: false,

                          hintText:
                              'Message on Relio...',

                          hintStyle:
                              AppTextStyles
                                  .body(
                            context,
                          ).copyWith(
                            color: theme
                                .textSecondary
                                .withOpacity(
                                  0.72,
                                ),
                          ),

                          contentPadding:
                              const EdgeInsets.symmetric(
                            vertical: 21,
                          ),
                        ),
                      ),
                    ),

                    // ATTACH
                    AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 320,
                      ),

                      curve:
                          Curves.easeOutQuart,

                      margin: EdgeInsets.only(
                        left:
                            isFocused ? 12 : 22,
                      ),

                      child: AnimatedOpacity(
                        duration:
                            const Duration(
                          milliseconds: 180,
                        ),

                        opacity:
                            hasText ? 0 : 1,

                        child: FaIcon(
                          FontAwesomeIcons
                              .paperclip,

                          size: 23,

                          color: theme
                              .textSecondary
                              .withOpacity(
                                0.88,
                              ),
                        ),
                      ),
                    ),

                    // INSIDE MIC (IDLE)
                    AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 320,
                      ),

                      curve:
                          Curves.easeOutQuart,

                      width:
                          isFocused ? 0 : 42,

                      child: AnimatedOpacity(
                        duration:
                            const Duration(
                          milliseconds: 180,
                        ),

                        opacity:
                            isFocused ? 0 : 1,

                        child: Padding(
                          padding:
                              const EdgeInsets.only(
                            left: 18,
                          ),

                          child: FaIcon(
                            FontAwesomeIcons
                                .microphone,

                            size: 23,

                            color: theme
                                .textSecondary
                                .withOpacity(
                                  0.88,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // OUTSIDE BUTTON
            AnimatedSlide(
              duration: const Duration(
                milliseconds: 320,
              ),

              curve: Curves.easeOutQuart,

              offset: isFocused
                  ? Offset.zero
                  : const Offset(0.4, 0),

              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 220,
                ),

                opacity: isFocused ? 1 : 0,

                child: Padding(
                  padding:
                      const EdgeInsets.only(
                    left: 2,
                  ),

                  child: GestureDetector(
                    onTap:
                        hasText
                            ? widget.onSend
                            : () {},

                    child: AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 220,
                      ),

                      height: 64,
                      width: 64,

                      decoration: BoxDecoration(
                        gradient:
                            hasText
                                ? const LinearGradient(
                                  colors: [
                                    AppColors
                                        .primaryLight,
                                    AppColors
                                        .primary,
                                  ],
                                )

                                : null,

                        color:
                            hasText
                                ? null
                                : theme.card
                                    .withOpacity(
                                      0.96,
                                    ),

                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(
                                  0.24,
                                ),

                            blurRadius: 24,

                            offset:
                                const Offset(
                                  0,
                                  10,
                                ),
                          ),
                        ],
                      ),

                      child: Center(
                        child: AnimatedSwitcher(
                          duration:
                              const Duration(
                            milliseconds:
                                180,
                          ),

                          transitionBuilder:
                              (
                                child,
                                animation,
                              ) {
                            return FadeTransition(
                              opacity:
                                  animation,

                              child:
                                  ScaleTransition(
                                scale:
                                    animation,
                                child:
                                    child,
                              ),
                            );
                          },

                          child:
                              hasText
                                  ? const Icon(
                                    Icons
                                        .send_rounded,

                                    key:
                                        ValueKey(
                                          'send',
                                        ),

                                    color:
                                        Colors
                                            .white,

                                    size:
                                        28,
                                  )

                                  : FaIcon(
                                    FontAwesomeIcons
                                        .microphone,

                                    key:
                                        const ValueKey(
                                          'mic',
                                        ),

                                    size:
                                        23,

                                    color:
                                        theme
                                            .textPrimary,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
