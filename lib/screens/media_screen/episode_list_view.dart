import 'package:delflay_app/api/episode_metadata.dart';
import 'package:delflay_app/screens/media_screen/episode_list_view_item.dart';
import 'package:flutter/material.dart';

class EpisodeListView extends StatefulWidget {
  final Map<String, dynamic> mediaInfo;
  const EpisodeListView({super.key, required this.mediaInfo});

  @override
  State<EpisodeListView> createState() => _EpisodeListViewState();
}

class _EpisodeListViewState extends State<EpisodeListView>
    with AutomaticKeepAliveClientMixin {
  Iterable<Map<String, dynamic>> episodes = [];

  void fetchEpisodes() async {
    final id = widget.mediaInfo['id'];
    if (id == null) return;
    var data = await getEpisodeInfo(id);
    setState(() {
      episodes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  @override
  void didUpdateWidget(covariant EpisodeListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaInfo != widget.mediaInfo &&
        widget.mediaInfo.isNotEmpty) {
      fetchEpisodes();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return EpisodeListViewItem(
          description:
              episodes.elementAt(index)['overview'] ?? 'No description.',
          image:
              episodes.elementAt(index)['image'] ??
              widget.mediaInfo['bannerImage'],
          title:
              '${episodes.elementAt(index)['episode']}. ${episodes.elementAt(index)['title']?['en']}',
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
