import 'package:delflay_app/api/anilist.dart';
import 'package:delflay_app/screens/media_screen/episode_list_view.dart';
import 'package:delflay_app/screens/media_screen/header.dart';
import 'package:delflay_app/screens/media_screen/relation_list_view.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatefulWidget {
  final int id;
  const MediaScreen({super.key, required this.id});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  Anilist anilist = Anilist();
  Map<String, dynamic> mediaInfo = {};

  void fetchMediaInfo() async {
    var result = await anilist.getMediaInfo(widget.id);
    setState(() {
      mediaInfo = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMediaInfo();
  }

  final List<Widget> tabs = [
    Tab(text: 'Episodes'),
    Tab(text: 'Relations'),
    Tab(text: 'Characters'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mediaInfo['title']?['english'] ?? '',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: Header(mediaInfo: mediaInfo)),
        ],
        body: DefaultTabController(
          length: tabs.length,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
                child: TabBar(tabs: tabs),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    EpisodeListView(mediaInfo: mediaInfo),
                    RelationListView(mediaInfo: mediaInfo),
                    EpisodeListView(mediaInfo: mediaInfo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
