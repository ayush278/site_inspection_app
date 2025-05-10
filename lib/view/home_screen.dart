import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/inspection_viewmodel.dart';
import '../models/inspection_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InspectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Site Inspection Checklist'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => viewModel.resetStatuses(),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(viewModel.inspectionSummary, style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.inspectionItems.length,
              itemBuilder: (context, index) {
                final item = viewModel.inspectionItems[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: _statusIcon(item.status),
                  onTap: () {
                    viewModel.cycleStatus(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(InspectionStatus status) {
    switch (status) {
      case InspectionStatus.passed:
        return Icon(Icons.check, color: Colors.green);
      case InspectionStatus.failed:
        return Icon(Icons.close, color: Colors.red);
      case InspectionStatus.notApplicable:
        return Icon(Icons.remove_circle_outline, color: Colors.grey);
      case InspectionStatus.pending:
        return Icon(Icons.access_time, color: Colors.blue);
    }
  }
}
