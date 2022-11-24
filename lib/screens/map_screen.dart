import 'package:culture_flutter_client/services/img_provider_service.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:culture_flutter_client/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../services/dummy_service.dart';
import '../widgets/festival_list.dart';

class MapListScreen extends StatefulWidget {
  const MapListScreen({super.key});

  @override
  _MapListScreenState createState() => _MapListScreenState();
}

class _MapListScreenState extends State<MapListScreen> {
  List<FestivalViewModel> festivals = [];

  FestivalViewModel? highlighted;

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<MainListViewModel>(context, listen: false);

    vm.update().then((_) => setState(() {
          festivals = vm.festivals;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Marker makeMarker(
    FestivalViewModel fest,
  ) {
    final name = fest.name;

    return Marker(
      point: fest.latLng!,
      builder: (_) => GestureDetector(
          child: const Icon(Icons.place, size: 40, color: Colors.blue),
          onTap: () => setState(() {
                highlighted = fest;
              })),
    );
  }

  Container makeCard() {
    if (highlighted != null) {
      final vm = Provider.of<MainListViewModel>(context, listen: false);

      var isLiked = vm.favorites.contains(highlighted);
      return Container(
          padding: const EdgeInsets.all(32),
          child: Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: ImageProviderService.randomImage(highlighted!.domain),
                title: Text(highlighted!.name),
                subtitle: Text(
                    "${highlighted!.principalPeriod}\n${highlighted!.principalCommune} ${highlighted!.principalRegion}"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: isLiked
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline),
                    onPressed: isLiked
                        ? () => vm.removeFavorite(highlighted!)
                        : () => vm.addFavorite(highlighted!),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          )));
    } else {
      return Container(
          padding: const EdgeInsets.all(32),
          child: const Card(
              child: ListTile(
            leading: Icon(Icons.question_mark),
            title: Text("Choose a festival"),
            subtitle: Text("You will see more details about it."),
          )));
    }
  }

  void search(List<Suggestion> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<MainListViewModel>(context, listen: false);
      setState(() {
        festivals = vm.festivals;
      });
    } else {
      setState(() {
        festivals = festivals
            .where((entry) => tags.any((tag) =>
                FestivalViewModel.getLabelBySuggestType(tag.type, entry)
                    .toLowerCase()
                    .contains(tag.content)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainListViewModel>(context);

    final markers = festivals
        .where((fest) => fest.latLng != null)
        .map((fest) => makeMarker(fest))
        .toList();

    List<Suggestion> tags = [];

    final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

    return Scaffold(
        appBar: AppBar(title: const Text("Map")),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
              Expanded(
                  child: SearchBox(
                onTapped: (Suggestion value) {
                  tags.remove(value);
                  search(tags);
                },
                onChanged: (List<Suggestion> value) {
                  tags = value;
                  search(tags);
                },
                overlay: true,
                body: Expanded(
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          center: LatLng(47.5000, 1.7500),
                          zoom: 6.5,
                        ),
                        nonRotatedChildren: [
                          AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null,
                          ),
                        ],
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          MarkerClusterLayerWidget(
                            options: MarkerClusterLayerOptions(
                                maxClusterRadius: 45,
                                size: const Size(40, 40),
                                anchor: AnchorPos.align(AnchorAlign.center),
                                fitBoundsOptions: const FitBoundsOptions(
                                  padding: EdgeInsets.all(50),
                                  maxZoom: 15,
                                ),
                                markers: markers,
                                builder: (context, markers) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        markers.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      makeCard(),
                    ], //we will create this further down
                  ),
                ),
              )),
            ));
  }
}

class MapListEntry extends StatefulWidget {
  const MapListEntry({super.key});

  @override
  State<MapListEntry> createState() => _MapListEntryState();
}

class _MapListEntryState extends State<MapListEntry> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainListViewModel>(context);
    return Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => vm, child: const MapListScreen()),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton:
            const NavigationFab(currentPageType: PageType.festivalMap));
  }
}
