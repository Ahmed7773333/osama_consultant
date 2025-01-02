import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.terms_and_conditions_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(AppLocalizations.of(context)!.terms_and_conditions),
      ),
    );
  }
}

class HowToUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.how_to_use_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(AppLocalizations.of(context)!.how_to_use),
      ),
    );
  }
}
