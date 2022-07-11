import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../conf/firestore.dart';

class ProfilEditScreen extends StatefulWidget {
  const ProfilEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfilEditScreen> createState() => _ProfilEditScreenState();
}

class _ProfilEditScreenState extends State<ProfilEditScreen> {
  final Map<String, dynamic> _dataToUpdate = {};
  final TextEditingController _nameInput = TextEditingController();
  final TextEditingController _telInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _addrInput = TextEditingController();

  String? _gender;
  bool _isGenderDropdownChanged = false, _isClicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dateInput.clear();
    _dataToUpdate.clear();
    _gender = null;
  }

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final args = arg['data'];
    User? user = arg['user'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil', style: TextStyle(color: Colors.brown[400])),
        backgroundColor: const Color(0xfff7f7f7),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            splashRadius: 24,
            splashColor: Colors.pink.withOpacity(0.2),
            icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent)),
        actions: [
          IconButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (_dataToUpdate.isEmpty && _nameInput.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blue,
                      content: const Text("No changes to update")));
                  Navigator.pop(context);
                  return;
                }
                setState(() {
                  _isClicked = true;
                });
                if (_nameInput.text.isNotEmpty) {
                  await user!.updateDisplayName(_nameInput.text);
                }
                if (_dataToUpdate.isNotEmpty) {
                  var log = await Firestore.updateData(
                      'users', user!.uid, _dataToUpdate);
                  if (log != null) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red, content: Text(log)));
                    return;
                  }
                }
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.green,
                    content: const Text("Successfully update profile")));
                Navigator.pushReplacementNamed(context, '/profil');
                setState(() {
                  _isClicked = false;
                });
              },
              splashRadius: 24,
              splashColor: Colors.pink.withOpacity(0.2),
              icon: _isClicked == false
                  ? const Icon(Icons.check, color: Colors.pinkAccent)
                  : const CircularProgressIndicator(color: Colors.pinkAccent))
        ],
      ),
      backgroundColor: const Color(0xfff7f7f7),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                    controller: _nameInput.text == "" || _nameInput.text.isEmpty
                        ? TextEditingController.fromValue(TextEditingValue(
                            text: user!.displayName.toString(),
                            selection: TextSelection.collapsed(
                                offset: user.displayName.toString().length)))
                        : _nameInput,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nama'),
                    onChanged: (value) {
                      _nameInput.text = value;
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Jenis Kelamin',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.brown[50],
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * .4,
                      child: DropdownButton(
                          isExpanded: true,
                          hint: const Text("     Pilih..."),
                          value: _isGenderDropdownChanged == true
                              ? _gender
                              : args['gender'].toString() == "" ||
                                      args['gender'].toString().isEmpty
                                  ? _gender
                                  : args['gender'].toString(),
                          borderRadius: BorderRadius.circular(10),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.pinkAccent),
                          underline: Container(),
                          items: ["Laki-laki", "Perempuan"].map((value) {
                            return DropdownMenuItem(
                                value: value,
                                child: ListTile(
                                    horizontalTitleGap: -8,
                                    dense: true,
                                    contentPadding:
                                        const EdgeInsets.only(left: 8),
                                    leading: value == "Laki-laki"
                                        ? const Icon(Icons.male,
                                            size: 30, color: Colors.blue)
                                        : const Icon(Icons.female,
                                            size: 30, color: Colors.pink),
                                    title: Text(value,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black))));
                          }).toList(),
                          onChanged: (value) => setState(() {
                                _gender = value.toString();
                                _isGenderDropdownChanged = true;
                                _dataToUpdate['gender'] = _gender;
                              })),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                    controller: _telInput.text == "" || _telInput.text.isEmpty
                        ? TextEditingController.fromValue(TextEditingValue(
                            text: args['telepon'],
                            selection: TextSelection.collapsed(
                                offset: args['telepon'].length)))
                        : _telInput,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Telepon'),
                    onChanged: (value) {
                      _telInput.text = value;
                      _dataToUpdate['telepon'] = _telInput.text;
                    }),
                const SizedBox(height: 20),
                TextField(
                    controller: _dateInput.text == "" || _dateInput.text.isEmpty
                        ? TextEditingController(text: args['tanggal_lahir'])
                        : _dateInput,
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    onTap: () => showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1960),
                                lastDate: DateTime.now())
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              _dateInput.text = DateFormat('dd-MM-yyyy')
                                  .format(date)
                                  .toString();
                              _dataToUpdate['tanggal_lahir'] = _dateInput.text;
                              print(_dataToUpdate);
                            });
                          }
                        }),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tanggal lahir')),
                const SizedBox(height: 20),
                TextField(
                    controller: _addrInput.text == "" || _addrInput.text.isEmpty
                        ? TextEditingController.fromValue(TextEditingValue(
                            text: args['alamat'],
                            selection: TextSelection.collapsed(
                                offset: args['alamat'].length)))
                        : _addrInput,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Alamat'),
                    onChanged: (value) {
                      _addrInput.text = value;
                      _dataToUpdate['alamat'] = _addrInput.text;
                    }),
                GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: const SizedBox(height: 100))
              ],
            )),
      ),
    );
  }
}
