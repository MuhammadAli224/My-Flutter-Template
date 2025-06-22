import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeConverter on DateTime {
  String get toDMy =>
      Jiffy.parseFromDateTime(this).format(pattern: "yyyy-MM-dd");

  String get toMy => Jiffy.parseFromDateTime(this).format(pattern: "yyyy-MM");

  String get toDayMyHmAR =>
      Jiffy.parseFromDateTime(this).format(pattern: "EEEE yyyy/MM/dd h:mm a");

  String get toDMyHm =>
      Jiffy.parseFromDateTime(this).format(pattern: "yyyy-MM-dd h:mm a");

  String get toReservationDate =>
      Jiffy.parseFromDateTime(this).format(pattern: "yyyy-MM-dd H:mm");

  String get toInvoiceDate =>
      Jiffy.parseFromDateTime(this).format(pattern: "yyyy/MM/dd   hh:mm:ss a");

  String get toHm => Jiffy.parseFromDateTime(this).format(pattern: "hh:mm a");

  TimeOfDay get toTimeOfDay {
    return TimeOfDay.fromDateTime(this);
  }
}
