
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:culture_flutter_client/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../widgets/festival_list.dart';

class MapListScreen extends StatefulWidget {
  const MapListScreen({super.key});

  @override
  _MapListScreenState createState() => _MapListScreenState();
}
class _MapListScreenState extends State<MapListScreen> {

  List<FestivalViewModel> festivals = [];

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<MainListViewModel>(context, listen: false);

    vm.update().then((_) =>
        setState(() =>{ festivals = vm.festivals}));
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  Marker _fromPlace(Place p) {
    return Marker(point: LatLng(p.lat, p.lon), builder: (_) => const Icon(Icons.pin_drop));
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<MainListViewModel>(context);

    final markers = festivals.where((fest) => fest.place != null).map((fest) => _fromPlace(fest.place!)).toList();

    List<String> tags = [];

    final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

    return Scaffold(
        appBar: AppBar(
            title: const Text("All Festivals")
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Expanded(child:
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
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }),
                    )
                  ],
                ),
              ),//we will create this further down
            ])
        )
    );
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
            create: (context) => vm,
            child: const MapListScreen()
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const NavigationFab(currentPageType: PageType.festivalMap)
    );
  }
}
