import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class FacityWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  const FacityWidget({Key? key, required this.iconData, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FxContainer.bordered(
      margin: const EdgeInsets.only(left: 8, right: 8),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: FxText.bodySmall(text,
                  letterSpacing: 0,
                  fontWeight: 600,
                  color: theme.colorScheme.onBackground),
            )
          ],
        ),
      ),
    );
  }
}
