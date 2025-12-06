class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    // PERBAIKAN: Sesuaikan dengan respon Postman Anda
    // JSON 'status' (200) --> dipetakan ke variable 'code'
    // JSON 'success' (true) --> dipetakan ke variable 'status'
    
    if (obj['status'] == 200) {
      return Login(
        code: obj['status'],
        status: obj['success'], 
        token: obj['data']['token'],
        // Gunakan toString() dulu baru parse agar aman jika ID dikirim sebagai String/Int
        userID: int.tryParse(obj['data']['user']['id'].toString()),
        userEmail: obj['data']['user']['email'],
      );
    } else {
      return Login(
        code: obj['status'],
        status: false,
        // Data lain biarkan null
      );
    }
  }
}