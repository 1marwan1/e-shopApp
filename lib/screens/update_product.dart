import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

class UpdateProduct extends StatefulWidget {
  @override
  State<UpdateProduct> createState() => _UpdateProductState();
  Product product;
  UpdateProduct({required this.product});
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController priceConttroll = TextEditingController();

  TextEditingController titleConttroll = TextEditingController();

  TextEditingController subTitleConttroll = TextEditingController();

  TextEditingController descriptionConttroll = TextEditingController();
  @override
  void initState() {
    super.initState();
    priceConttroll.text = widget.product.price.toString();
    titleConttroll.text = widget.product.title.toString();
    subTitleConttroll.text = widget.product.subTitle.toString();
    descriptionConttroll.text = widget.product.description.toString();
    imageProfile = widget.product.imagefile;
  }

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
                imageProfile != null
                    ? Image.file(imageProfile!)
                    : Image.asset(widget.product.image!),
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
                      Get.defaultDialog(
                          title: "هل انت متاكد تريد الحــذف",
                          content: Row(
                            children: [
                              Expanded(
                                child: ButtonWidget(
                                  nameButton: "yes",
                                  voidCallBakElveatateButtonGM: () {
                                    Navigator.pop(context);
                                    for (int i = 0; i < products.length; i++) {
                                      if (products[i].id == widget.product.id) {
                                        products[i].price =
                                            int.parse(priceConttroll.text);
                                        products[i].title = titleConttroll.text;
                                        products[i].subTitle =
                                            subTitleConttroll.text;
                                        products[i].image =
                                            widget.product.image;
                                        products[i].imagefile = imageProfile;
                                        products[i].description =
                                            descriptionConttroll.text;
                                      }
                                    }

                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: ButtonWidget(
                                  nameButton: "no",
                                  voidCallBakElveatateButtonGM: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                            // ButtonWidget(),
                          ));
                    },
                    nameButton: "تعديل")
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
        'تعديل منتج',
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
