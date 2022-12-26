import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/widgets/button_widget.dart';

import '../widgets/textfile_widget.dart';

//  Product(
//     id: 4,
//     price: 56,
//     title: "سماعات",
//     subTitle: "لساعات استماع طويلة",
//     image: "images/headset.png",
//     description:
//         "لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا.",
//   ),

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController priceConttroll = TextEditingController();

  TextEditingController titleConttroll = TextEditingController();

  TextEditingController subTitleConttroll = TextEditingController();

  TextEditingController descriptionConttroll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myTextTitleProduct("السعر"),
                TextFormFieldWidget(
                  controller: priceConttroll,
                  name: "50",
                  multiLines: false,
                  outline: true,
                ),
                myTextTitleProduct("الاسم"),
                TextFormFieldWidget(
                  controller: titleConttroll,
                  name: "سوار رياضي",
                  multiLines: false,
                ),
                myTextTitleProduct("المحتوى"),
                TextFormFieldWidget(
                  controller: subTitleConttroll,
                  name: "وصف قصير...",
                  multiLines: false,
                ),
                myTextTitleProduct("الوصف"),
                TextFormFieldWidget(
                  controller: descriptionConttroll,
                  name: "وصف طويل",
                  multiLines: true,
                ),
                if (imageProfile != null) Image.file(imageProfile!),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                          voidCallBakElveatateButtonGM: () {
                            getLostData(imageSource: ImageSource.camera);
                          },
                          nameButton: "camera"),
                    ),
                    Expanded(
                      child: ButtonWidget(
                          voidCallBakElveatateButtonGM: () {
                            getLostData(imageSource: ImageSource.gallery);
                          },
                          nameButton: "gallery"),
                    ),
                  ],
                ),
                ButtonWidget(
                    voidCallBakElveatateButtonGM: () {
                      products.insert(
                        0,
                        Product(
                          id: products[products.length - 1].id! + 1,
                          price: int.parse(priceConttroll.text),
                          title: titleConttroll.text,
                          subTitle: subTitleConttroll.text,
                          image: "images/airpod.png",
                          imagefile: imageProfile,
                          description: descriptionConttroll.text,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    nameButton: "اضافة")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text myTextTitleProduct(String title) {
    return Text(
      title,
      style: GoogleFonts.getFont('Almarai')
          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  final ImagePicker _picker = ImagePicker();

  File? imageProfile;

  // Capture a photo
  Future<void> getLostData({required ImageSource imageSource}) async {
    try {
      final image = await _picker.pickImage(source: imageSource);
      if (image == null) {
        return;
      }
      File? img = File(image.path);

      // img = (await cropImage(imageFile: img))!;
      // ignore: unnecessary_null_comparison
      if (img == null) {
        return;
      }
      setState(() {
        imageProfile = img;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.details);
      }
    }
  }

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Text(
        'اضافة منتج',
        style: GoogleFonts.getFont('Almarai'),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }
}
