import 'package:flutter/widgets.dart';

const textInputPassword = TextInputType.numberWithOptions(
  decimal: false,
  signed: false,
);

bool disabledSundayPredicate(DateTime day) => day.weekday != DateTime.sunday;
