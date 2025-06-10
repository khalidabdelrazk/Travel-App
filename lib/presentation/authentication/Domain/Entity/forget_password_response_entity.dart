class ForgetPasswordResponseEntity {
  ForgetPasswordResponseEntity({
      this.message,this.error,});

  ForgetPasswordResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
  }
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}