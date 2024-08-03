import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/model/address_model.dart';
import 'package:flutter_application_1/features/home/model_view/address_view_model.dart';
import 'package:flutter_application_1/provider.dart/main_provider.dart';
import 'package:flutter_application_1/utils/use_full_function.dart';
import 'package:provider/provider.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  AddressModel? data;

  AddressModelView addressModelView = AddressModelView();

  setAddressData() async {
    var provider = Provider.of<MainProvider>(context, listen: false);

    if (provider.addressModel == null) {
      data = await addressModelView.getAddressFromLocation();
      provider.updateAddress(data!);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        if (value.addressModel == null) {
          return const CircularProgressIndicator();
        }

        return Container(
          child: SizedBox(
            width: getDeviceWidth(context) * 0.5,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      value.addressModel!.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_rounded),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: getDeviceWidth(context) * 0.5,
                  child: Text(
                    value.addressModel!.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
