import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

class ProfileScreen extends StatelessWidget {
  List<String> tags = ['Sofa','Lemari','Meja Makan','Pintu','Rak Dinding','Meja Belajar','Rak Buku',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xff020d1c),
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.verified_user,
                  color: Colors.red
                )
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/image1.png'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Uvi Firgianingsih',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 17,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      'Boyolali, Jawa Tengah ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          letterSpacing: 3,
                                          wordSpacing: 2),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                        )
                    ),
                ],
              ),
              //bagian sosial media
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        '250k',
                        style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      Text('Pengikut',
                          style: TextStyle(fontSize: 18, color: Colors.black))
                    ]),
                    Column(children: <Widget>[
                      Text(
                        '10k',
                        style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      Text('Mengikuti',
                          style: TextStyle(fontSize: 18, color: Colors.black))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, top: 8, bottom: 8),
                          child: Text(
                            'Follow',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                                colors: [Colors.blueAccent, Colors.black54],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //bagian tags
              Container(
                margin: EdgeInsets.only(top: 25),
                height: 45,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (BuildContext contect, int index) {
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.purple, Colors.blueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            tags[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  ),
              ),
              //bagian autobiography
              Container(
                padding: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 4.0),
                margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 4.0),
                height: 500,
                width: double.infinity,
                child: Card(
                  child: Container(
                      color: Colors.blueAccent[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Padding(padding: EdgeInsets.only(top: 30, right: 20, left: 70, bottom:  15),
                    //child: Text ('Biodata Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.black)),
                    //),
                          Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.person_pin),
                      Text( 'Nama       : Uvi Firgianingsih', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                          )
                        ]
                      ),
                        ),
                          Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.dialpad),
                     Text('Username          : uvifirgia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                            )
                          ]
                          ),
                        ),
                      Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.date_range),
                     Text('Tanggal Lahir      : 09-04-2001', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                            )
                          ]
                        ),
                      ),
                      Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.contact_mail),
                      Text('E-mail      : uvifirgia04@gmail.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize:18)
                           )
                         ]
                        ),
                      ),
                      Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.contact_phone),
                      Text('Handphone   : 085783241470', style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18)
                            )
                          ]
                        ),
                      ),
                      Padding(
                      padding:const EdgeInsets.all(15.0),
                      child:Row( 
                      children: <Widget>[
                        Icon(Icons.home),
                      Text('Alamat    : Wonosegoro, Boyolali', style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18)
                            )
                           ]
                         ),
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
