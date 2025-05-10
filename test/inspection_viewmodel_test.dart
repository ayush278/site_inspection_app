import 'package:flutter_test/flutter_test.dart';
import 'package:site_inspection_app/viewmodels/inspection_viewmodel.dart';
import 'package:site_inspection_app/models/inspection_item.dart';

void main() {
  group('InspectionViewModel', () {
    late InspectionViewModel viewModel;

    // Set up the viewModel before each test
    setUp(() {
      viewModel = InspectionViewModel();
      viewModel.loadInspectionItems();
    });

    test('initial inspection items are loaded', () {
      // Test that the inspection items are initially loaded (length should be 3)
      expect(viewModel.inspectionItems.length, 3);
    });

    test('status can be cycled correctly', () {
      // Test the first item starts as "pending"
      expect(viewModel.inspectionItems[0].status, InspectionStatus.pending);

      // Cycle status to "passed"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.passed);

      // Cycle status to "failed"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.failed);

      // Cycle status to "notApplicable"
      viewModel.cycleStatus(0);
      expect(
          viewModel.inspectionItems[0].status, InspectionStatus.notApplicable);

      // Cycle status back to "pending"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.pending);
    });

    test(
        'status can be cycled correctly and should stay in the new state until reset',
        () {
      // Initially, the status should be "pending"
      expect(viewModel.inspectionItems[0].status, InspectionStatus.pending);

      // Cycle to "passed"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.passed);

      // Cycle to "failed"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.failed);

      // Cycle to "notApplicable"
      viewModel.cycleStatus(0);
      expect(
          viewModel.inspectionItems[0].status, InspectionStatus.notApplicable);

      // Cycle back to "passed"
      viewModel.cycleStatus(0);
      expect(viewModel.inspectionItems[0].status, InspectionStatus.passed);

      // Now, call resetStatuses() to reset all statuses to "pending"
      viewModel.resetStatuses();

      // After reset, the status should be "pending"
      for (var item in viewModel.inspectionItems) {
        expect(item.status, InspectionStatus.pending);
      }
    });

    test('reset changes all statuses to pending', () {
      // Set some statuses
      viewModel.cycleStatus(0); // "pending" → "passed"
      viewModel.cycleStatus(1); // "pending" → "passed"
      viewModel.cycleStatus(2); // "pending" → "passed"

      // Reset all statuses
      viewModel.resetStatuses();

      // Ensure all items are back to "pending"
      for (var item in viewModel.inspectionItems) {
        expect(item.status, InspectionStatus.pending);
      }
    });
  });
}
