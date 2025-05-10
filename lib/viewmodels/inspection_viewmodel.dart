import 'package:flutter/foundation.dart';
import '../models/inspection_item.dart';
import '../services/api_adapter.dart';

class InspectionViewModel extends ChangeNotifier {
  List<InspectionItem> _inspectionItems = [];

  List<InspectionItem> get inspectionItems => _inspectionItems;

  void loadInspectionItems() {
    _inspectionItems = ApiAdapter.getInspectionItems();
    notifyListeners();
  }

  void cycleStatus(int index) {
    final current = _inspectionItems[index].status;
    InspectionStatus newStatus;

    switch (current) {
      case InspectionStatus.pending:
        newStatus = InspectionStatus.passed;
        break;
      case InspectionStatus.passed:
        newStatus = InspectionStatus.failed;
        break;
      case InspectionStatus.failed:
        newStatus = InspectionStatus.notApplicable;
        break;
      case InspectionStatus.notApplicable:
        newStatus = InspectionStatus.passed;
        break;
    }

    _inspectionItems[index].status = newStatus;
    notifyListeners();
  }

  void resetStatuses() {
    for (var item in _inspectionItems) {
      item.status = InspectionStatus.pending;
    }
    notifyListeners();
  }

  String get inspectionSummary {
    final passed = _inspectionItems
        .where((item) => item.status == InspectionStatus.passed)
        .length;
    return '$passed / ${_inspectionItems.length} Passed';
  }
}
