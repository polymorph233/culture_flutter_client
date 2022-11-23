import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../view_models/festival_view_model.dart';

class FestivalCarousel {
  
  CarouselSlider carouselSlider;

  FestivalCarousel({required List<FestivalViewModel> festivals}):
    carouselSlider = CarouselSlider(
      items: festivals.map((i) {
        return Builder(builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(color: Colors.amber),
            child: Center(child: Text(i.name))
          );
        });
    }).toList(), options: CarouselOptions(height: 400.0));
}