import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    checkper();
    super.initState();
  }

  checkper() async
  {
    await Permission.storage.isDenied.then((value) => Permission.storage.request());
    await Permission.camera.isDenied.then((value) => Permission.camera.request());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ImagePicker pick= ImagePicker();
  XFile? profileimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Take Picture From Camera",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25,left: 20,right: 20),
        child: Column(
          children: [
            profileimage == null ?
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Icon(Icons.person,size: 100,)
              ),
            )
            :
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  File(profileimage!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: ()async{
                profileimage = await pick.pickImage(source: ImageSource.camera);
                      setState(() {});
              },
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Set Profile', style: TextStyle(color: Colors.white,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}