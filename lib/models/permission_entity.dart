class PermissionEntity {
  int? id;
  String? studentRoll;
  String? branch;
  String? date;
  String? fromTime;
  String? outDate;
  String? reason;
  String? attachment;
  bool? granted;
  bool? rejected;
  String? qrCode;
  String? slug;
  int? phone;
  int? rollNumber;

  PermissionEntity(
      {this.id,
      this.studentRoll,
      this.branch,
      this.date,
      this.fromTime,
      this.outDate,
      this.reason,
      this.attachment,
      this.granted,
      this.rejected,
      this.qrCode,
      this.slug,
      this.phone,
      this.rollNumber});

  PermissionEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentRoll = json['student_roll'];
    branch = json['branch'];
    date = json['date'];
    fromTime = json['from_time'];
    outDate = json['out_date'];
    reason = json['reason'];
    attachment = json['attachment'];
    granted = json['granted'];
    rejected = json['rejected'];
    qrCode = json['qr_code'];
    slug = json['slug'];
    phone = json['phone'];
    rollNumber = json['roll_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_roll'] = this.studentRoll;
    data['branch'] = this.branch;
    data['date'] = this.date;
    data['from_time'] = this.fromTime;
    data['out_date'] = this.outDate;
    data['reason'] = this.reason;
    data['attachment'] = this.attachment;
    data['granted'] = this.granted;
    data['slug'] = this.slug;
    data['phone'] = this.phone;
    data['roll_number'] = this.rollNumber;
    return data;
  }
}
