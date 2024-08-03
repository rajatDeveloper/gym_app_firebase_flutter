// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/custom_text_field.dart';
import 'package:flutter_application_1/common/widgets/loader.dart';
import 'package:flutter_application_1/features/home/model/data_model.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/repo/firebase_data_repo.dart';
import 'package:flutter_application_1/res/colors.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateDataModelView extends StatefulWidget {
  static const String routeName = '/create-data-model';
  final DataModel? model;
  const CreateDataModelView({super.key, required this.model});

  @override
  State<CreateDataModelView> createState() => _CreateDataModelViewState();
}

class _CreateDataModelViewState extends State<CreateDataModelView> {
  DataModel? dataModel;

  // final String uuid;
  // final String title;
  // final int distance;
  // final String address;
  // final String image;
  // final String category;

  List<String> categoryList = [
    'Yoga',
    'Gym',
    'Zumba',
    'Badminton',
    'Swimming',
  ];

  TextEditingController titleControllerVar = TextEditingController();
  TextEditingController distanceControllerVar = TextEditingController();
  TextEditingController addressControllerVar = TextEditingController();
  TextEditingController rateControllerVar = TextEditingController();
  FocusNode _rateFocusNode = FocusNode();
  FocusNode _titleFocusNode = FocusNode();
  FocusNode _distanceFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();
  File? image;
  String category = "Gym";

  bool vaildate() {
    if (titleControllerVar.text.isEmpty) {
      showSnackBar(context, "Title is required");
      return false;
    } else if (distanceControllerVar.text.isEmpty) {
      showSnackBar(context, "Distance is required");
      return false;
    } else if (addressControllerVar.text.isEmpty) {
      showSnackBar(context, "Address is required");
      return false;
    } else if (category.isEmpty) {
      showSnackBar(context, "Category is required");
      return false;
    } else if (image == null && widget.model == null) {
      showSnackBar(context, "Image is required");
      return false;
    }
    return true;
  }

  FirebaseDataRepo firebaseDataRepo = FirebaseDataRepo();

