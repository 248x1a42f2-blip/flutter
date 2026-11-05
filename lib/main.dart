import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/job_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => JobProvider()..loadJobs(),
      child: const JobReaderApp(),
    ),
  );
}

class JobReaderApp extends StatelessWidget {
  const JobReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Reader',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.theme,

      home: const HomeScreen(),
    );
  }
}