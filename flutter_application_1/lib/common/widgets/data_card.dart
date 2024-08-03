import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/loader.dart';
import 'package:flutter_application_1/features/admin/view/create_data_model.dart';
import 'package:flutter_application_1/features/home/model/data_model.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:provider/provider.dart';

class DataCard extends StatelessWidget {
  final DataModel model;
  final bool isAdmin;
  const DataCard({super.key, required this.model, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: getDeviceWidth(context),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: getDeviceWidth(context),
                      height: 200,
                      imageUrl: model.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: IconButton(
                            onPressed: () {
                              showSnackBar(context, "Under Development");
                            },
                            icon: const Icon(Icons.favorite_border),
                            color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: getDeviceWidth(context) * 0.7,
                          child: Text(model.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Text(
                        model.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Text("~${model.distance}km")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 1,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: getDeviceWidth(context) * 0.6,
                      child: Text(
                        "₹${model.rate} / session",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )),
                  InkWell(
                      onTap: () {
                        showSnackBar(context, "Under Development");
                      },
                      child: Text(
                        "Book Slot",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
            isAdmin
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreateDataModelView.routeName,
                                  arguments: model);
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.black),
                        IconButton(
                            onPressed: () async {
                              showLoading(context);
                              await context
                                  .read<MainProvider>()
                                  .deleteDataModel(model.uuid);

                              hideLoading(context);
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
}
