import 'package:delflay_app/screens/media_screen/episode_list_view_item.dart';
import 'package:flutter/material.dart';

class RelationListView extends StatefulWidget {
  const RelationListView({super.key, required this.mediaInfo});

  final Map<String, dynamic> mediaInfo;

  @override
  State<RelationListView> createState() => _RelationListViewState();
}

class _RelationListViewState extends State<RelationListView>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> _relations = [];

  @override
  void initState() {
    super.initState();
    var relations = widget.mediaInfo['relations']['edges'];
    setState(() {
      if (relations != null) {
        _relations = relations;
      }
    });
  }

  @override
  void didUpdateWidget(covariant RelationListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaInfo != widget.mediaInfo &&
        widget.mediaInfo.isNotEmpty) {
      setState(() {
        _relations =
            widget.mediaInfo['relations']['edges']
                as List<Map<String, dynamic>>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: _relations.length,
      itemBuilder: (context, index) => EpisodeListViewItem(
        description: _relations[index]['relationType'],
        image: _relations[index]['node']['coverImage']['large'],
        title:
            _relations[index]['node']['title']['english'] ??
            _relations[index]['node']['title']['romaji'],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
