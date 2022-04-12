class ProfileEntity {
  int? id;
  String? lastLogin;
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  bool? isActive;
  bool? isStaff;
  bool? isSuperuser;
  String? rollNo;
  num? parentPhone;
  num? studentPhone;
  String? branch;
  bool? hostler;
  String? grantedby;
  String? dp;
  String? typeOfAccount;
  List<Null>? groups;
  List<Null>? userPermissions;

  ProfileEntity(
      {this.id,
      this.lastLogin,
      this.userId,
      this.email,
      this.firstName,
      this.lastName,
      this.isActive,
      this.isStaff,
      this.isSuperuser,
      this.rollNo,
      this.parentPhone,
      this.studentPhone,
      this.branch,
      this.hostler,
      this.grantedby,
      this.dp,
      this.typeOfAccount,
      this.groups,
      this.userPermissions});

  ProfileEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastLogin = json['last_login'];
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    rollNo = json['roll_no'];
    parentPhone = json['parent_phone'];
    studentPhone = json['student_phone'];
    branch = json['branch'];
    hostler = json['hostler'];
    grantedby = json['grantedby'];
    dp = json['dp'];
    typeOfAccount = json['type_of_account'];
  }

  Map<String, dynamic> toJson(String password, String lastname) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['last_login'] = this.lastLogin;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['roll_no'] = this.rollNo;
    data['parent_phone'] = this.parentPhone;
    data['student_phone'] = this.studentPhone;
    data['branch'] = this.branch;
    data['hostler'] = this.hostler;
    data['dp'] = this.dp;
    data['email'] = this.email;
    data['password'] = password;

    return data;
  }
}
