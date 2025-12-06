import 'package:responsi2mobile_paket3h1d023107/helpers/user_info.dart';
class LogoutBloc {
static Future logout() async {
await UserInfo().logout();
}
}