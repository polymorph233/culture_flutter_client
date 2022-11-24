import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/festival.dart';
import '../view_models/festival_view_model.dart';

class FestivalCarousel extends StatefulWidget {

  final List<FestivalViewModel> festivals;

  const FestivalCarousel({super.key, required this.festivals});

  @override State<StatefulWidget> createState() => FestivalCarouselState();
}

class FestivalCarouselState extends State<FestivalCarousel> {

  int _current = 0;

  final CarouselController _controller = CarouselController();

  static const imagePaths = {
    "cinema": ["cinema1.jpg", "cinema2.jpeg", "cinema3.jpg"],
    "literature": ["literature1.jpg", "literature2.jpg"],
    "live": ["live1.jpeg", "live2.jpg", "live3.jpg"],
    "music": ["music1.jpg", "music2.jpeg"],
    "pluri": ["pluri1.jpg", "pluri2.jpg", "pluri3.jpg"],
    "visual": ["visual1.jpg", "visual2.jpg", "visual3.jpg"],
  };

  static final images =
  imagePaths.map((key, value) => MapEntry(key, value.map((e) => Image.asset("assets/images/catalogs/$e")).toList()));

  static Image randomImage(Domain of) {
    switch (of) {
      case Domain.visualNumericArts:
        final list = images["visual"]!;
        return list[Random().nextInt(list.length)];
      case Domain.cinema:
        final list = images["cinema"]!;
        return list[Random().nextInt(list.length)];
      case Domain.literature:
        final list = images["literature"]!;
        return list[Random().nextInt(list.length)];
      case Domain.music:
        final list = images["music"]!;
        return list[Random().nextInt(list.length)];
      case Domain.pluridiscipline:
        final list = images["pluri"]!;
        return list[Random().nextInt(list.length)];
      case Domain.liveScene:
        final list = images["live"]!;
        return list[Random().nextInt(list.length)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Expanded(child:
            widget.festivals.isEmpty ? Center(child: CircularProgressIndicator()) :
            CarouselSlider(
            items: widget.festivals.map((item) =>
              Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: randomImage(item.domain),
                      )),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          child: Row(children: [
                            Icon(categoryIcon(item.domain), color: Colors.white),
                            Text(
                              "   ${item.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      ),
                      )],
                  )),
              ))
              .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.festivals.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 9.0,
                height: 9.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        )
    ]);
  }
}