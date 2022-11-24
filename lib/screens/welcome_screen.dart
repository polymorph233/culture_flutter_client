import 'package:culture_flutter_client/services/recommend_festival_service.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:culture_flutter_client/widgets/festival_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/festival.dart';
import '../widgets/festival_list.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MainListViewModel>(context, listen: false).update();
  }

  @override
  Widget build(BuildContext context) {
    const int carouselCount = 4;

    final vm = Provider.of<MainListViewModel>(context);
    final carousel = FestivalCarousel(festivals: vm.randomFestivals(carouselCount));

    final list = OutlinedButton(onPressed: () => context.go("/list"),
      child: const Center(child: Text('Festivals')));
    final map = OutlinedButton(onPressed: () => context.go("/map"),
      child: const Center(child: Text('Map')));
    final fav = OutlinedButton(onPressed: () => context.go("/fav"),
      child: const Center(child: Text('My Favorites')));
    final config = OutlinedButton(onPressed: () {  }, child: const Center(child: Text('Settings')));

    final portrait = [[list, map], [fav, config]];

    const portraitMargin = EdgeInsets.all(20);
    const portraitConstraints = BoxConstraints(
      maxWidth: 128,
      maxHeight: 32,
    );

    final landscape = [list, map, fav, config];

    const landscapeMargin = EdgeInsets.only(left: 80, top: 40, right: 80, bottom: 40);
    const landscapeConstraints = BoxConstraints(
      maxWidth: 128,
      maxHeight: 32,
    );

    final isLandscape = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    final recommends = RecommendFestivalService(vm.festivals, vm.favorites).recommend(2);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Festival Culture")
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:
          isLandscape ?
            Row(children: <Widget>[
              Flexible(child: carousel),
              Flexible(child: Column(children: landscape.map((child) =>
                Flexible(child: Container(
                  margin: landscapeMargin,
                  child: ConstrainedBox(
                    constraints: landscapeConstraints,
                    child: child
                  ),
                )
              )).toList()))
            ])
          : Column(children: <Widget>[
            Flexible(child: carousel),
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
              children: portrait.map((row) =>
                Row(children: row.map((child) =>
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                        child: ConstrainedBox(
                          constraints: portraitConstraints,
                          child: child
                      ),
                    ))
                ).toList())
              ).toList())),
            Row(children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 16.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 24,
                  )),
              ),
              const Text("Recommended for you"),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 20.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 24,
                  )),
              ),
            ]),
            Flexible(child:
              ListView.builder(
                itemCount: recommends.length,
                controller: ScrollController(),
                itemBuilder: (context, index) {

                  final item = recommends[index];

                  return InkWell(
                    onTap: () => context.pushNamed('festival', params: {"id": item.id.toString()}),
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(child: Icon(categoryIcon(item.domain))),
                        title: Text(item.name),
                        subtitle: Text(item.principalPeriod),
                      ),
                    ),
                  );
                })
            )]
          ))
      );
  }
}

class WelcomeScreenEntry extends StatefulWidget {
  const WelcomeScreenEntry({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Welcome to Festival Culture";

  @override
  State<WelcomeScreenEntry> createState() => _WelcomeScreenEntryState();
}

class _WelcomeScreenEntryState extends State<WelcomeScreenEntry> {

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainListViewModel>(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => vm,
        child: const WelcomeScreen(),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.welcome)
    );
  }
}
