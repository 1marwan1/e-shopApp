import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/screens/add_product.dart';
import 'package:store_app/screens/info_pro.dart';
import 'package:store_app/widgets/home/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSearch = false;
  TextEditingController titleConttroll = TextEditingController();
  List<Product>? serchProduct = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      drawer: homeDrawer(),
      body: HomeBody(
          myProducts: titleConttroll.text == "" ? products : serchProduct!),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget homeDrawer() {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("admin admin"),
              accountEmail: const Text("admin@gmail.com"),
              decoration: const BoxDecoration(color: kPrimaryColor),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.person, color: kPrimaryColor),
              ),
            ),
            const ListTile(
              title: Text(
                "اعدادات الحساب",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(
                Icons.account_circle,
                color: kPrimaryColor,
              ),
            ),
            const ListTile(
              title: Text(
                "  الاتصال بنا",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(
                Icons.phone,
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(const InfoDevloper());
              },
              title: const Text(
                " حول المطور",
                style: TextStyle(fontSize: 16),
              ),
              leading: const Icon(
                Icons.info,
                color: kPrimaryColor,
              ),
            ),
            const ListTile(
              title: Text(
                " تسجيل الخروج",
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: showSearch
          ? Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  color: Colors.white.withOpacity(0.4),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: TextFormField(
                      controller: titleConttroll,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          serchProduct!.clear();
                          products.forEach((e) {
                            if (e.title!.contains(value)) {
                              serchProduct!.add(e);
                            }
                          });
                        });
                      },
                      validator: (val) => val!.isEmpty ? " is Empty" : null,
                      decoration: InputDecoration(
                        hintText: "اسم المنتج",
                        //    hintStyle: textStyleSecondary,
                        // prefix: const Text("R.Y"),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 1,
                        )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1,
                        )),
                      ),
                    ),
                  )),
            )
          : Text(
              'مرحبا بكم بمتجر الالكترونيات',
              style: GoogleFonts.getFont('Almarai'),
            ),
      centerTitle: true,
      actions: [
        showSearch
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showSearch = false;
                    titleConttroll.text == "";
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  textDirection: TextDirection.rtl,
                ))
            : IconButton(
                onPressed: () {
                  setState(() {
                    showSearch = true;
                  });
                },
                icon: Icon(Icons.search))
      ],
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.menu),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }
}
