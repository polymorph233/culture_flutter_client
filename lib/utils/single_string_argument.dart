import 'package:flutter/widgets.dart';

class SingleArgument {
  final String value;

  SingleArgument(this.value);
}

class ExtractSingleArgumentWidget extends StatefulWidget {

  static const routeName = '/value';


  final Widget Function(String) bodyProvider;

  const ExtractSingleArgumentWidget({super.key, required this.bodyProvider});

  @override
  State<StatefulWidget> createState() => ExtractSingleArgumentState();
}

class ExtractSingleArgumentState extends State<ExtractSingleArgumentWidget> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SingleArgument;

    return widget.bodyProvider(args.value);
  }
}