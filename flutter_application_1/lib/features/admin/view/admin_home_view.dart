import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/data_card.dart';
import 'package:flutter_application_1/features/admin/view/create_data_model.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:provider/provider.dart';

class AdminHomeView extends StatefulWidget {
  static const String routeName = '/admin-home';
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainProvider>(context, listen: false).getAllDataModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Home'),
        ),
        body: Consumer<MainProvider>(
          builder: (context, value, child) {
            if (value.adminList.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getDeviceHeight(context) * 0.8,
                      child: ListView.builder(
                          itemCount: value.adminList.length,
                          itemBuilder: (context, index) {
                            var item = value.adminList[index];
                            return DataCard(model: item, isAdmin: true);
                          }),
                    ),
                  ),
                  CustomElevatedBtn(
                      text: "Add New Service",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CreateDataModelView.routeName,
                            arguments: null);
                      },
                      bgColor: AppColors.primaryColor,
                      borderColor: Colors.transparent,
                      textColor: AppColors.whiteColor)
                ],
              );
            }

            return Container(
              child: Center(
                child: Column(
                  children: [
                    Text("No Data Found"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomElevatedBtn.new(
                        text: "Add New Service",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CreateDataModelView.routeName,
                              arguments: null);
                        },
                        bgColor: AppColors.primaryColor,
                        borderColor: Colors.transparent,
                        textColor: AppColors.whiteColor)
                  ],
                ),
              ),
            );
          },
        ));
  }
}
