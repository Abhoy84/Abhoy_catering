import 'package:flutter/material.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.menu)),
      body: Center(child: Text(l10n.menu + ' - Coming Soon')),
    );
  }
}
