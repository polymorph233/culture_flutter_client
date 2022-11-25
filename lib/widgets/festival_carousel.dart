import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:culture_flutter_client/services/img_provider_service.dart';
import 'package:flutter/material.dart';

import '../models/festival.dart';
import '../utils/single_string_argument.dart';
import '../view_models/festival_view_model.dart';

class FestivalCarousel extends StatefulWidget {

  final List<FestivalViewModel> festivals;

  const FestivalCarousel({super.key, required this.festivals});

  @override State<StatefulWidget> createState() => FestivalCarouselState();
}

class FestivalCarouselState extends State<FestivalCarousel> {

  int _current = 0;

  final CarouselController _controller = CarouselController();

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
                          child: ImageProviderService.randomImage(item.domain),
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
                            Expanded(child: Text(
                              "   ${item.name.length > 14 ? "${item.name.substring(0, 14)}..." : item.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            IconButton(onPressed: () =>
                              Navigator.pushNamed(
                                context,
                                ExtractSingleArgumentWidget.routeName,
                                arguments: SingleArgument(item.id.toString())), icon: const Icon(Icons.arrow_forward_ios, color: Colors.white,))
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