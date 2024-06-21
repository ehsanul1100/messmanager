import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messmanager/Appbar/Appbar.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Sign%20Up%20page/SignUpFormValidator.dart';
import 'package:messmanager/UserInfo/current_user_information.dart';
import 'package:messmanager/style/text_style.dart';

import '../FirebaseAuthenticaion/autometic_navigat_to_manager_db_or_creat_join_mess_page.dart';

class GetAndUploadImage extends StatefulWidget {
  String previousPage;
   GetAndUploadImage({ required this.previousPage,super.key});
  @override
  State<GetAndUploadImage> createState() => _GetAndUploadImageState();
}

class _GetAndUploadImageState extends State<GetAndUploadImage> {
  StyleOfText styleOfText = StyleOfText();
  XFile? _image;
  final ImagePicker _imagePicker = ImagePicker();
  String? _downloadLink;
  CurrentUserInformation currentUserInformation = CurrentUserInformation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForManagerActionPages('Profile pic'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: StyleOfBackground.backgroundColor
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget>[
              if(_image != null)
                   CircleAvatar(
                    backgroundImage: FileImage(File(_image!.path)),
                    radius: 80,
                    onBackgroundImageError: (exception, stackTrace) {
                    },
                  ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [boxShadow],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: SizedBox(

                  child: TextButton(onPressed: (){
                    getImage(
                      ImageSource.gallery
                    );
                  }, child: Text('Select image form gallery',style: styleOfText.textStyleForTitle(context,Colors.black),)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [boxShadow],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: SizedBox(

                  child: TextButton(onPressed: (){
                    getImage(
                      ImageSource.camera
                    );
                  }, child: Text('Select image form camera',style: styleOfText.textStyleForTitle(context,Colors.black),)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [boxShadow],
                    borderRadius: BorderRadius.circular(20)
                ),
                child: SizedBox(

                  child: TextButton(onPressed: (){
                    uploadImage();
                  }, child: Text('Set',style: styleOfText.textStyleForTitle(context,Colors.blueAccent),)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<void> getImage(
      ImageSource source
      )async{
    final XFile? selectedImage = await _imagePicker.pickImage(source: source,imageQuality: 30);
    setState(() {
      _image = selectedImage;
    });
  }
  Future<void>uploadImage()async{
    String userEmail = await currentUserInformation.currentUserParticularInformation('email');
    final String fileName = 'images/$userEmail.jpg';
    final File imageFile = File(_image!.path);
    if(_image != null){
      showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),),);
      try{
          await FirebaseStorage.instance.ref(fileName).delete();
      } catch (e){

      }

      try{
        TaskSnapshot snapshot = await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
        String downLoadLink = await snapshot.ref.getDownloadURL();
        setState(() {
          _downloadLink = downLoadLink;
        });

        updateUserProfilePicStatus(userEmail);
        Navigator.pop(context);
        if(widget.previousPage == 'Signup'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AutomaticNavigateToManagerDbOrCreateJoinMessPage(),));
        } else{
          Navigator.pop(context);
        }
      } catch (e){
        Navigator.pop(context);
        showDialog(context: context, builder: (context) =>const Center(child: SizedBox(child: Text('Pleas try again!'),),),);
      }
      
    } else{
      showDialog(context: context, builder: (context) =>const Center(child: SizedBox(child: Text('Pleas select an image!'),),),);
    }
  }
  void updateUserProfilePicStatus(
      String userEmail,
      )async{
    try{
      FirebaseFirestore.instance.collection('User').doc(userEmail).update({
        'profilePic' : _downloadLink,
      });
    } catch(e){
      FirebaseFirestore.instance.collection('User').doc(userEmail).set({
        'profilePic' : _downloadLink,
      },SetOptions(merge: true));
    }
  }
}
