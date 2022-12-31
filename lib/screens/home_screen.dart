import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/main.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/screens/add_product.dart';
import 'package:store_app/screens/info_pro.dart';
import 'package:store_app/screens/setting_screen.dart';
import 'package:store_app/widgets/button_widget.dart';
import 'package:store_app/widgets/home/home_body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSearch = false;
  TextEditingController titleConttroll = TextEditingController();
  List<Product> serchProduct = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      drawer: homeDrawer(),
      body: HomeBody(
          myProducts: titleConttroll.text == "" ? products : serchProduct),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "قم بتحديد نوع الفرز",
                  content: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                            nameButton: "الاسم",
                            voidCallBakElveatateButtonGM: () {
                              Navigator.pop(context);
                              setState(() {
                                if (serchProduct.isNotEmpty) {
                                  serchProduct =
                                      sortProductTitle(serchProduct)!;
                                } else {
                                  products = sortProductTitle(
                                    products,
                                  )!;
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: ButtonWidget(
                          nameButton: "السعر",
                          voidCallBakElveatateButtonGM: () {
                            Navigator.pop(context);
                            setState(() {
                              if (serchProduct.isNotEmpty) {
                                serchProduct = sortProductPrice(serchProduct)!;
                              } else {
                                products = sortProductPrice(
                                  products,
                                )!;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                    // ButtonWidget(),
                  ));
            },
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              Get.to(() => AddProduct());
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  List<Product>? sortProductPrice(List<Product> sortProduct) {
    for (int j = 0; j < sortProduct.length; j++) {
      for (int i = j; i < sortProduct.length - 1; i++) {
        if (sortProduct[j].price! > sortProduct[i].price!) {
          Product temp = sortProduct[j];
          sortProduct[j] = sortProduct[i];
          sortProduct[i] = temp;
        }
      }
    }
    return sortProduct;
  }

  List<Product>? sortProductTitle(List<Product> sortProduct) {
    for (int j = 0; j < sortProduct.length - 1; j++) {
      for (int i = j; i < sortProduct.length; i++) {
        if (sortProduct[j].title!.compareTo(sortProduct[i].title!) > 0) {
          Product temp = sortProduct[j];
          sortProduct[j] = sortProduct[i];
          sortProduct[i] = temp;
        }
      }
    }
    return sortProduct;
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
            ListTile(
              title: const Text(
                "اعدادات الحساب",
                style: TextStyle(fontSize: 16),
              ),
              leading: const Icon(
                Icons.account_circle,
                color: kPrimaryColor,
              ),
              onTap: () => Get.to(SettingScreen()),
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
                          serchProduct.clear();

                          products.forEach((e) {
                            if (e.title!.contains(value)) {
                              serchProduct.add(e);
                            }
                          });
                        });
                      },
                      validator: (val) => val!.isEmpty ? " is Empty" : null,
                      decoration: const InputDecoration(
                        hintText: "اسم المنتج",
                        //    hintStyle: textStyleSecondary,
                        // prefix: const Text("R.Y"),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1,
                        )),
                      ),
                    ),
                  )),
            )
          : Text(
              (sharedPreferences!.getString("name") != null)
                  ? sharedPreferences!.getString("name")!
                  : 'مرحبا بكم بمتجر الالكترونيات',
              style: GoogleFonts.getFont('Almarai').copyWith(fontSize: 18),
            ),
      centerTitle: true,
      actions: [
        showSearch
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showSearch = false;
                    titleConttroll.text = "";
                    serchProduct.clear();
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
