import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Reader',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: selectedIndex == 0
          ? buildJobs(provider)
          : const SavedScreen(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }

  Widget buildJobs(JobProvider provider) {
    if (provider.isLoading && provider.jobs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null && provider.jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(provider.error!),
            ElevatedButton(
              onPressed: provider.loadJobs,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                onChanged: provider.searchJobs,
                decoration: const InputDecoration(
                  hintText: 'Search jobs...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: context.watch<JobProvider>().selectedLocation,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                      items: ['All', 'India', 'Remote', 'United States']
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          context.read<JobProvider>().filterLocation(v);
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: context.watch<JobProvider>().selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Job Type',
                      ),
                      items: [
                        'All',
                        'full_time',
                        'part_time',
                        'contract',
                        'internship',
                      ].map((v) => DropdownMenuItem(
                            value: v,
                            child: Text(v),
                          )).toList(),
                      onChanged: (v) {
                        if (v != null) {
                          context.read<JobProvider>().filterType(v);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: RefreshIndicator(
            onRefresh: provider.loadJobs,
            child: ListView.builder(
              itemCount: provider.filteredJobs.length,
              itemBuilder: (context, index) {
                final job = provider.filteredJobs[index];

                return JobCard(
                  job: job,
                  saved: provider.isSaved(job),
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
            ),
          ),
        ),
      ],
    );
  }
}