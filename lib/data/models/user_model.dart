import 'package:qr_code_task/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {super.status,
      super.message,
      super.id,
      super.email,
      super.token,
      super.name,
      super.address,
      super.phone,
      super.job,
      super.img,
      super.salary});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json['status'] ?? -1,
        message: json['massage'] ?? '',
        id: json['data']['user']['id'] ?? -1,
        email: json['data']['user']['email'] ?? '',
        token: json['data']['token'] ?? '',
        name: json['data']['user']['name'] ?? '',
        address: json['data']['user']['address'] ?? '',
        phone: json['data']['user']['phone'] ?? '',
        job: json['data']['user']['job'] ?? '',
        img: json['data']['user']['img'] ?? '',
        salary: json['data']['user']['salary'] ?? '',
      );
}
