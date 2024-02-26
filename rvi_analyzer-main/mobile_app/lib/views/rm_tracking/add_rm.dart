import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/common/qr_scan.dart';
import 'package:rvi_analyzer/service/common_service.dart';
import 'package:rvi_analyzer/views/common/form_eliments/text_input.dart';
import 'package:rvi_analyzer/views/service_locator.dart';
import 'package:rvi_analyzer/views/utils/common_utils.dart';

class AddRm extends StatefulWidget {
  const AddRm({Key? key}) : super(key: key);

  @override
  State<AddRm> createState() => _AddRmState();
}

class _AddRmState extends State<AddRm> {
  final _formKey = GlobalKey<FormState>();
  String? plantName;
  String? customerName;
  String? styleName;
  String? rm;
  String? customerPo;
  String? soNumber;
  String? po;
  late String qrUDI;
  final udiQrNoController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Future<void> setUDIQrCodeValue(String value) async {
    setState(() {
      qrUDI = value;
    });
  }

  void _doSomething() async {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 0.5), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  SizedBox(
                    width: (width / 2) - 32,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Add RM Tracking',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getPlants("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Plant",
                                  hintText: "Select Plant",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    plantName = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "Plant is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: plantName,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getCustomers("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Customer",
                                  hintText: "Select Customer",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    customerName = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "Customer is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: customerName,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getStyles("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Style",
                                  hintText: "Select Style",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    styleName = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "Style is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: styleName,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response =
                                    await sl.get<CommonService>().getRm("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "RM",
                                  hintText: "Select Rm",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    rm = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "RM is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: rm,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getCustomerPo("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Customer Po",
                                  hintText: "Select Customer PO",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    customerPo = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "Customer PO is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: customerPo,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getSoNumbers("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "SO Number",
                                  hintText: "Select SO Number",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    soNumber = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "SO Number is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: soNumber,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 8, 0),
                                    hintText: "Type Here...",
                                  ),
                                ),
                              ),
                              asyncItems: (String filter) async {
                                var response = await sl
                                    .get<CommonService>()
                                    .getProductionOrders("test");
                                return response;
                              },
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Production Order",
                                  hintText: "Select Production Order",
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    po = value;
                                  });
                                }
                              },
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? item) {
                                if (item == null) {
                                  return "Production Order is Required";
                                } else {
                                  return null;
                                }
                              },
                              selectedItem: po,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextInput(
                                      data: TestInputData(
                                          onComplete: setUDIQrCodeValue,
                                          controller: udiQrNoController,
                                          validatorFun: (val) {
                                            return null;
                                            // if (val!.isEmpty) {
                                            //   return "QR code cannot be empty";
                                            // } else {
                                            //   null;
                                            // }
                                          },
                                          labelText: "UDI")),
                                ),
                                FutureBuilder<SettingsVal>(
                                    future: getZoomVal(
                                        uidCameraZoomLevel,
                                        uidCameraScanAreaScale,
                                        uidCameraFlashStatus),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 0),
                                            child: SizedBox(
                                              height: 55,
                                              child: CupertinoButton(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                color: Colors.cyan,
                                                child: const Icon(
                                                  Icons.qr_code,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => QRScanView(
                                                              setUDIQrCodeValue,
                                                              areaScale:
                                                                  snapshot.data!
                                                                      .scaleVal,
                                                              flashStatus:
                                                                  snapshot.data!
                                                                      .flashVal,
                                                              zoomScale: snapshot
                                                                  .data!
                                                                  .zoomVal)));
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Expanded(
                                            flex: 1, child: Container());
                                      }
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RoundedLoadingButton(
                              height: 55,
                              width: (width) - 10,
                              borderRadius: 12,
                              loaderStrokeWidth: 4,
                              controller: _btnController,
                              onPressed: _doSomething,
                              child: const Text('Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    )));
  }
}
