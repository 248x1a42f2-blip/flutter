import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();

    if (provider.savedJobs.isEmpty) {
      return const Center(
        child: Text('No saved jobs yet'),
      );
    }

    return ListView.builder(
      itemCount: provider.savedJobs.length,
      itemBuilder: (context, index) {
        final job = provider.savedJobs[index];

        return JobCard(
          job: job,
          saved: true,
          onSave: () => provider.toggleSaved(job),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobDetailScreen(job: job),
              ),
            );
          },
        );
      },
    );
  }
}