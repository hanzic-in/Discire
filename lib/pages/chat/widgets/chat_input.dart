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
  bool hasText = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onTextChanged);
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
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.background.withOpacity(0.82),

        borderRadius: BorderRadius.circular(32),

        border: Border.all(
          color: theme.divider.withOpacity(0.08),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          // EMOJI
          _circleButton(
            context,
            icon: FontAwesomeIcons.faceSmile,
            onTap: () {},
          ),

          const SizedBox(width: AppSpacing.sm),

          // INPUT
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 56,
                maxHeight: 140,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: theme.searchBar.withOpacity(0.45),

                borderRadius: BorderRadius.circular(
                  AppRadius.pill,
                ),

                border: Border.all(
                  color: theme.searchBarBorder
                      .withOpacity(0.45),
                ),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [

                  // TEXT FIELD
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      minLines: 1,
                      maxLines: 5,
                      cursorColor: AppColors.primary,
                      style:
                          AppTextStyles.body(context),

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        filled: false,

                        hintText:
                            "Message on Relio...",

                        hintStyle:
                            AppTextStyles
                                .bodySecondary(
                          context,
                        ),

                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.sm),

                  // ATTACH + CAMERA
                  AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 180,
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

                    child: hasText
                        ? const SizedBox.shrink()

                        : Row(
                            key:
                                const ValueKey(
                              'actions',
                            ),
                            children: [

                              // ATTACH
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons
                                        .paperclip,
                                    size: 17,
                                    color: theme
                                        .textSecondary,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width:
                                    AppSpacing.md,
                              ),

                              // CAMERA
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(
                                    bottom: 16,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons
                                        .camera,
                                    size: 17,
                                    color: theme
                                        .textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // SEND / VOICE
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 180,
            ),

            transitionBuilder:
                (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },

            child: hasText
                ? _sendButton(theme)
                : _voiceButton(theme),
          ),
        ],
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
        height: 56,
        width: 56,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryLight,
              AppColors.primary,
            ],
          ),
          shape: BoxShape.circle,
        ),

        child: const Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _voiceButton(
    AppThemeExtension theme,
  ) {
    return Container(
      key: const ValueKey('voice'),

      height: 56,
      width: 56,

      decoration: BoxDecoration(
        color: theme.card.withOpacity(0.7),
        shape: BoxShape.circle,

        border: Border.all(
          color: theme.divider.withOpacity(0.12),
        ),
      ),

      child: Center(
        child: FaIcon(
          FontAwesomeIcons.microphone,
          size: 18,
          color: theme.textSecondary,
        ),
      ),
    );
  }

  Widget _circleButton(
    BuildContext context, {
    required FaIconData icon,
    required VoidCallback onTap,
  }) {
    final theme = AppThemeExtension.of(context);

    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 52,
        width: 52,

        decoration: BoxDecoration(
          color: theme.card.withOpacity(0.7),

          shape: BoxShape.circle,

          border: Border.all(
            color: theme.divider.withOpacity(0.12),
          ),
        ),

        child: Center(
          child: FaIcon(
            icon,
            size: 18,
            color: theme.textSecondary,
          ),
        ),
      ),
    );
  }
}
