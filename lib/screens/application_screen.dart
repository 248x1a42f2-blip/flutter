import 'package:flutter/material.dart';
import '../models/job.dart';

class ApplicationScreen extends StatefulWidget {
  final Job job;

  const ApplicationScreen({
    super.key,
    required this.job,
  });

  @override
  State<ApplicationScreen> createState() =>
      _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for Job')),

      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Position: ${widget.job.title}'),

            const SizedBox(height: 20),

            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
              validator: (v) =>
                  v == null || v.trim().length < 2
                      ? 'Enter your name'
                      : null,
            ),

            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (v) =>
                  v == null ||
                          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(v)
                      ? 'Enter valid email'
                      : null,
            ),

            TextFormField(
              controller: phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null ||
                          !RegExp(r'^\+?[0-9]{10,15}$')
                              .hasMatch(v.trim())
                      ? 'Enter valid phone number'
                      : null,
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Application details validated successfully!',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Submit Application'),
            ),
          ],
        ),
      ),
    );
  }
}