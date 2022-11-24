import 'dart:math';

import 'package:flutter/widgets.dart';

import '../models/festival.dart';

class ImageProviderService {
  static Image randomImage(Domain of) {

    Image construct(String keyword) => Image.asset("assets/images/catalogs/$keyword/$keyword${Random().nextInt(6) + 1}.png");

    switch (of) {
      case Domain.visualNumericArts:
        return construct("visual");
      case Domain.cinema:
        return construct("cinema");
      case Domain.literature:
        return construct("literature");
      case Domain.music:
        return construct("music");
      case Domain.pluridiscipline:
        return construct("pluri");
      case Domain.liveScene:
        return construct("live");

    }
  }
}