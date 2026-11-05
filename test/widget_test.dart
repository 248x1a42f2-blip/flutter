import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_reader/models/job.dart';
import 'package:job_reader/widgets/job_card.dart';

void main() {
  test('Job JSON conversion works', () {
    final job = Job.fromJson({
      'id': 101,
      'title': 'Flutter Developer',
      'company_name': 'Google',
      'candidate_required_location': 'India',
      'job_type': 'full_time',
      'description': 'Flutter development',
    });

    expect(job.title, 'Flutter Developer');
    expect(job.company, 'Google');
    expect(job.location, 'India');
  });

  testWidgets('Job card displays job information',
      (tester) async {
    final job = Job(
      id: 1,
      title: 'Flutter Developer',
      company: 'Google',
      location: 'India',
      type: 'Full-time',
      description: 'Flutter development',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: JobCard(
            job: job,
            saved: false,
            onTap: () {},
            onSave: () {},
          ),
        ),
      ),
    );

    expect(find.text('Flutter Developer'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
  });
}