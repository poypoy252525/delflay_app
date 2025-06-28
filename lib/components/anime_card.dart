import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final List<dynamic> animeData;
  final int index;

  const AnimeCard({super.key, required this.animeData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 9 / 13.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              animeData[index]['coverImage']['large'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Text(
            animeData[index]['title']['english'] ??
                animeData[index]['title']['romaji'] ??
                'No title.',
            maxLines: 2,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
