import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/admin/view/admin_home_view.dart';
import 'package:flutter_application_1/features/admin/view/create_data_model.dart';
import 'package:flutter_application_1/features/category/view/category_view.dart';
import 'package:flutter_application_1/features/home/model/data_model.dart';
import 'package:flutter_application_1/features/home/view/home_view.dart';
import 'package:flutter_application_1/features/home/view/splash_view.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes() {
  Map<String, Widget Function(BuildContext)> appRoutes = {
    //  AgentListScreen.routeName: (context) {
    //       var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //       var listData = args['listData'] as List<AgentModel>;
    //       var caseModel = args['caseModel'] as CaseModel;

    //       return AgentListScreen(
    //         agents: listData,
    //         caseModel: caseModel,
    //       );
    //     },
    SplashView.routeName: (context) => const SplashView(),
    HomeView.routeName: (context) => const HomeView(),
    AdminHomeView.routeName: (context) => const AdminHomeView(),
    CreateDataModelView.routeName: (context) {
      var isCreateMode =
          ModalRoute.of(context)!.settings.arguments as DataModel?;
      return CreateDataModelView(
        model: isCreateMode,
      );
    },
    CategoryView.routeName: (context) {
      var category = ModalRoute.of(context)!.settings.arguments as String;
      return CategoryView(category: category);
    }
  };
  return appRoutes;
}
