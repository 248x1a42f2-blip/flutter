import 'package:flutter/material.dart';
import '../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  final VoidCallback onSave;
  final bool saved;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onSave,
    required this.saved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.work),
        ),
        title: Text(
          job.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${job.company}\n${job.location}',
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(
            saved ? Icons.bookmark : Icons.bookmark_border,
          ),
          onPressed: onSave,
        ),
      ),
    );
  }
}