import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/data_card.dart';
import 'package:flutter_application_1/features/admin/view/admin_home_view.dart';
import 'package:flutter_application_1/features/home/widgets/address_widget.dart';
import 'package:flutter_application_1/features/home/widgets/cat_widget.dart';
import 'package:flutter_application_1/features/home/widgets/category_block.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/res/assets.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainProvider>(context, listen: false).getAllDataModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.bgColor,
                    //want border raduis in bottom lefr and right
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AddressWidget(),
                          Column(
                            children: [
                              Text(
                                "Points",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              Text("76576"),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Hello, Rajat!",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                      const Text(
                        "What would you like to do today?",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: getDeviceWidth(context) * 0.7,
                            child: TextField(
                              onChanged: (value) {
                                var provider = Provider.of<MainProvider>(
                                    context,
                                    listen: false);
                                provider.searchList = provider.userList
                                    .where((element) => element.title
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "Search for a service",
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.filter_alt_outlined,
                            size: 35,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const CategoryBlock(),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedBtn(
                  text: "Admin Flow",
                  onPressed: () {
                    Navigator.pushNamed(context, AdminHomeView.routeName);
                  },
                  bgColor: AppColors.primaryColor,
                  borderColor: Colors.transparent,
                  textColor: AppColors.whiteColor),
              const SizedBox(
                height: 20,
              ),
              Consumer<MainProvider>(builder: (context, value, _) {
                if (value.searchList.isNotEmpty) {
                  return Column(
                    children: value.searchList
                        .map((e) => DataCard(model: e, isAdmin: false))
                        .toList(),
                  );
                }
                return Text("Coming Soon");
              })
            ],
          ),
        ),
      ),
    );
  }
}
