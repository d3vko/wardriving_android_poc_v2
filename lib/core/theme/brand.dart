import 'package:flutter/material.dart';

/// Identidad BugCON 2026 + RF Village MX. Arte de villa by d3v.k0.
///
/// Material 3 dark: el lima saturado sólo en CTA. Superficies #121212
/// para que el acento no vibre (developer.android.com/design/ui/mobile/guides/styles/color).
class Brand {
  Brand._();

  static const campo = Color(0xFF121212);
  static const tinta = Color(0xFF180F2C);
  static const lima = Color(0xFF4EE08A);
  static const limaBorde = Color(0xFF42BE75);
  static const violeta = Color(0xFF5450EB);
  static const villaVioleta = Color(0xFF7A4DFF);
  static const crema = Color(0xFFE5EBE4);
  static const tarjeta = Color(0xFF1C1C1C);

  static const mascot = 'assets/brand/mascot.png';
  static const villageMark = 'assets/brand/rf_village_mark.png';
  static const villageFull = 'assets/brand/rf_village.png';
  static const bugconLogo = 'assets/brand/bugcon_logo.png';
  static const bugconBadge = 'assets/brand/bugcon_badge.png';

  static const credit = 'by d3v.k0';
  static const activity = 'Pecera del WiFi';
  static const eventLine = 'BugCON 2026';
  static const villageLine = 'RF Village MX';
}

class CreditLine extends StatelessWidget {
  const CreditLine({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: Brand.crema.withValues(alpha: 0.55),
    );
    return Text(
      compact ? Brand.credit : '${Brand.activity} · ${Brand.eventLine} · ${Brand.credit}',
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
