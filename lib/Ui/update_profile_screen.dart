import 'dart:convert';
import 'dart:typed_data'; // Correct way to use Uint8List

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:untitled/Data/Models/user_model.dart';
import 'package:untitled/Data/service/network_caller.dart';
import 'package:untitled/Data/urls.dart';
import 'package:untitled/Ui/controler/auth_controler.dart';

import 'package:untitled/Widget/app_bar.dart';
import 'package:untitled/Widget/backgroud_screen.dart';
import 'package:untitled/Widget/snackbar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static String name = "/update_profile_screen";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    // Load existing user data
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _phoneTEController.text = AuthController.userModel?.mobile ?? '';
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Uint8List? imageBytes;

    Map<String, String> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }

    if (_selectedImage != null) {
      imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      UserModel userModel = UserModel(
        id: AuthController.userModel!.id,
        email: _emailTEController.text,
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _phoneTEController.text.trim(),
        photo: imageBytes == null
            ? AuthController.userModel?.photo
            : base64Encode(imageBytes),
      );

      await AuthController.updateUserData(userModel);
      _passwordTEController.clear();

      if (mounted) {
        showSnackBarMessage(context, 'Profile updated');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errormessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text("Update Profile", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25),
                _buildPhotoPicker(),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: "Email"),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: "First name"),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your First name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: "Last name"),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your Last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: const InputDecoration(hintText: "Number"),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Password"),
                  validator: (value) {
                    int length = value?.length ?? 0;
                    if (length > 0 && length <= 6) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                _updateProfileInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Photo",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _selectedImage?.name ?? "Select a photo",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
