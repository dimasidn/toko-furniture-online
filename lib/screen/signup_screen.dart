import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Image.asset(
                'assets/vector_1.jpg',
                height: 300,
                width: 300,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 70),
                child: TextFormField(
                  style: TextStyle(color: Colors.pinkAccent),
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(18),
                        child: Icon(Icons.person, color: Colors.brown[300]),
                      ),
                      filled: true,
                      fillColor: Colors.brown[50],
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 15),
                            child: Icon(Icons.lock, color: Colors.brown[300]),
                          ),
                          suffixIcon: IconButton(
                            icon: hidePassword
                                ? Icon(Icons.visibility_off,
                                    color: Colors.brown[300])
                                : Icon(Icons.visibility,
                                    color: Colors.pinkAccent),
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword),
                            padding: const EdgeInsets.all(18),
                          ),
                          filled: true,
                          fillColor: Colors.brown[50],
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 70),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.brown[300],
                      minimumSize: const Size.fromHeight(62),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {},
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account ?"),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                          ))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child:
                              Divider(color: Colors.brown[300], endIndent: 5)),
                      Text('OR', style: TextStyle(color: Colors.brown[300])),
                      Expanded(
                          child: Divider(color: Colors.brown[300], indent: 5))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/imageicon_fb.png'),
                          iconSize: 40),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/imageicon_tw.png'),
                          iconSize: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/imageicon_gp.png'),
                          iconSize: 40)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
