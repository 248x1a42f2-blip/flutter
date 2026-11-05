class Job {
  final int id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String description;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] ?? 'Unknown Job',
      company: json['company_name'] ?? 'Unknown Company',
      location:
          json['candidate_required_location'] ?? 'Remote',
      type: json['job_type'] ?? 'Not specified',
      description: cleanDescription(
        json['description'] ?? 'No description available',
      ),
    );
  }

  static String cleanDescription(String html) {
    return html
        .replaceAll(
          RegExp(r'<br\s*/?>', caseSensitive: false),
          '\n',
        )
        .replaceAll(
          RegExp(r'</p>|</li>|</h[1-6]>', caseSensitive: false),
          '\n',
        )
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'type': type,
      'description': description,
    };
  }

  factory Job.fromSavedJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
    );
  }
}