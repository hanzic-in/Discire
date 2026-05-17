import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  bool _hasText = false;
  bool _isFocused = false;

  late final AnimationController _animationController;
  late final Animation<double> _splitAnimation;

  static const double _composerHeight = 56;
  static const double _baseRadius = _composerHeight / 2;
  static const double _maxInputHeight = 120;
  static const double _maxContainerHeight = 150;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupListeners();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 460),
    );

    _splitAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
  }

  void _setupListeners() {
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final typing = widget.controller.text.trim().isNotEmpty;
    if (typing != _hasText) {
      setState(() => _hasText = typing);
    }
    _scrollToBottom();
  }

  void _onFocusChanged() {
    final focused = _focusNode.hasFocus;
    if (focused == _isFocused) return;

    setState(() => _isFocused = focused);
    focused
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _handleSend() {
    if (!_hasText) return;
    widget.onSend();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return SafeArea(
      top: false,
      child: AnimatedBuilder(
        animation: _splitAnimation,
        builder: (context, child) {
          final eased = Curves.easeOutExpo.transform(_splitAnimation.value);
          final rightGap = Curves.easeOutBack.transform(eased) * 82;
          final sidePadding = (1 - eased) * 28;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              14 + sidePadding,
              0,
              14 + sidePadding,
              12,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              constraints: const BoxConstraints(
                minHeight: _composerHeight,
                maxHeight: _maxContainerHeight,
              ),
              child: Stack(
                children: [
                  _Background(
                    progress: eased,
                    rightGap: rightGap,
                    backgroundColor: theme.card.withOpacity(0.96),
                    hasText: _hasText,
                    activeColor: AppColors.primary,
                    activeColorLight: AppColors.primaryLight,
                  ),
                  _Border(
                    progress: eased,
                    rightGap: rightGap,
                  ),
                  _Content(
                    eased: eased,
                    rightGap: rightGap,
                    hasText: _hasText,
                    isFocused: _isFocused,
                    controller: widget.controller,
                    focusNode: _focusNode,
                    scrollController: _scrollController,
                    onSend: _handleSend,
                    theme: theme,
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

// ═══════════════════════════════════════════════════════════
// EXTRACTED WIDGETS
// ═══════════════════════════════════════════════════════════

class _Background extends StatelessWidget {
  final double progress;
  final double rightGap;
  final Color backgroundColor;
  final bool hasText;
  final Color activeColor;
  final Color activeColorLight;

  const _Background({
    required this.progress,
    required this.rightGap,
    required this.backgroundColor,
    required this.hasText,
    required this.activeColor,
    required this.activeColorLight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ComposerPainter(
          progress: progress,
          rightGap: rightGap,
          backgroundColor: backgroundColor,
          hasText: hasText,
          activeColor: activeColor,
          activeColorLight: activeColorLight,
        ),
      ),
    );
  }
}

class _Border extends StatelessWidget {
  final double progress;
  final double rightGap;

  const _Border({
    required this.progress,
    required this.rightGap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _ComposerBorderPainter(
            progress: progress,
            rightGap: rightGap,
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final double eased;
  final double rightGap;
  final bool hasText;
  final bool isFocused;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final VoidCallback onSend;
  final dynamic theme;

  const _Content({
    required this.eased,
    required this.rightGap,
    required this.hasText,
    required this.isFocused,
    required this.controller,
    required this.focusNode,
    required this.scrollController,
    required this.onSend,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: eased * 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedRelieved01,
                    size: 28,
                    color: theme.textSecondary.withOpacity(0.92),
                  ),
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 12,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.zero
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 32,
                        maxHeight: 120,
                      ),
                      child: _ChatTextField(
                        controller: controller,
                        focusNode: focusNode,
                        scrollController: scrollController,
                        theme: theme,
                      ),
                    ),
                  ),
                ),
                _AttachButton(
                  visible: !hasText,
                  eased: eased,
                  color: theme.textSecondary.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
        _ActionButton(
          hasText: hasText,
          isFocused: isFocused,
          eased: eased,
          onSend: onSend,
          theme: theme,
        ),
      ],
    );
  }
}


class _ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final dynamic theme;

  const _ChatTextField({
    required this.controller,
    required this.focusNode,
    required this.scrollController,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      scrollController: scrollController,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: null,
      expands: false,
      cursorColor: AppColors.primary,
      style: AppTextStyles.body(context).copyWith(
        fontSize: 16,
        height: 1.0,
        ),
      textAlignVertical: TextAlignVertical.center,
      
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
        isDense: true,
        filled: false,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        
        contentPadding: const EdgeInsets.zero
        
        hintText: 'Type Message...',
        hintStyle: AppTextStyles.body(context).copyWith(
          fontSize: 16,
          height: 1.0,
          color: theme.textSecondary.withOpacity(0.72),
        ),
      ),
    );
  }
}


class _IconButton extends StatelessWidget {
  final Widget icon;
  final EdgeInsets padding;

  const _IconButton({
    required this.icon,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: icon,
    );
  }
}

class _AttachButton extends StatelessWidget {
  final bool visible;
  final double eased;
  final Color color;

  const _AttachButton({
    required this.visible,
    required this.eased,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: visible
          ? Padding(
              key: const ValueKey('attach'),
              padding: EdgeInsets.only(
                left: 14 + (eased * 6),
                right: 18,
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedFolderAttachment,
                size: 28,
                color: color,
              ),
            )
          : const SizedBox(key: ValueKey('empty'), width: 0),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final bool hasText;
  final bool isFocused;
  final double eased;
  final VoidCallback onSend;
  final dynamic theme;

  const _ActionButton({
    required this.hasText,
    required this.isFocused,
    required this.eased,
    required this.onSend,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 56;

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Transform.translate(
          offset: Offset((1 - eased) * -6, 0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.82, end: 1).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutExpo,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: hasText
                ? GestureDetector(
                    key: const ValueKey('send'),
                    onTap: onSend,
                  child: Transform.translate(
                      offset: const Offset(-1, 0),
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedSent, 
                      color: Colors.white,
                      size: 28,
                      ),
                    ),
                  )
                : HugeIcon(
                    icon: HugeIcons.strokeRoundedMic02,
                    key: const ValueKey('mic'),
                    size: 28,
                    color: isFocused
                        ? theme.textPrimary
                        : theme.textSecondary.withOpacity(0.92),
                  ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CUSTOM PAINTERS
// ═══════════════════════════════════════════════════════════

class _ComposerPainter extends CustomPainter {
  final double progress;
  final double rightGap;
  final Color backgroundColor;
  final bool hasText;
  final Color activeColor;
  final Color activeColorLight;

  _ComposerPainter({
    required this.progress,
    required this.rightGap,
    required this.backgroundColor,
    required this.hasText,
    required this.activeColor,
    required this.activeColorLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double baseHeight = 56;
    const double baseRadius = baseHeight / 2;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final mainRight = size.width - rightGap;

    paint.color = backgroundColor;

    final mainRRect = RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      const Radius.circular(baseRadius),
    );
    canvas.drawRRect(mainRRect, paint);

    if (progress > 0.01 && progress < 0.98) {
      final path = Path();
      final gooeyFactor = (1 - (progress / 0.98)).clamp(0.0, 1.0);
      final bridgeHeight = baseRadius * 0.7 * gooeyFactor;
      final startX = mainRight - baseRadius;
      final endX = size.width - baseRadius;
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

    final buttonPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    if (hasText) {
      buttonPaint.shader = LinearGradient(
        colors: [activeColorLight, activeColor],
      ).createShader(
        Rect.fromLTWH(
          size.width - 56,
          size.height - baseHeight,
          56,
          baseHeight,
        ),
      );
    } else {
      buttonPaint.color = backgroundColor;
    }

    final pullOut = Curves.easeOutBack.transform(progress);
    final buttonRadius = baseRadius * (0.74 + (progress * 0.26));
    final buttonLeft = size.width - (56 * pullOut);

    final buttonRRect = RRect.fromLTRBR(
      buttonLeft,
      size.height - baseHeight,
      size.width,
      size.height,
      Radius.circular(buttonRadius),
    );

    canvas.drawRRect(buttonRRect, buttonPaint);
  }

  @override
  bool shouldRepaint(covariant _ComposerPainter old) {
    return old.progress != progress ||
        old.hasText != hasText ||
        old.rightGap != rightGap;
  }
}

class _ComposerBorderPainter extends CustomPainter {
  final double progress;
  final double rightGap;

  _ComposerBorderPainter({
    required this.progress,
    required this.rightGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.045)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..isAntiAlias = true;

    const double baseRadius = 32;
    final mainRight = size.width - rightGap;

    final rect = RRect.fromLTRBR(
      0,
      0,
      mainRight,
      size.height,
      const Radius.circular(baseRadius),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _ComposerBorderPainter old) {
    return old.progress != progress || old.rightGap != rightGap;
  }
}
