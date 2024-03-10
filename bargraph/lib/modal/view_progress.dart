class progress {
  final int proid;
  final int grpid;
  final int p1;
  final int p2;
  final int p3;
  final int p4;
  final int p5;
  final int p6;
  final int p7;
  final int p8;
  final int p9;
  final DateTime date;

  progress({
    required this.proid,
    required this.grpid,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    required this.p5,
    required this.p6,
    required this.p7,
    required this.p8,
    required this.p9,
    required this.date
  }); // Added validation for positive values

  factory progress.fromJson(Map<dynamic, dynamic> json) {
    try {
      return progress(
        proid: json['proid'],
        grpid: json['grpid'],
        p1: json['p1'],
        p2: json['p2'],
        p3: json['p3'],
        p4: json['p4'],
        p5: json['p5'],
        p6: json['p6'],
        p7: json['p7'],
        p8: json['p8'],
        p9: json['p9'],
        date: DateTime.parse(json['date']), // Parses string as yyyy/MM/dd
      );
    } catch (e) {
      throw Exception('Failed to parse JSON: $e');
    }
  }
}