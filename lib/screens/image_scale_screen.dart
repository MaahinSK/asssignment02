import 'package:flutter/material.dart';

class ImageScaleScreen extends StatelessWidget {
  const ImageScaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Pinch to zoom the image below:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: InteractiveViewer(

            minScale: 0.5,
            maxScale: 5.0,
            child: Center(
              child: Image.network(
                'https://picsum.photos/id/169/800/600',
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 80, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Failed to load image.\nCheck internet connection.'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}