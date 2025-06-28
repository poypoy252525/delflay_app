import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Widget> tabs = [
    Tab(icon: Icon(Icons.history)),
    Tab(icon: Icon(Icons.video_library_outlined)),
    Tab(icon: Icon(Icons.bookmark_outline)),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: ExtendedNestedScrollView(
          // backgroundColor: Colors.black,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: HeaderProfile()),
          ],
          onlyOneScrollInBody: true,
          body: Column(
            children: [
              TabBar(tabs: tabs),
              Expanded(
                child: TabBarView(
                  children: [GridBuilder(), GridBuilder(), GridBuilder()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [SizedBox(height: 300)]);
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({super.key});

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio:
            9 / 12, // control height/width ratio (adjust for poster shapes)
      ),
      itemCount: 50,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white38
                : Colors.black12,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