  void updateMode() {
    titleControllerVar.text = widget.model!.title;
    distanceControllerVar.text = widget.model!.distance.toString();
    addressControllerVar.text = widget.model!.address;
    rateControllerVar.text = widget.model!.rate.toString();
    category = widget.model!.category;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      updateMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model != null ? 'Update Service' : 'Create Service'),
      ),
      body: Consumer<MainProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  height: getDeviceHeight(context) * 0.8,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            textColor: AppColors.primaryColor,
                            activeTextColor: AppColors.primaryColor,
                            backgroundColor: AppColors.whiteColor,
                            borderActiveColor: AppColors.primaryColor,
                            controller: titleControllerVar,
                            node: _titleFocusNode,
                            hintText: 'Title',
                            isNum: false,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _distanceFocusNode,
                            tapOn: null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textColor: AppColors.primaryColor,
                            activeTextColor: AppColors.primaryColor,
                            backgroundColor: AppColors.whiteColor,
                            borderActiveColor: AppColors.primaryColor,
                            controller: distanceControllerVar,
                            node: _distanceFocusNode,
                            hintText: 'Distance',
                            isNum: true,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _addressFocusNode,
                            tapOn: null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textColor: AppColors.primaryColor,
                            activeTextColor: AppColors.primaryColor,
                            backgroundColor: AppColors.whiteColor,
                            borderActiveColor: AppColors.primaryColor,
                            controller: addressControllerVar,
                            node: _addressFocusNode,
                            hintText: 'Address',
                            isNum: false,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _rateFocusNode,
                            tapOn: null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textColor: AppColors.primaryColor,
                            activeTextColor: AppColors.primaryColor,
                            backgroundColor: AppColors.whiteColor,
                            borderActiveColor: AppColors.primaryColor,
                            controller: rateControllerVar,
                            node: _rateFocusNode,
                            hintText: 'Rate per Session',
                            isNum: true,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: null,
                            tapOn: null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: category,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                            // underline: Container(
                            //   height: 2,
                            //   color: AppColors.primaryColor,
                            // ),
                            onChanged: (String? newValue) {
                              setState(() {
                                category = newValue ?? "";
                              });
                            },
                            items: categoryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          image == null && widget.model == null
                              ? CustomElevatedBtn(
                                  text: "Add Service Image",
                                  onPressed: () async {
                                    image = await pickImageAndReturnImg(
                                        imageType: ImageSource.gallery);
                                    setState(() {});
                                  },
                                  prefixIcon: Icons.image,
                                  bgColor: AppColors.primaryColor,
                                  borderColor: Colors.transparent,
                                  textColor: AppColors.whiteColor)
                              : image != null && widget.model != null
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Image.file(image!),
                                          CustomElevatedBtn(
                                              text: "Change Image",
                                              onPressed: () async {
                                                image =
                                                    await pickImageAndReturnImg(
                                                        imageType: ImageSource
                                                            .gallery);
                                                setState(() {});
                                              },
                                              prefixIcon: Icons.image,
                                              bgColor: AppColors.primaryColor,
                                              borderColor: Colors.transparent,
                                              textColor: AppColors.whiteColor)
                                        ],
                                      ),
                                    )
                                  : widget.model != null
                                      ? Container(
                                          child: Column(
                                            children: [
                                              Image.network(
                                                  widget.model!.image),
                                              CustomElevatedBtn(
                                                  text: "Change Image",
                                                  onPressed: () async {
                                                    image =
                                                        await pickImageAndReturnImg(
                                                            imageType:
                                                                ImageSource
                                                                    .gallery);
                                                    setState(() {});
                                                  },
                                                  prefixIcon: Icons.image,
                                                  bgColor:
                                                      AppColors.primaryColor,
                                                  borderColor:
                                                      Colors.transparent,
                                                  textColor:
                                                      AppColors.whiteColor)
                                            ],
                                          ),
                                        )
                                      : Container(
                                          child: Column(
                                            children: [
                                              Image.file(image!),
                                              CustomElevatedBtn(
                                                  text: "Change Image",
                                                  onPressed: () async {
                                                    image =
                                                        await pickImageAndReturnImg(
                                                            imageType:
                                                                ImageSource
                                                                    .gallery);
                                                    setState(() {});
                                                  },
                                                  prefixIcon: Icons.image,
                                                  bgColor:
                                                      AppColors.primaryColor,
                                                  borderColor:
                                                      Colors.transparent,
                                                  textColor:
                                                      AppColors.whiteColor)
                                            ],
                                          ),
                                        )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomElevatedBtn(
                  text: widget.model != null
                      ? "Update Service"
                      : "Create Service",
                  onPressed: () async {
                    if (vaildate()) {
                      if (widget.model == null) {
                        showLoading(context);
                        var imageLink =
                            await firebaseDataRepo.uploadImage(image!);

                        dataModel = DataModel(
                            uuid: Uuid().v1(),
                            title: titleControllerVar.text,
                            rate: int.parse(rateControllerVar.text),
                            distance: double.parse(distanceControllerVar.text),
                            address: addressControllerVar.text,
                            image: imageLink,
                            category: category);

                        await value.createDataModel(dataModel!);

                        hideLoading(context);
                        showSnackBar(context, "Service Created Successfully");
                        Navigator.pop(context);
                      } else {
                        //update model

                        showLoading(context);
                        var imageLInk = "";
                        if (image == null) {
                          imageLInk = widget.model!.image;
                        } else {
                          imageLInk =
                              await firebaseDataRepo.uploadImage(image!);
                        }

                        dataModel = DataModel(
                            uuid: widget.model!.uuid,
                            title: titleControllerVar.text,
                            rate: int.parse(rateControllerVar.text),
                            distance: double.parse(distanceControllerVar.text),
                            address: addressControllerVar.text,
                            image: imageLInk,
                            category: category);

                        await value.updateDataModel(dataModel!);

                        hideLoading(context);
                        showSnackBar(context, "Service Updated Successfully");
                        Navigator.pop(context);
                      }
                    }
                  },
                  bgColor: AppColors.primaryColor,
                  borderColor: Colors.transparent,
                  textColor: AppColors.whiteColor)
            ],
          );
        },
      ),
    );
  }
}
