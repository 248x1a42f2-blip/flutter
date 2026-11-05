import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/job.dart';

class JobService {
  final String apiUrl =
      'https://remotive.com/api/remote-jobs?limit=50';

  Future<List<Job>> fetchJobs() async {
    final response = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List jobs = data['jobs'];

      return jobs.map((item) {
        return Job.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}