import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/data_card.dart';
import 'package:flutter_application_1/features/home/widgets/address_widget.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  static const String routeName = '/category';
  final String category;
  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  getCatData() async {
    await context.read<MainProvider>().getDataModelsByCategory(widget.category);
  }

  late String cat = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cat = widget.category;
    getCatData();
  }

  List<String> categoryList = [
    'Yoga',
    'Gym',
    'Zumba',
    'Badminton',
    'Swimming',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Consumer<MainProvider>(
        builder: (context, value, child) {
          if (value.categoryList.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const AddressWidget()
                    ],
                  ),
                ),

                //want to display my complete list
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: getDeviceWidth(context) * 0.9,
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categoryList
                          .map((e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    cat = e;
                                  });
                                  context
                                      .read<MainProvider>()
                                      .getDataModelsByCategory(e);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: e == cat
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: e == cat
                                              ? AppColors.primaryColor
                                              : Colors.grey),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: const Radius.circular(10),
                                          bottomRight:
                                              const Radius.circular(10),
                                          topLeft: const Radius.circular(10),
                                          topRight: const Radius.circular(10))),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: e == cat
                                            ? AppColors.whiteColor
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: value.categoryList.length,
                        itemBuilder: (context, index) {
                          var item = value.categoryList[index];
                          return DataCard(model: item, isAdmin: false);
                        }),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const AddressWidget()
                    ],
                  ),
                ),

                //want to display my complete list
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: getDeviceWidth(context) * 0.9,
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categoryList
                          .map((e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    cat = e;
                                  });
                                  context
                                      .read<MainProvider>()
                                      .getDataModelsByCategory(e);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: e == cat
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: e == cat
                                              ? AppColors.primaryColor
                                              : Colors.grey),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: const Radius.circular(10),
                                          bottomRight:
                                              const Radius.circular(10),
                                          topLeft: const Radius.circular(10),
                                          topRight: const Radius.circular(10))),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: e == cat
                                            ? AppColors.whiteColor
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),

                Center(
                  child: Text("Commig Soon"),
                )
              ],
            );
          }
        },
      ),
    ));
  }
}
