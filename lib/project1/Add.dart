import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? SelectedGroups;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  final TextEditingController donorName = TextEditingController();
  final TextEditingController donorPhone = TextEditingController();
  bool validate = false;

  

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': SelectedGroups
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Donors",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 115, 53, 239),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: donorName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Donor Name"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              
              controller: donorPhone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("phone Number"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
                dropdownColor: Colors.blueGrey,
                decoration:
                    const InputDecoration(label: Text("Select Blood Groups")),
                items: BloodGroups.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    )).toList(),
                onChanged: (val) {
                  SelectedGroups = val as String?;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                  
                  });
                  addDonor();
                  Navigator.pop(context);
                  
                }, 
                style: const ButtonStyle(
                minimumSize:MaterialStatePropertyAll(Size(double.infinity, 50)),
                backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 115, 53, 239),),
                elevation: MaterialStatePropertyAll(50),
                ),
                child: const Text(
                
                  "Submit",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
