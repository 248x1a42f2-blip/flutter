import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/job.dart';
import '../services/job_service.dart';

class JobProvider extends ChangeNotifier {
  final JobService service = JobService();

  List<Job> jobs = [];
  List<Job> savedJobs = [];

  bool isLoading = false;
  String? error;

  String searchText = '';
  String selectedLocation = 'All';
  String selectedType = 'All';

  void filterLocation(String value) {
    selectedLocation = value;
    notifyListeners();
  }

  void filterType(String value) {
    selectedType = value;
    notifyListeners();
  }
  List<Job> get filteredJobs {
    return jobs.where((job) {
      final q = searchText.toLowerCase();

      final matchesSearch =
          job.title.toLowerCase().contains(q) ||
          job.company.toLowerCase().contains(q) ||
          job.location.toLowerCase().contains(q);

      final matchesLocation =
          selectedLocation == 'All' ||
          job.location.toLowerCase().contains(
            selectedLocation.toLowerCase(),
          );

      final matchesType =
          selectedType == 'All' ||
          job.type.toLowerCase() == selectedType.toLowerCase();

      return matchesSearch && matchesLocation && matchesType;
    }).toList();
  }

  Future<void> loadJobs() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      jobs = await service.fetchJobs();
    } catch (e) {
      error = 'Unable to load jobs. Check your internet.';
    }

    await loadSavedJobs();

    isLoading = false;
    notifyListeners();
  }

  void searchJobs(String value) {
    searchText = value;
    notifyListeners();
  }

  bool isSaved(Job job) {
    return savedJobs.any((item) => item.id == job.id);
  }

  Future<void> toggleSaved(Job job) async {
    if (isSaved(job)) {
      savedJobs.removeWhere((item) => item.id == job.id);
    } else {
      savedJobs.add(job);
    }

    await saveToDevice();
    notifyListeners();
  }

  Future<void> saveToDevice() async {
    final prefs = await SharedPreferences.getInstance();

    final data = savedJobs.map((job) {
      return job.toJson();
    }).toList();

    await prefs.setString(
      'saved_jobs',
      jsonEncode(data),
    );
  }

  Future<void> loadSavedJobs() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('saved_jobs');

    if (data != null) {
      final List decoded = jsonDecode(data);

      savedJobs = decoded.map((item) {
        return Job.fromSavedJson(item);
      }).toList();
    }
  }
}