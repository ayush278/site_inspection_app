enum InspectionStatus { pending, passed, failed, notApplicable }

class InspectionItem {
  final String name;
  InspectionStatus status;

  InspectionItem({
    required this.name,
    this.status = InspectionStatus.pending,
  });
}
