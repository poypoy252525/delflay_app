import 'package:delflay_app/api/anilist.dart';
import 'package:delflay_app/components/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> animeData = [];

  int _currentPage = 1;
  final _perPage = 15;
  final ScrollController _scrollController = ScrollController();

  Future<void> fetchAnime() async {
    Anilist anilist = Anilist();
    var result = await anilist.getPopularAnime(_currentPage, _perPage);
    setState(() {
      _currentPage++;
      animeData.addAll(result);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAnime();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        fetchAnime();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: GridView.builder(
          itemCount: animeData.length + 3,
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            if (index < animeData.length) {
              return InkWell(
                onTap: () {
                  context.push('/home/${animeData[index]['id']}');
                },
                borderRadius: BorderRadius.circular(12),
                child: AnimeCard(animeData: animeData, index: index),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
