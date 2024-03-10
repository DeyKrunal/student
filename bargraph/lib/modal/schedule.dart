class schedule {
  final int subid;
  final int fid;
  final int? msid; // Nullable field
  final String subWeeklyDate;
  final String subRemark;
  final String subStartDate;
  final String subEndDate;

  schedule({
    required this.subid,
    required this.fid,
    this.msid,
    required this.subWeeklyDate,
    required this.subRemark,
    required this.subStartDate,
    required this.subEndDate,
  });

  factory schedule.fromJson(Map<String, dynamic> json) {
    return schedule(
      subid: json['subid'],
      fid: json['fid'],
      msid: json['msid'],
      subWeeklyDate: json['sub_weekly_date'],
      subRemark: json['sub_remark'],
      subStartDate: json['sub_start_date'],
      subEndDate: json['sub_end_date'],
    );
  }
}