import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docid) {
    donor.doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: const Text("Blood Donation App",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 69, 0, 206),
        elevation: 40,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Add');
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 115, 53, 239),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: StreamBuilder(
          stream: donor.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donorsnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 115, 53, 239),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 1,
                              
                            )
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  child: Text(
                                    donorsnap['group'],
                                    style: TextStyle(fontSize: 25,color:Color.fromARGB(255, 115, 53, 239) ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    donorsnap['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    donorsnap['phone'].toString(),
                                    style: TextStyle(fontSize: 18,color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Update',
                                        arguments: {
                                          'name': donorsnap['name'],
                                          'phone':
                                              donorsnap['phone'].toString(),
                                          'group': donorsnap['group'],
                                          'id': donorsnap.id,
                                        });
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Colors.white,
                                  iconSize: 30,
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteDonor(donorsnap.id);
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  iconSize: 30,
                                ),
                              ],
                            )
                          ]),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
