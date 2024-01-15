import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({super.key});

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? SelectedGroups;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  final TextEditingController donorName = TextEditingController();
  final TextEditingController donorPhone = TextEditingController();

  void UpdateDonor(docid) {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': SelectedGroups,
    };
    donor.doc(docid).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    SelectedGroups = args['group'];
    final docid = args['id'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("update Donor"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 69, 0, 206)
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
                value: SelectedGroups,
                dropdownColor: Colors.white,
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
                  UpdateDonor(docid);
                },
                style: const ButtonStyle(
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 115, 53, 239),),
                  elevation: MaterialStatePropertyAll(50),
                ),
                child: const Text(
                  "update",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
