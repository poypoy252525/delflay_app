import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Map<String, dynamic> mediaInfo;
  const Header({super.key, required this.mediaInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 6,
          child: mediaInfo['bannerImage'] != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      mediaInfo['bannerImage'],
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Center(child: Text('No banner')),
        ),
        Row(children: []),
      ],
    );
  }
}
