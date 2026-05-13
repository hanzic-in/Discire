import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: theme.background.withOpacity(0.94),
        border: Border(
          top: BorderSide(
            color: theme.divider.withOpacity(0.2),
          ),
        ),
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
                color: theme.searchBar,
                borderRadius: BorderRadius.circular(
                  AppRadius.pill,
                ),
                border: Border.all(
                  color: theme.searchBarBorder,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  // TEXT FIELD
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 5,
                      textAlignVertical:
                          TextAlignVertical.center,
                      style: AppTextStyles.body(context),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                        isCollapsed: true,
                        hintText: "Type a message...",
                        hintStyle:
                            AppTextStyles.bodySecondary(context),
                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.sm),

                  // ATTACH
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.paperclip,
                        size: 17,
                        color: theme.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  // CAMERA
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.camera,
                        size: 17,
                        color: theme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // SEND
          GestureDetector(
            onTap: onSend,
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
          ),
        ],
      ),
    );
  }

  Widget _circleButton(
    BuildContext context, {
    required IconData icon,
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
