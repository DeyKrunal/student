class Faculty {
  final String fid;
  final String fName;
  final String fEmail;
  final String fPhno;
  final String fImg;
  final String fDesc;
  final String fQualif;
  final String fExp;
  final String fAddress;
  final String fPwd;

  Faculty({
    required this.fid,
    required this.fName,
    required this.fEmail,
    required this.fPhno,
    required this.fImg,
    required this.fDesc,
    required this.fQualif,
    required this.fExp,
    required this.fAddress,
    required this.fPwd,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      fid: json['fid'],
      fName: json['f_name'],
      fEmail: json['f_email'],
      fPhno: json['f_phno'],
      fImg: json['f_img'],
      fDesc: json['f_desc'],
      fQualif: json['f_qualif'],
      fExp: json['f_exp'],
      fAddress: json['f_address'],
      fPwd: json['f_pwd'],
    );
  }
}