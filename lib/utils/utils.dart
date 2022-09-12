import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  //method to convert timestamp sent by firebase to DateTime
  static DateTime? toDateTime(Timestamp value) {
    if (value == null) {
      return null;
    }
    return value.toDate();
  }

  //method to convert to DateTime into json for firebase
  static dynamic fromDateTimeToJson(DateTime createdTime) {
    if (createdTime == null ) {
      return null;
    }
    return createdTime.toUtc();
  }


  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>> transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>>  data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );
}
