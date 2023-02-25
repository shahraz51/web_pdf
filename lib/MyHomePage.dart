import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("PDF"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  Uint8List? fileBytes = result!.files.first.bytes;
                  String fileName = result.files.first.name;

                  final putfile = FirebaseStorage.instance
                      .ref()
                      .child("file")
                      .child("${DateTime.now()}.pdf");
                  await putfile.putData(fileBytes!);
                  url = await putfile.getDownloadURL();
                  FirebaseFirestore.instance
                      .collection("PDF")
                      .doc("PDF")
                      .set({"Url": url});
                },
                child: const Text("Up Load Pdf")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  final sh = await FirebaseFirestore.instance
                      .collection("PDF")
                      .doc("PDF")
                      .get()
                      .then((value) => url = value["Url"]);
                  print(sh);

                  AnchorElement anchorElement = new AnchorElement(href: sh);
                  anchorElement.download = "Flutter Logo";
                  anchorElement.click();
                },
                child: const Text("Read Pdf"))
          ],
        ),
      ),
    );
  }
}
