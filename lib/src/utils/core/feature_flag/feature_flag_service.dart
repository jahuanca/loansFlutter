import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loands_flutter/src/utils/core/feature_flag/feature_flag_document.dart';
import 'package:loands_flutter/src/utils/core/feature_flag/flags.dart';

class FeatureFlagService extends GetxService {
  final CollectionReference _collectionInitial =
      FirebaseFirestore.instance.collection('featureFlag');

  final List<FeatureFlagDocument> _documents = [];

  StreamSubscription? _subscription;

  @override
  void onInit() {
    _initialize();
    super.onInit();
  }

  Future<void> _initialize() async {
    _subscription = _collectionInitial.snapshots().listen((snapshot) {
      _documents.clear();
      for (final doc in snapshot.docs) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          FeatureFlagDocument e =
              FeatureFlagDocument.fromMap(data);
          e.title = doc.id;
          _documents.add(e);
        }
      }
    });
  }

  bool isEnabled(Flag flag) {
    FeatureFlagDocument? doc = _documents.firstWhereOrNull((e) => e.title == flag.document.name);
    if (doc != null) {
      OptionFlag? option = doc.options.firstWhereOrNull((e) => e.code == flag.code);
      if (option != null) {
        return option.avalaiblePlatform.android;
      }
      return doc.avalaiblePlatform.android;
    }
    return true;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

bool checkFeatureFlag(Flag flag) =>
    Get.find<FeatureFlagService>().isEnabled(flag);
