import 'package:flutter/material.dart';

/// Launched by double tapping the event photo. InteractiveViewer also supports zoom.
class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key, required this.imagePath, required this.title});

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF101A2A),
        appBar: AppBar(
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF101A2A),
        ),
        body: SafeArea(
          child: Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: Image.asset(imagePath, fit: BoxFit.contain,
                width: double.infinity),
            ),
          ),
        ),
      );
}
