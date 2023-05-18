import 'dart:ui';

extension FW on FontWeight {
  FontVariation get variants => FontVariation('wght', value.toDouble());
}
