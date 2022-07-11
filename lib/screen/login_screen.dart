import 'package:flutter/material.dart';
import '../conf/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _isClicked = false;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: const Text('Fitur dalam pengembangan'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              Image.asset('assets/vector_2.jpg', height: 250, width: 250),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            width: 1.7,
                            style: BorderStyle.solid,
                            color: Colors.pinkAccent)),
                    label: const Text('Email'),
                    hintText: 'Masukkan email',
                    prefixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: TextFormField(
                  controller: _pwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            width: 1.7,
                            style: BorderStyle.solid,
                            color: Colors.pinkAccent)),
                    label: const Text('Password'),
                    hintText: 'Masukkan password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      onPressed: () => _snackBarCustom(),
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[300])))
                ],
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(milliseconds: 500),
                        splashFactory: InkSparkle.splashFactory,
                        primary: Colors.pinkAccent,
                        minimumSize: const Size(120, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_emailController.text == "" ||
                          _pwdController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.red,
                            content: const Text("Fill the form first!")));
                        return;
                      }
                      setState(() {
                        _isClicked = true;
                      });
                      var log = await Auth.signin(
                          _emailController.text, _pwdController.text);
                      setState(() {
                        _isClicked = false;
                      });
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              log == null ? Colors.green : Colors.red,
                          content: Text(log ?? "Logged in!")));
                      if (log == null) {
                        Navigator.pushReplacementNamed(context, "/dashboard");
                      } else {
                        print(log);
                      }
                    },
                    child: _isClicked == false
                        ? const Text('LOGIN')
                        : const CircularProgressIndicator(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              const Text('Or connect using'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      splashRadius: 1,
                      onPressed: () => _snackBarCustom(),
                      icon: Image.asset('assets/imageicon_fb.png'),
                      iconSize: 40),
                  IconButton(
                      splashRadius: 1,
                      onPressed: () => _snackBarCustom(),
                      icon: Image.asset('assets/imageicon_tw.png'),
                      iconSize: 40,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30)),
                  IconButton(
                      splashRadius: 1,
                      onPressed: () => _snackBarCustom(),
                      icon: Image.asset('assets/imageicon_gp.png'),
                      iconSize: 40),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Dont have an Account ? ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent),
                    ),
                    onPressed: () => Navigator.pushNamed(context, "/signup"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
