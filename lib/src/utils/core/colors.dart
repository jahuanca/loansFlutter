import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

Color colorOfStateQuota(int idStateQuota) {
  switch (idStateQuota) {
    case 1:
      return alertColor();
    case 2:
      return successColor();
    default:
      return dangerColor();
  }
}

Color colorOfStateLoan(int idStateLoan) {
  switch (idStateLoan) {
    case 1:
      return dangerColor();
    default:
      return successColor();
  }
}