import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

Color colorOfStateColor(int idStateQuota) {
  switch (idStateQuota) {
    case 1:
      return alertColor();
    case 2:
      return successColor();
    default:
      return dangerColor();
  }
}
