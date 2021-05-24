import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/main.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  List<String> category = [
    'Phone',
    'Laptop',
    'games',
  ];
  List<String> brand = [
    'Apple',
    'Samsung',
  ];
  String selectedCategory;
  String selectedBrand;
  String productID = DateTime.now().millisecond.toString();

  bool uploading = false;

  File file;
  @override
  Widget build(BuildContext context) {
    return file == null
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.border_color),
                onPressed:
                    uploading ? null : () => uploadImageAndSaveItemInfo(),
                color: Colors.white,
              ),
              title: Text(
                "Dee Gadgets",
                style: TextStyle(fontSize: 50.0, fontFamily: 'signatra'),
              ),
              centerTitle: true,
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: dActiveColor),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shop_two,
                    color: Colors.grey,
                    size: 200,
                  ),
                  Container(
                    margin: EdgeInsets.all(25.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: dActiveColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () {
                          imageDialog(context);
                        },
                        child: Text('Add New Item')),
                  ),
                ],
              ),
            ),
          )
        : displayUploadScreen();
  }

  displayUploadScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            clearFormFields();
          },
          color: Colors.white,
        ),
        title: Text(
          'New Product',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: dActiveColor),
              onPressed: () {
                uploadImageAndSaveItemInfo();
              },
              child: Text(
                'Add',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading
              ? LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                )
              : Text(''),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(file), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _shortInfoTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Short Info',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: dActiveColor,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: dActiveColor,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Item Description',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: dActiveColor,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                controller: _priceTextEditingController,
                decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: dActiveColor,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: DropdownButton<String>(
                isExpanded: true,
                items: category.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem.toString()));
                }).toList(),
                onChanged: (newSelectedCategory) {
                    setState(() {
                      selectedCategory = newSelectedCategory;
                    });
                },
                hint: Text('Select Device Type'),
                value: selectedCategory,
              ),
            ),
          ),

          Divider(
            color: dActiveColor,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_info,
              color: dActiveColor,
            ),
            title: Container(
              width: 250.0,
              child: DropdownButton<String>(
                isExpanded: true,
                items: brand.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem.toString()));
                }).toList(),
                onChanged: (newSelectedBrand) {
                  setState(() {
                    selectedBrand = newSelectedBrand;
                  });
                },
                hint: Text('Select Brand'),
                value: selectedBrand,
              ),
            ),
          ),
        ],
      ),
    );
  }

  clearFormFields() {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      selectedCategory = null;
      selectedBrand = null;
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    String imageDownloadURL = await uploadItemImage(file);

    saveItemInfo(imageDownloadURL);
  }

  Future<String> uploadItemImage(mFileImage) async {
    String downloadURL;
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Items');
    Reference imageRef = storageReference.child('product_$productID.jpg');
    UploadTask uploadTask = imageRef.putFile(mFileImage);
    await uploadTask.whenComplete(() async {
      await imageRef.getDownloadURL().then((fileURL) async {
        setState(() {
          downloadURL = fileURL;
        });
      });
    });
    return downloadURL;
  }

  imageDialog(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              'Item image',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text('Select from Gallery',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  getImage();
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                  child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  final picker = ImagePicker();

  getImage() async {
    final imageFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 680.0, maxWidth: 970.0);
    setState(() {
      file = File(imageFile.path);
    });
  }

  saveItemInfo(String downloadURL) {
    final itemsRef = FirebaseFirestore.instance.collection('Items');
    itemsRef.doc(productID).set({
      'shortInfo': _shortInfoTextEditingController.text.trim(),
      'longDescription': _descriptionTextEditingController.text.trim(),
      'price': int.parse(_priceTextEditingController.text),
      'title': _titleTextEditingController.text.trim(),
      'publishDate': DateTime.now(),
      'status': 'available',
      'thumbnailUrl': downloadURL,
      'brand': selectedBrand,
      'quantity': 1,
    });
    setState(() {
      file = null;
      uploading = false;
      productID = DateTime.now().millisecond.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
      selectedCategory = null;
      selectedBrand = null;
    });
  }
}
