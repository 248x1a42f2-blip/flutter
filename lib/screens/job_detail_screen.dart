import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';
import '../providers/job_provider.dart';
import 'application_screen.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text('Company: ${job.company}'),
            Text('Location: ${job.location}'),
            Text('Job Type: ${job.type}'),

            const Divider(height: 30),

            const Text(
              'Job Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(job.description),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ApplicationScreen(job: job),
                  ),
                );
              },
              child: const Text('Apply Now'),
            ),

            TextButton(
              onPressed: () => provider.toggleSaved(job),
              child: Text(
                provider.isSaved(job)
                    ? 'Remove from Saved'
                    : 'Save Job',
              ),
            ),
          ],
        ),
      ),
    );
  }
}