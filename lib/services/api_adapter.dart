import '../models/inspection_item.dart';

class ApiAdapter {
  static List<InspectionItem> getInspectionItems() {
    return [
      InspectionItem(name: 'Scaffolding'),
      InspectionItem(name: 'Electrical Wiring'),
      InspectionItem(name: 'Personal Protective Equipment'),
    ];
  }
}
