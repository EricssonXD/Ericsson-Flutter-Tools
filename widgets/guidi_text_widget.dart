import 'package:flutter/material.dart';
import 'package:guidi/languages/localizations.dart';
import 'package:guidi/misc/theme.dart';

class GuidiTitleWidget extends StatelessWidget {
  const GuidiTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Text(
        AppLocalizations.of(context)!.guidi,
        style: GUIDiTheme.bigGuidiTitle,
      ),
    );
  }
}
