import 'package:flutter/material.dart';
import 'package:abhoy_catering/l10n/app_localizations.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.contact)),
      body: Center(child: Text(l10n.contact + ' - Form will go here')),
    );
  }
}
