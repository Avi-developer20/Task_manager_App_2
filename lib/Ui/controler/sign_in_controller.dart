import 'package:get/get.dart';
import 'package:untitled/Data/Models/task_model.dart';
import 'package:untitled/Data/Models/user_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Ui/controler/auth_controler.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.Login, body: requestBody, isFormLogin: true
    );
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errormessage!;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}