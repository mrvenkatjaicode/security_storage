import 'package:flutter/material.dart';
import 'package:secure_storage_example/utils/user_secure_storage.dart';
import 'package:secure_storage_example/widget/button_widget.dart';

import 'secondpage.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerPassword = TextEditingController();

  DateTime? birthday;
  List<String> pets = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getUserpassword() ?? '';

    setState(() {
      this.controllerName.text = name;
      this.controllerPassword.text = password;
      this.birthday = birthday;
      this.pets = pets;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Login",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              const SizedBox(height: 32),
              buildName(),
              const SizedBox(height: 32),
              buildPassword(),
              const SizedBox(height: 32),
              buildButton(),
            ],
          ),
        ),
      );

  Widget buildName() => buildTitle(
        title: 'Name',
        child: TextFormField(
          controller: controllerName,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Name',
          ),
        ),
      );
  Widget buildPassword() => buildTitle(
        title: 'Password',
        child: TextFormField(
          controller: controllerPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Password',
          ),
        ),
      );

  Widget buildButton() => ButtonWidget(
      text: 'Login',
      onClicked: () async {
        await UserSecureStorage.setUsername(controllerName.text);
        await UserSecureStorage.setUserpassword(controllerPassword.text);
        if (controllerName.text.isEmpty) {
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondPage(controllerName.text)),
          );
        }
      });

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
