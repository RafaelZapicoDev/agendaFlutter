import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class StorageService with ChangeNotifier {
  //inicializando com o storage
  final firebaseStorage = FirebaseStorage.instance;

  List<String> _ImgUrls = [];

  bool _IsLoading = false;
  bool _IsUpdating = false;

  List<String> get ImgUrls => _ImgUrls;
  bool get IsLoading => _IsLoading;
  bool get IsUpdating => _IsUpdating;

  //lendo imagens
  Future<void> fetchImages() async {
    _IsLoading = true;

    final ListResult result =
        await firebaseStorage.ref('uploaded_images/').listAll();

    _ImgUrls = Future.wait(result.items.map((ref) => ref.getDownloadURL()))
        as List<String>;

    _IsLoading = false;
    notifyListeners();
  }

  //deletando imagens
  Future<void> deleteImages(String imageUrl) async {
    try {
      _ImgUrls.remove(imageUrl);
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
    } catch (e) {
      Logger().e("Erro ao deletar imagem : $e");
    }
    notifyListeners();
  }

  //pega o caminho do link e corta a parte que precisa-ce para apagar
  String extractPathFromUrl(String imageUrl) {
    Uri uri = Uri.parse(imageUrl);
    String encodedPath = uri.pathSegments.last;
    return Uri.decodeComponent(encodedPath);
  }

  //fazendo upload de uma imagem

  Future<void> uploadImage() async {
    _IsUpdating = true;
    notifyListeners();

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);
    try {
      String filePath = 'uploaded_images/${DateTime.now()}.png';

      await firebaseStorage.ref(filePath).putFile(file);
      String dowloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      _ImgUrls.add(dowloadUrl);
      notifyListeners();
    } catch (e) {
      Logger().e("Erro ao deletar imagem : $e");
    }
    _IsUpdating = false;
    notifyListeners();
  }
}
