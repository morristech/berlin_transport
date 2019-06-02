/// Widgets shared across the app

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:berlin_transport/data/localization.dart';
import 'package:berlin_transport/data/models.dart';
import 'package:berlin_transport/data/data.dart';

/// Overrides the phone's locale, only if a locale is provided
class OverrideLocalization extends StatelessWidget {
  OverrideLocalization({this.locale, this.child});
  final Locale locale;
  final Widget child;

  @override
  Widget build(BuildContext context) => locale != null
      ? Localizations.override(
          context: context,
          locale: locale,
          child: child,
        )
      : child;

  Widget build2(BuildContext build) {
    return Consumer<PrefsNotifier>(
        builder: (context, notifier, _) => locale != null
            ? Localizations.override(
                context: context,
                locale: locale,
                child: child,
              )
            : child);
  }
}

/// Text search box for places : UNUSED
class PlacesSearchBox extends StatefulWidget {
  @override
  _PlacesSearchBoxState createState() => _PlacesSearchBoxState();
}

class _PlacesSearchBoxState extends State<PlacesSearchBox> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.of(context).searchHintText,
            ),
          ),
        ),
        FlatButton.icon(
          icon: Icon(Icons.search),
          label: Text(AppLocalizations.of(context).search),
          onPressed: () => _controller.text != null
              ? null // Provider.of<PlacesNotifier>(context).search(_controller.text)
              : null,
        ),
      ],
    );
  }
}

class TransportIcon extends StatelessWidget {
  TransportIcon(this.type);
  final StopType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case StopType.suburban:
        return const Icon(Icons.train);
      case StopType.subway:
        return const Icon(Icons.subway);
      case StopType.tram:
        return const Icon(Icons.tram);
      case StopType.bus:

      case StopType.ferry:
        return const Icon(Icons.train);
      case StopType.express:
      case StopType.regional:
        return const Icon(Icons.train);
      default:
        return const Icon(Icons.directions_walk);
    }
  }
}
