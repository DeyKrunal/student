class FAQ {
  final String id;
  final String question;
  final String answer;
  final DateTime? timestamp; // Nullable field

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
    this.timestamp,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    // Check if required fields are present in the JSON data
    if (!json.containsKey('id') || !json.containsKey('question') || !json.containsKey('answer')) {
      throw FormatException('Invalid JSON format for FAQ');
    }

    return FAQ(
      id: json['id'].toString(), // Convert to String if necessary
      question: json['question'],
      answer: json['answer'],
      timestamp: json.containsKey('timestamp') ? DateTime.tryParse(json['timestamp']) : null,
    );
  }
}
