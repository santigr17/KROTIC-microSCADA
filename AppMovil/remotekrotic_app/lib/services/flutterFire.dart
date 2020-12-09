import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

firebase_storage.FirebaseStorage storage =
  firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
  firebase_storage.FirebaseStorage.instance.ref('/instrucciones.json');