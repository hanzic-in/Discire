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
    with SingleTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();

  bool hasText = false;
  bool isFocused = false;

  late AnimationController animationController;
  late Animation<double> splitAnimation;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 420,
      ),
    );

    splitAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutQuart,
    );
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

  void _onFocusChanged() {
    final focused = focusNode.hasFocus;

    if (focused != isFocused) {
      setState(() {
        isFocused = focused;
      });

      if (focused) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _onTextChanged,
    );

    focusNode.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    const double composerHeight = 64;

    return SafeArea(
      top: false,
      child: AnimatedBuilder(
        animation: splitAnimation,

        builder: (context, child) {
          final value = splitAnimation.value;

          final rightGap = value * 78;

          final sidePadding =
              (1 - value) * 28;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              14 + sidePadding,
              0,
              14 + sidePadding,
              12,
            ),

            child: SizedBox(
              height: composerHeight,

              child: Stack(
                children: [

                  // BACKGROUND SHAPE
                  Positioned.fill(
                    child: CustomPaint(
                      painter: RelioComposerPainter(
                        progress: value,
                        rightGap: rightGap,
                        backgroundColor:
                            theme.card.withOpacity(
                          0.95,
                        ),

                        hasText: hasText,

                        activeColor:
                            AppColors.primary,

                        activeColorLight:
                            AppColors.primaryLight,
                      ),
                    ),
                  ),

                  // BORDER
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter:
                            RelioComposerBorderPainter(
                          progress: value,
                          rightGap: rightGap,
                        ),
                      ),
                    ),
                  ),

                  // CONTENT
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [

                      // MAIN COMPOSER
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(
                            right:
                                value * 10,
                          ),

                          child: Row(
                            children: [

                              // EMOJI
                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                  left: 22,
                                  right: 18,
                                ),

                                child: FaIcon(
                                  FontAwesomeIcons
                                      .faceSmile,

                                  size: 23,

                                  color: theme
                                      .textSecondary
                                      .withOpacity(
                                        0.9,
                                      ),
                                ),
                              ),

                              // TEXTFIELD
                              Expanded(
                                child: TextField(
                                  controller: widget.controller,
                                  focusNode: focusNode,
                                  minLines: 1,
                                  maxLines: 5,
                                  cursorColor: AppColors.primary,
                                  style: AppTextStyles.body(
                                    context,
                                  ),

                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    hintText:'Message on Relio...',
                                    hintStyle: AppTextStyles.body(
                                      context,
                                    ).copyWith(
                                      color: theme.textSecondary.withOpacity(0.72,),
                                    ),
                                  ),
                                ),
                              ),

                              // ATTACH
                              AnimatedOpacity(
                                duration:
                                    const Duration(
                                  milliseconds:
                                      180,
                                ),

                                opacity:
                                    hasText
                                        ? 0
                                        : 1,

                                child: Padding(
                                  padding:
                                      EdgeInsets.only(
                                    left:
                                        18 +
                                        (value *
                                            6),

                                    right: 20,
                                  ),

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
                            ],
                          ),
                        ),
                      ),

                      // RIGHT BUTTON
                      SizedBox(
                        width: composerHeight,
                        height: composerHeight,

                        child: Center(
                          child:
                              Transform.translate(
                            offset: Offset(
                              (1 - value) *
                                  -6,
                              0,
                            ),

                            child:
                                AnimatedSwitcher(
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
                                            22,

                                        color:
                                            isFocused
                                                ? theme
                                                    .textPrimary
                                                : theme
                                                    .textSecondary
                                                    .withOpacity(
                                                      0.88,
                                                    ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =========================
// MAIN SHAPE
// =========================

class RelioComposerPainter
    extends CustomPainter {
  final double progress;
  final double rightGap;

  final Color backgroundColor;

  final bool hasText;

  final Color activeColor;
  final Color activeColorLight;

  RelioComposerPainter({
    required this.progress,
    required this.rightGap,
    required this.backgroundColor,
    required this.hasText,
    required this.activeColor,
    required this.activeColorLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 32;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final mainRight =
        size.width - rightGap;

    // MAIN PILL
    paint.color = backgroundColor;

    final mainRRect = RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      const Radius.circular(radius),
    );

    canvas.drawRRect(mainRRect, paint);

    // GOOEY BRIDGE
    if (progress > 0.04 &&
        progress < 0.88) {
      final path = Path();

      final gooeyFactor =
          (1 - (progress / 0.88))
              .clamp(0.0, 1.0);

      final bridgeHeight =
          radius *
          0.62 *
          gooeyFactor;

      final startX =
          mainRight - radius;

      final endX =
          size.width - radius;

      final centerY =
          size.height / 2;

      path.moveTo(
        startX,
        centerY - radius,
      );

      path.cubicTo(
        startX + (rightGap * 0.28),
        centerY - bridgeHeight,

        endX - (rightGap * 0.32),
        centerY - bridgeHeight,

        endX,
        centerY - radius,
      );

      path.lineTo(
        endX,
        centerY + radius,
      );

      path.cubicTo(
        endX - (rightGap * 0.32),
        centerY + bridgeHeight,

        startX + (rightGap * 0.28),
        centerY + bridgeHeight,

        startX,
        centerY + radius,
      );

      path.close();

      canvas.drawPath(path, paint);
    }

    // RIGHT BUTTON
    final buttonPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    if (hasText) {
      buttonPaint.shader =
          LinearGradient(
            colors: [
              activeColorLight,
              activeColor,
            ],
          ).createShader(
            Rect.fromLTWH(
              size.width - 64,
              0,
              64,
              64,
            ),
          );
    } else {
      buttonPaint.color =
          backgroundColor;
    }

    final buttonRadius =
      radius * (0.92 + (progress * 0.08));

    final buttonLeft =
      size.width - (64 * (progress * 0.96));

    final buttonRRect =
        RRect.fromLTRBR(
          buttonLeft,
          0,
          size.width,
          size.height,
          Radius.circular(
            buttonRadius,
          ),
        );

    canvas.drawRRect(
      buttonRRect,
      buttonPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant RelioComposerPainter old,
  ) {
    return old.progress != progress ||
        old.hasText != hasText;
  }
}

// =========================
// BORDER
// =========================

class RelioComposerBorderPainter
    extends CustomPainter {
  final double progress;
  final double rightGap;

  RelioComposerBorderPainter({
    required this.progress,
    required this.rightGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          Colors.white.withOpacity(
        0.045,
      )

      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    final radius = 32.0;

    final mainRight =
        size.width - rightGap;

    final rect = RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      Radius.circular(radius),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(
    covariant RelioComposerBorderPainter
        oldDelegate,
  ) {
    return oldDelegate.progress !=
        progress;
  }
}
