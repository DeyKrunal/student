class group {
  final String gsid;
  final String name1;
  final String rn1;
  final String div1;
  final String phno1;
  final String email1;
  final String name2;
  final String rn2;
  final String div2;
  final String phno2;
  final String email2;
  final String name3;
  final String rn3;
  final String div3;
  final String phno3;
  final String email3;
  final String name4;
  final String rn4;
  final String div4;
  final String phno4;
  final String email4;
  final String image;
  final String facultyId;
  final String groupName;
  final String pass;
  final String status;

  group({
    required this.gsid,
    required this.name1,
    required this.rn1,
    required this.div1,
    required this.phno1,
    required this.email1,
    required this.name2,
    required this.rn2,
    required this.div2,
    required this.phno2,
    required this.email2,
    required this.name3,
    required this.rn3,
    required this.div3,
    required this.phno3,
    required this.email3,
    required this.name4,
    required this.rn4,
    required this.div4,
    required this.phno4,
    required this.email4,
    required this.image,
    required this.facultyId,
    required this.groupName,
    required this.pass,
    required this.status
  });

  factory group.fromJson(Map<String, dynamic> json) {
    return group(
        gsid: json['gsid'] as String,
        name1: json['name1']as String,
        rn1: json['rn1']as String,
        div1: json['div1']as String,
        phno1: json['phno1']as String,
        email1: json['email1']as String,
        name2: json['name2']as String,
        rn2: json['rn2']as String,
        div2: json['div2']as String,
        phno2: json['phno2']as String,
        email2: json['email2']as String,
        name3: json['name3']as String,
        rn3: json['rn3']as String,
        div3: json['div3']as String,
        phno3: json['phno3']as String,
        email3: json['email3']as String,
        name4: json['name4'] ?? ''as String,
        rn4: json['rn4'] ?? ''as String,
        div4: json['div4'] ?? ''as String,
        phno4: json['phno4'] ?? ''as String,
        email4: json['email4'] ?? ''as String,
        image: json['image']as String,
        facultyId: json['faculty_id']as String,
        groupName: json['group_name']as String,
        pass: json['pass']as String,
        status: json['status']as String
    );
  }
}