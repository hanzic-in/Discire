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

    widget.controller.addListener(
      _onTextChanged,
    );

    focusNode.addListener(
      _onFocusChanged,
    );

    animationController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 460,
      ),
    );

    splitAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    );
  }

  void _onTextChanged() {
    final typing =
        widget.controller.text
            .trim()
            .isNotEmpty;

    if (typing != hasText) {
      setState(() {
        hasText = typing;
      });
    }
  }

  void _onFocusChanged() {
    final focused =
        focusNode.hasFocus;

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
    final theme =
        AppThemeExtension.of(context);

    const double composerHeight = 64;

    return SafeArea(
      top: false,

      child: AnimatedBuilder(
        animation: splitAnimation,

        builder: (context, child) {
          final eased =
              Curves.easeOutExpo.transform(
            splitAnimation.value,
          );

          final rightGap =
              Curves.easeOutBack.transform(
                    eased,
                  ) *
                  82;

          final sidePadding =
              (1 - eased) * 28;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              14 + sidePadding,
              0,
              14 + sidePadding,
              12,
            ),

            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),

              constraints:
                  const BoxConstraints(
                minHeight:
                    composerHeight,

                maxHeight: 150,
              ),

              child: Stack(
                children: [

                  // BACKGROUND
                  Positioned.fill(
                    child: CustomPaint(
                      painter:
                          RelioComposerPainter(
                        progress: eased,
                        rightGap:
                            rightGap,

                        backgroundColor:
                            theme.card
                                .withOpacity(
                          0.96,
                        ),

                        hasText:
                            hasText,

                        activeColor:
                            AppColors
                                .primary,

                        activeColorLight:
                            AppColors
                                .primaryLight,
                      ),
                    ),
                  ),

                  // BORDER
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter:
                            RelioComposerBorderPainter(
                          progress:
                              eased,

                          rightGap:
                              rightGap,
                        ),
                      ),
                    ),
                  ),

                  // CONTENT
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,

                    children: [

                      // MAIN INPUT
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(
                            right:
                                eased * 12,
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,

                            children: [

                              // EMOJI
                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                  left: 22,
                                  right: 16,
                                  bottom: 18,
                                ),

                                child: FaIcon(
                                  FontAwesomeIcons
                                      .faceSmile,

                                  size: 26,

                                  color: theme
                                      .textSecondary
                                      .withOpacity(
                                        0.92,
                                      ),
                                ),
                              ),

                              // TEXT FIELD
                              Expanded(
                                child:
                                    Padding(
                                  padding:
                                      const EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),

                                  child:
                                      ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(
                                      minHeight:
                                          32,

                                      maxHeight:
                                          120,
                                    ),

                                    child:
                                        TextField(
                                      controller:
                                          widget
                                              .controller,

                                      focusNode:
                                          focusNode,

                                      keyboardType:
                                          TextInputType
                                              .multiline,

                                      textInputAction:
                                          TextInputAction
                                              .newline,

                                      minLines:
                                          1,

                                      maxLines:
                                          null,

                                      expands:
                                          false,

                                      cursorColor:
                                          AppColors
                                              .primary,

                                      style:
                                          AppTextStyles
                                              .body(
                                        context,
                                      ),

                                      textAlignVertical:
                                          TextAlignVertical
                                              .top,

                                      decoration:
                                          InputDecoration(
                                        border:
                                            InputBorder
                                                .none,

                                        enabledBorder:
                                            InputBorder
                                                .none,

                                        focusedBorder:
                                            InputBorder
                                                .none,

                                        disabledBorder:
                                            InputBorder
                                                .none,

                                        errorBorder:
                                            InputBorder
                                                .none,

                                        focusedErrorBorder:
                                            InputBorder
                                                .none,

                                        filled:
                                            false,

                                        fillColor:
                                            Colors
                                                .transparent,

                                        isDense:
                                            true,

                                        contentPadding:
                                            const EdgeInsets.only(
                                          top:
                                              2,

                                          bottom:
                                              2,
                                        ),

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
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // ATTACH
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
                                        ? const SizedBox(
                                            key:
                                                ValueKey(
                                              'empty',
                                            ),

                                            width:
                                                0,
                                          )

                                        : Padding(
                                            key:
                                                const ValueKey(
                                              'attach',
                                            ),

                                            padding:
                                                EdgeInsets.only(
                                              left:
                                                  18 +
                                                      (eased *
                                                          8),

                                              right:
                                                  22,

                                              bottom:
                                                  18,
                                            ),

                                            child:
                                                FaIcon(
                                              FontAwesomeIcons
                                                  .paperclip,

                                              size:
                                                  26,

                                              color:
                                                  theme
                                                      .textSecondary
                                                      .withOpacity(
                                                        0.9,
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
                        width:
                            composerHeight,

                        height:
                            composerHeight,

                        child: Center(
                          child:
                              Transform.translate(
                            offset: Offset(
                              (1 - eased) *
                                  -10,

                              0,
                            ),

                            child:
                                AnimatedSwitcher(
                              duration:
                                  const Duration(
                                milliseconds:
                                    220,
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
                                        Tween<
                                            double>(
                                      begin:
                                          0.82,

                                      end: 1,
                                    ).animate(
                                      CurvedAnimation(
                                        parent:
                                            animation,

                                        curve: Curves
                                            .easeOutExpo,
                                      ),
                                    ),

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
                                              30,
                                        )

                                      : FaIcon(
                                          FontAwesomeIcons
                                              .microphone,

                                          key:
                                              const ValueKey(
                                            'mic',
                                          ),

                                          size:
                                              28,

                                          color:
                                              isFocused
                                                  ? theme
                                                      .textPrimary

                                                  : theme
                                                      .textSecondary
                                                      .withOpacity(
                                                        0.92,
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
class RelioComposerPainter extends CustomPainter {
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
    // KUNCI PERBAIKAN: Gunakan radius tetap (dari composerHeight / 2 -> 64 / 2 = 32)
    // Jangan pakai size.height / 2 karena size.height berubah saat textfield melar!
    const double baseHeight = 64;
    const double baseRadius = baseHeight / 2;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final mainRight = size.width - rightGap;

    // MAIN PILL
    paint.color = backgroundColor;

    // Pakai Radius.circular(baseRadius) agar corner tidak berubah saat meninggi
    final mainRRect = RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      const Radius.circular(baseRadius),
    );

    canvas.drawRRect(
      mainRRect,
      paint,
    );

    // GOOEY BRIDGE
    if (progress > 0.01 && progress < 0.98) {
      final path = Path();
      final gooeyFactor = (1 - (progress / 0.98)).clamp(0.0, 1.0);
      final bridgeHeight = baseRadius * 0.7 * gooeyFactor;
      final startX = mainRight - baseRadius;
      final endX = size.width - baseRadius;
      
      // Ambil posisi vertical center dari baseHeight (64) bagian bawah
      final centerY = size.height - baseRadius;

      path.moveTo(startX, size.height - baseHeight);
      path.cubicTo(
        startX + (rightGap * 0.24),
        centerY - bridgeHeight,
        endX - (rightGap * 0.28),
        centerY - bridgeHeight,
        endX,
        size.height - baseHeight,
      );
      path.lineTo(endX, size.height);
      path.cubicTo(
        endX - (rightGap * 0.28),
        centerY + bridgeHeight,
        startX + (rightGap * 0.24),
        centerY + bridgeHeight,
        startX,
        size.height,
      );
      path.close();

      canvas.drawPath(path, paint);
    }

    // BUTTON
    final buttonPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    if (hasText) {
      buttonPaint.shader = LinearGradient(
        colors: [activeColorLight, activeColor],
      ).createShader(
        Rect.fromLTWH(
          size.width - 64,
          size.height - baseHeight,
          64,
          baseHeight,
        ),
      );
    } else {
      buttonPaint.color = backgroundColor;
    }

    final pullOut = Curves.easeOutBack.transform(progress);
    final buttonRadius = baseRadius * (0.74 + (progress * 0.26));
    final buttonLeft = size.width - (64 * pullOut);
    final buttonRRect = RRect.fromLTRBR(
      buttonLeft,
      size.height - baseHeight, 
      size.width,
      size.height,
      Radius.circular(buttonRadius),
    );

    canvas.drawRRect(
      buttonRRect,
      buttonPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RelioComposerPainter old) {
    return old.progress != progress || old.hasText != hasText;
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
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color =
          Colors.white
              .withOpacity(
        0.045,
      )

      ..style =
          PaintingStyle.stroke

      ..strokeWidth = 1

      ..isAntiAlias = true;

    final radius =
        size.height / 2;

    final mainRight =
        size.width - rightGap;

    final rect =
        RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      Radius.circular(radius),
    );

    canvas.drawRRect(
      rect,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant RelioComposerBorderPainter
        oldDelegate,
  ) {
    return oldDelegate
            .progress !=
        progress;
  }
}
