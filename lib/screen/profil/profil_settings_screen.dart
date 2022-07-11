import 'package:flutter/material.dart';
import '../../conf/auth.dart';

class ProfilSettingsScreen extends StatefulWidget {
  const ProfilSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfilSettingsScreen> createState() => _ProfilSettingsScreenState();
}

class _ProfilSettingsScreenState extends State<ProfilSettingsScreen> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Profil Settings', style: TextStyle(color: Colors.brown[400])),
        backgroundColor: const Color(0xfff7f7f7),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            splashRadius: 24,
            splashColor: Colors.pink.withOpacity(0.2),
            icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent)),
      ),
      backgroundColor: const Color(0xfff7f7f7),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            ListTile(
                onTap: () =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      content: const Text('Fitur dalam pengembangan :)'),
                    )),
                title: const Text('Ubah Email',
                    style: TextStyle(fontSize: 16, color: Colors.black))),
            Divider(height: 10, color: Colors.brown[400], thickness: 1),
            ListTile(
                onTap: () async {
                  setState(() {
                    _isClicked = true;
                  });
                  var log = await Auth.signout();
                  setState(() {
                    _isClicked = false;
                  });
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 1),
                      backgroundColor: log == null ? Colors.green : Colors.red,
                      content: Text(log ?? "Logged out!")));
                  if (log == null) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (_) => false);
                  } else {
                    print(log);
                  }
                },
                title: _isClicked == true
                    ? const CircularProgressIndicator()
                    : const Text('Log Out',
                        style: TextStyle(fontSize: 16, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
