import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShaderWallpaper extends StatefulWidget {
  final Widget child;
  const ShaderWallpaper({super.key, required this.child});

  @override
  State<ShaderWallpaper> createState() => _ShaderWallpaperState();
}

class _ShaderWallpaperState extends State<ShaderWallpaper> {
  ui.Image? _patternImage;
  ui.FragmentShader? _shader;
  ui.FragmentProgram? _program;

  @override
  void initState() {
    super.initState();
    _initShader();
  }

  Future<void> _initShader() async {
    // 1. Load shader
    _program = await ui.FragmentProgram.fromAsset('shaders/tile_pattern.frag');
    
    // 2. Render SVG ke Image (tile kecil)
    final pictureInfo = await vg.loadPicture(
      const SvgAssetLoader('assets/chat/wallpapers/seamless_pattern_1.svg'),
      null,
    );
    
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const tileSize = Size(160, 120); // 4:3
    
    pictureInfo.picture.paint(canvas, Offset.zero);
    
    final image = await recorder.endRecording().toImage(
      tileSize.width.toInt(),
      tileSize.height.toInt(),
    );
    
    setState(() {
      _patternImage = image;
      _shader = _program!.fragmentShader();
    });
    
    pictureInfo.picture.dispose();
  }

  @override
  void dispose() {
    _shader?.dispose();
    _program?.dispose();
    _patternImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_patternImage == null || _shader == null) {
      return Container(color: Colors.black, child: widget.child);
    }

    return Stack(
      children: [
        Container(color: Colors.black),
        
        Positioned.fill(
          child: AnimatedBuilder(
            animation: Listenable.merge([_shader]),
            builder: (context, _) {
              _shader!
                ..setImageSampler(0, _patternImage!)
                ..setFloat(0, MediaQuery.of(context).size.width)   // uSize.x
                ..setFloat(1, MediaQuery.of(context).size.height)  // uSize.y
                ..setFloat(2, 160.0)  // tileSize.x
                ..setFloat(3, 120.0)  // tileSize.y
                ..setFloat(4, 0.10);   // opacity

              return CustomPaint(
                size: Size.infinite,
                painter: _ShaderPainter(_shader!),
              );
            },
          ),
        ),
        
        widget.child,
      ],
    );
  }
}

class _ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  _ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
