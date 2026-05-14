// lib/pages/chat/widgets/chat_wallpaper.dart

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatWallpaper extends StatefulWidget {
  final Widget child;

  const ChatWallpaper({
    super.key,
    required this.child,
  });

  @override
  State<ChatWallpaper> createState() => _ChatWallpaperState();
}

class _ChatWallpaperState extends State<ChatWallpaper> {
  ui.Image? _patternImage;

  @override
  void initState() {
    super.initState();
    _loadPattern();
  }

  Future<void> _loadPattern() async {
    // Render SVG ke image kecil (1 tile)
    final pictureInfo = await vg.loadPicture(
      const SvgAssetLoader('assets/chat/wallpapers/seamless_pattern_1.svg'),
      null,
    );

    const tileSize = Size(160, 120); // 4:3 sesuai SVG Anda

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Gambar SVG ke canvas dengan ukuran tile
    canvas.drawPicture(pictureInfo.picture); // ← PERBAIKAN: drawPicture, bukan picture.paint

    final image = await recorder.endRecording().toImage(
      tileSize.width.toInt(),
      tileSize.height.toInt(),
    );

    if (mounted) {
      setState(() => _patternImage = image);
    }
    
    pictureInfo.picture.dispose();
  }

  @override
  void dispose() {
    _patternImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_patternImage == null) {
      return Container(color: Colors.black, child: widget.child);
    }

    return Stack(
      children: [
        // Background hitam
        Container(color: Colors.black),

        // Pattern berulang via GPU
        Positioned.fill(
          child: Opacity(
            opacity: 0.10,
            child: CustomPaint(
              size: Size.infinite,
              painter: _TiledPatternPainter(_patternImage!),
            ),
          ),
        ),

        // Content
        widget.child,
      ],
    );
  }
}

class _TiledPatternPainter extends CustomPainter {
  final ui.Image image;

  _TiledPatternPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = ImageShader(
        image,
        TileMode.repeated, // ← Native GPU repeat!
        TileMode.repeated,
        Matrix4.identity().storage,
      );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
