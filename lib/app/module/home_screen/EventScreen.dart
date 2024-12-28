import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:national_wild_animal/app/api_service/api_end_point.dart';
import 'package:national_wild_animal/app/api_service/country_api_services.dart';
import 'package:national_wild_animal/app/api_service/http_methods.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';

import 'package:national_wild_animal/app/common_widgets/common_button.dart';
import 'package:national_wild_animal/app/common_widgets/show_snack_bar.dart';
import 'package:national_wild_animal/app/module/home_screen/HomeScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/LocationModel/location_model.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';

import 'package:national_wild_animal/app/module/login_screen/provider/event_screen_provider.dart';
import 'package:national_wild_animal/app/screens/EventListed/EventListed.dart';

import 'package:national_wild_animal/app/common_widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../app_utils/utils.dart';
import '../../common_widgets/CustomAppBar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: EventScreen(),
    );
  }
}

class _EventScreenState extends State<EventScreen> {


   DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController();
  TextEditingController dateController2 = TextEditingController();

  //this controller for create event form field..........
  TextEditingController eventController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController citiesController = TextEditingController();
  final valueListenable = ValueNotifier<String?>(null);
 
  TextEditingController pincodeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();

  

  bool check1 = false;
  bool check2 = false;

   String? latitudeData;
   String? longitudeData;
   String? locationData;
   String? tokenData;


  Future<void> _getLongLatAddress() async {
  latitudeData = await sharedPref.getKey('latitude');
  longitudeData = await sharedPref.getKey('longitude');
  locationData = await sharedPref.getKey('currentLocation');
  //print(base64String);
  print("$latitudeData"+"==================");
  print("$longitudeData");
  print("$locationData");
  
}




    //this variable for getting longitude,latitude,location............
 
   
 /* //this api for store event create data in database.........
   Future<FormData> createFormDataWithEmptyTextFile(String fileName) async {
  // Create a temporary empty file
  final file = File(fileName);
  await file.writeAsString(''); // Ensure the file is empty

  // Create the FormData instance
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path, filename: fileName),
  });

  return formData;
}*/

  //convert cities into base64 string..........
  

  

  String? categoriesId;

   createEvent() async {

      late FormData formData;
      formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });
                  //convert cities into base64 string..........
                  
            
                 //formData=await createFormDataWithEmptyTextFile("file1.txt");
                 print("hello");
              String? cities=context.read<HomeScreenProvider>().dropdownValue2!.cityId;
              //String cities64 = base64Encode(utf8.encode(cities!));
                    //print(cities64);
              DataLstClass? categories=context.read<HomeScreenProvider>().dropdownValue3;
              String? categoriesId=categories?.categoriId;

              // **Create new FormData for each request**
  
              

 
     
    
    try {
      // Prepare the JSON data from the input fields
      Map<String, dynamic> createEventJson = 
      
            {
  
  "eventName": eventController.text,
  "description": descriptionController.text,
  "eventCategory": categoriesId,
  "addressLine1": addressController.text,
  "addressLine2":addressLine2Controller.text,
  "pinCode": pincodeController.text,
  "city":cities ,
  "isPresentInEventLocation": false,
  "latitude": latitudeData?.toString(),
  "longitude":  longitudeData?.toString(),
  "eventStartDate": startDateController.text,
  "eventEndDate":endDateController.text,
  "isBookable": check1,
  "isFreeEntry": check2
};

        print("$latitudeData"+"==================");
  print("$longitudeData");
  print("$locationData");


        String? jsonString;
        String? base64String;

        //Convert the Map to a JSON string
   jsonString = jsonEncode(createEventJson);

   //jsonString=createEventJson.toString as String?;

  // Convert the JSON string to Base64
  base64String = base64Encode(utf8.encode(jsonString));
  //base64String="ewogICAgICAgICAgICAiZXZlbnRJZCI6ICIiLAogICAgICAgICAgICAiZXZlbnROYW1lIjoiaGVsbG8iLAogICAgICAgICAgICAiZGVzY3JpcHRpb24iOiJoaWkiLAogICAgICAgICAgICAiZXZlbnRDYXRlZ29yeSI6ImE0YzhmNWE3LWRjZTItNDJlZi04ZjRhLTllM2Q0NTNiMzZiOSIsCiAgICAgICAgICAgICJhZGRyZXNzTGluZTEiOiJQYXRpYSIsCiAgICAgICAgICAgICJhZGRyZXNzTGluZTIiOiJOZWFyIEtJSVQiLAogICAgICAgICAgICAicGluQ29kZSI6IjEyMzQiLAogICAgICAgICAgICAiY2l0eSI6IjgzYTZkM2U1LTVmOTEtNGM2Yi1iNWM4LTc4YjdiN2ZiYzRmMSIsCiAgICAgICAgICAgICJpc1ByZXNlbnRJbkV2ZW50TG9jYXRpb24iOmZhbHNlLAogICAgICAgICAgICAibGF0aXR1ZGUiOiIyMC4zOTA2MjAiLAogICAgICAgICAgICAibG9uZ2l0dWRlIjoiODUuODI3NTIyIiwKICAgICAgICAgICAgImV2ZW50U3RhcnREYXRlIjoiMjAyNC0xMS0xMyIsCiAgICAgICAgICAgICJldmVudEVuZERhdGUiOiIyMDI0LTExLTI5IiwKICAgICAgICAgICAgImlzQm9va2FibGUiOnRydWUsCiAgICAgICAgICAgICJpc0ZyZWVFbnRyeSI6ZmFsc2UKICAgICAgICAgICAgCiAgICAgIH0KCgo=";

   //final jsonBytes = jsonEncode(createEventJson).codeUnits;
   //base64String = base64Encode(jsonBytes);
  


    HttpMethodsDio().postMethodWithToken1(
          token: tokenData,
          api: ApiEndPoint.createEvent(base64String),
          json:formData,
          
          fun: (map, code) async {
            print(map);
            print(code);
                 Utils.showProgressIndicator();
            await Future.delayed(Duration(seconds: 2));
            Utils.disMissProgressIndicator();
             
            print(code);
            if (code == 200) {
              print("Data store in database successfully..........");

              Utils.disMissProgressIndicator();
              ShowSnackBar.showSuccess(context, "Event Created Successfully");
             
            } else {
              print(base64String);
              
              print("Unable to store data in database........");
              Utils.disMissProgressIndicator();
              ShowSnackBar.showError(context, "Something went wrong");
            }
          });
    } catch (e) {
      Utils.disMissProgressIndicator();
      ShowSnackBar.showError(context, "Something went wrong");
    }

   
    
  }

 

  List item = ["Create Event", "Event Listing"];

  List country = ["India", "Pakistan", "China", "Japan"];

  //final TextEditingController country1 = TextEditingController();
//final valueListenable = ValueNotifier<String?>(null);

  TextEditingController search1 = TextEditingController();
  TextEditingController search2 = TextEditingController();
  TextEditingController search3 = TextEditingController();
  TextEditingController search4 = TextEditingController();
  TextEditingController search5 = TextEditingController();

  int current = 0;
  String? selectedCountry;
  //here we have created object of shared preference.........
  SharedPref sharedPref = SharedPref();

  

  //this variable for store upload image in string format
  String? base64CameraImage;
  String? base64FileImage;

  //this variable for getting token.................

 
   //this method for getting token
   Future<String?> getToken()async {
    
       String token=await sharedPref.getKey("token");
       tokenData=json.decode(token);
        print("token"+tokenData.toString());
   }

   

    String fileName1 = "Upload Image";

   late  String? base64Image;  
     String? name;

     late File imageFile;

     String? fileName;

  Future pickImage(ImageSource source) async {
    try {
      
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 20);

      if (image == null) {
        Utils.disMissProgressIndicator();
        return;
      }
       // Read the file
     imageFile = File(image.path);
      name= imageFile.uri.pathSegments.last;

      // Create FormData
    fileName = imageFile.path.split('/').last;
     

      // Update the UI with the file name
    setState(() {
      fileName1 =name!; // Update the state variable
    });

    // Convert the image to Base64
    final bytes = await imageFile.readAsBytes();
    base64Image = base64Encode(bytes);
      // final imageTemporary = File(image.path);
      Utils.disMissProgressIndicator();
      return base64Image;
    } on PlatformException catch (e) {
      Utils.disMissProgressIndicator();
      if (kDebugMode) {
        print("Failed  to pick image: $e");
      }
    }
  }

  void showModalPop({bool profile = false, required BuildContext context}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  Utils.showProgressIndicator();
                  base64CameraImage = await pickImage(ImageSource.camera);
                  
                  
                   if (base64CameraImage != null) {
                print("Base64 Image: $base64CameraImage");
                // You can now use the base64Image string
              }
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.pop(context);
                  Utils.showProgressIndicator();
                  base64FileImage = await pickImage(ImageSource.gallery);
                  
                  if (base64FileImage != null) {
                print("Base64 Image: $base64FileImage");
                // You can now use the base64Image string
              }
                },
                child: const Text('Upload from files'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }

  /*Future<List<String>?> pickImages(bool fromGallery) async {
  try {
    if (fromGallery) {
      // Use FilePicker for picking multiple images from gallery
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        // Convert picked images to Base64 strings
        List<String> base64Images = [];
        List<String> fileNames = [];

        for (var file in result.files) {
          final fileBytes = File(file.path!).readAsBytesSync();
          base64Images.add(base64Encode(fileBytes));
          fileNames.add(file.name);
        }

        setState(() {
          fileName = fileNames.join(", "); // Update UI with file names
        });

        return base64Images;
      }
    } else {
      // Use camera to capture multiple images
      List<String> base64Images = [];
      bool keepCapturing = true;

      while (keepCapturing) {
        final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 20,
        );

        if (image != null) {
          final fileBytes = File(image.path).readAsBytesSync();
          base64Images.add(base64Encode(fileBytes));
        }

        // Prompt to capture another image
        keepCapturing = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Capture Another?"),
                content: const Text("Do you want to capture another image?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Yes"),
                  ),
                ],
              ),
            ) ??
            false;
      }

      return base64Images.isNotEmpty ? base64Images : null;
    }
  } catch (e) {
    Utils.disMissProgressIndicator();
    if (kDebugMode) {
      print("Error picking images: $e");
    }
    return null;
  }
  return null;
}*/

/*void showModalPop({bool profile = false, required BuildContext context}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              Utils.showProgressIndicator();
              final images = await pickImages(false); // Use camera

              if (images != null && images.isNotEmpty) {
                for (var image in images) {
                  print("Base64 Image (Camera): $image");
                }
              }
              Utils.disMissProgressIndicator();
            },
            child: const Text('Use Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              Utils.showProgressIndicator();
              final images = await pickImages(true); // Use gallery

              if (images != null && images.isNotEmpty) {
                for (var image in images) {
                  print("Base64 Image (Gallery): $image");
                }
              }
              Utils.disMissProgressIndicator();
            },
            child: const Text('Upload from Gallery'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
      );
    },
  );
}*/


  Future<bool> getCityLst() async {
    Completer<bool> completer = Completer<bool>();

    List<Data> cityDatTemp = [];
    Data? dropDownValTemp;
    try {
      String data = await sharedPref.getKey("token");
      String token = json.decode(data);
      HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.citiesUrl,
          fun: (map, code) {
            if (code == 200 &&
                map is Map &&
                map['data'] != null &&
                map["data"].length > 0) {
              GetLocationModel citiesName =
                  GetLocationModel.fromJson(map as Map<String, dynamic>);
              cityDatTemp = citiesName.data ?? [];
              dropDownValTemp = cityDatTemp[0];
            } else {
              // dropDownValTemp = cityDatTemp[0];
            }
            context.read<HomeScreenProvider>().setCityList(
                cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
            completer.complete(true);
          },
          token: token);
    } catch (e) {
      context.read<HomeScreenProvider>().setCityList(
          cityLstData: cityDatTemp, dropdownValueData: dropDownValTemp);
      completer.complete(false);
    }
    return completer.future;
  }

  //this is for country api integration..........................
  final CountryApiServices apiService = CountryApiServices();
  String? selectedCountry1;
  String? selectedCountry2;
  String? selectedCountry3;
  String? selectedCountry4;
  String? selectedCountry5;
  List<String> countries = [];

  Future<void> fetchCountries() async {
    try {
      List<String> fetchedCountries = await apiService.fetchCountries();
      setState(() {
        countries = fetchedCountries;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> getCategoryList() async {
    Completer<bool> completer = Completer<bool>();
    List<DataLstClass> categoryListTemp = [];
    try {
      String data = await sharedPref.getKey("token");
      String token = json.decode(data);

      HttpMethodsDio().getMethodWithToken(
          api: ApiEndPoint.categoryLst,
          fun: (map, code) {
            if (code == 200 && map['data'] != null && map['data'].length > 0) {
              context.read<HomeScreenProvider>().categoryList.clear();

              map['data'].forEach((e) {
                categoryListTemp.add(DataLstClass(
                    categoriId: e['id'],
                    nameStr: e['categoryName'], icon: Icons.category_outlined));
                    print("==================${categoryListTemp.map((e) => "${e.nameStr}: ${e.categoriId}").toList()}");
              });
              categoryListTemp.insert(
                0,
                DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
              );
              context
                  .read<HomeScreenProvider>()
                  .setCategoryList(categoryListData: categoryListTemp);
            } else {
              categoryListTemp = [
                DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
              ];
              context
                  .read<HomeScreenProvider>()
                  .setCategoryList(categoryListData: categoryListTemp);
            }
            completer.complete(true);
          },
          token: token);
    } catch (e) {
      categoryListTemp = [
        DataLstClass(icon: Icons.border_all_rounded, nameStr: "All"),
      ];
      context
          .read<HomeScreenProvider>()
          .setCategoryList(categoryListData: categoryListTemp);
      completer.complete(false);
    }
    return completer.future;
  }

  @override
  void initState() {
    getCategoryList();
    getCityLst();
    super.initState();
    fetchCountries();
    _getLongLatAddress();
    getToken();
  
  }

 

   
  @override
  Widget build(BuildContext context) {
    context.read<HomeScreenProvider>().dropdownValue2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF231D32),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<HomeScreenProvider>(
                builder: (context, provider, child) {
                  return CustomAppBar(
                    cityLst: context.read<HomeScreenProvider>().cityLst,
                    dropdownValue:
                        context.read<HomeScreenProvider>().dropdownValue,
                    onChange: (Data? val) {
                      context
                          .read<HomeScreenProvider>()
                          .setDropDownVal(val: val);
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 33,
                decoration: BoxDecoration(color: Colors.transparent),
                child: TabBar(
                    physics: ClampingScrollPhysics(),
                    unselectedLabelColor: Color(0xffB74BFF),
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffB74BFF),
                        border: Border(
                            bottom: BorderSide(color: Colors.transparent))),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 33,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xffB74BFF), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Create Event",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 33,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xffB74BFF), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Event Listed",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              Expanded(
                  child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Event Name",
                          controller: eventController,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Address Line 1",
                          controller: addressController,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        CustomTextField(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffB74BFF)),
                          ),
                          inputHint: "Address Line 2",
                          controller: addressLine2Controller,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width:
                              double.infinity, // or any specific width you need
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xffB74BFF)),
                                          borderRadius:
                                              BorderRadius.circular(14))),
                                  child: Consumer<HomeScreenProvider>(
                                    builder: (context, provider, child) {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton2<Data>(
                                          isExpanded: true,
                                          hint: Text(
                                            "Cities",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: context
                                              .read<HomeScreenProvider>()
                                              .dropdownValue2,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: ColorsGroup.iconColor,
                                              ),
                                              maxHeight: 150,
                                              offset: const Offset(0, 0),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          WidgetStateProperty
                                                              .all<double>(8),
                                                      thumbVisibility:
                                                          WidgetStateProperty
                                                              .all<bool>(true)),
                                              scrollPadding: EdgeInsets.all(3)),
                                          items: context
                                              .read<HomeScreenProvider>()
                                              .cityLst
                                              .map<DropdownMenuItem<Data>>(
                                                  (Data value) {
                                            return DropdownMenuItem<Data>(
                                              value: value,
                                              child: Text(value.cityName ?? ""),
                                            );
                                          }).toList(),
                                          onChanged: (Data? newValue) {
                                            print(newValue);
                                            context
                                                .read<HomeScreenProvider>()
                                                .setDropDownVal2(val: newValue);
                                          },
                                          /*onMenuStateChange: (bool sta) {
                                            debugPrint(">>>>>>>>>>>>>>$sta");
                                            if (sta) {
                                              citiesController.text="";
                                            }
                                          },*/
                                          /*dropdownSearchData:
                                              DropdownSearchData(
                                            searchController: search4,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Container(
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                expands: true,
                                                maxLines: null,
                                                controller: citiesController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText: 'Search ...',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              print(
                                                  'City Name: ${item.value?.cityName}, Search Value: $searchValue');
                                              return item.value!.cityName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchValue
                                                      .toString()
                                                      .toLowerCase());
                                            },
                                          ),
                                        )*/
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              /* Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry2,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry2 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search2,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country2Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),*/
                              Expanded(
                                  child: CustomTextField(
                                    controller: pincodeController,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "Pin Code",
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xffB74BFF)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Consumer<HomeScreenProvider>(
                            builder: (context, provider, child) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton2<DataLstClass>(
                                  isExpanded: true,
                                  hint: Text(
                                    "Categories",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: provider
                                      .dropdownValue3, // Assuming dropdownValue2 is used for category selection
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: ColorsGroup.iconColor,
                                    ),
                                    maxHeight: 150,
                                    offset: const Offset(0, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness:
                                          WidgetStateProperty.all<double>(8),
                                      thumbVisibility:
                                          WidgetStateProperty.all<bool>(true),
                                    ),
                                    scrollPadding: EdgeInsets.all(3),
                                  ),
                                  items: provider.categoryList
                                      .map<DropdownMenuItem<DataLstClass>>(
                                    (DataLstClass value) {
                                      return DropdownMenuItem<DataLstClass>(
                                        value: value,
                                        child: Text(value.nameStr ?? ""),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (DataLstClass? newValue) {
                                     print("Selected Category ID: ${newValue?.categoriId}");
                                     categoriesId=newValue?.categoriId;
                                    provider.setDropDownVal3(
                                        val:
                                            newValue); // Set the selected category
                                  },
                                  /*onMenuStateChange: (bool sta) {
                                    debugPrint("Menu state changed: $sta");
                                  },*/
                                  /*dropdownSearchData: DropdownSearchData(
                                    searchController: search4,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 4, right: 8, left: 8),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        //controller: country2Controller,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 8),
                                          hintText: 'Search ...',
                                          hintStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return item.value!.nameStr
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchValue
                                              .toString()
                                              .toLowerCase());
                                    },
                                  ),*/
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: startDateController,
                                readOnly: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "Start Date",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _selectDate();
                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: CustomTextField(
                                focusedBorder: OutlineInputBorder(),
                                controller:endDateController,
                                readOnly: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffB74BFF)),
                                ),
                                inputHint: "End Date",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _selectDate1();
                                    },
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /*Container(
                          width: double.infinity, // or any specific width you need
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry4,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry4 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search4,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country4Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0xffB74BFF)),
                                          borderRadius: BorderRadius.circular(14))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: selectedCountry5,
                                      dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: ColorsGroup.iconColor,
                                          ),
                                          maxHeight: 150,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness: WidgetStateProperty.all<double>(8),
                                              thumbVisibility: WidgetStateProperty.all<bool>(true)),
                                          scrollPadding: EdgeInsets.all(3)),
                                      items: countries
                                          .map((String country) => DropdownMenuItem<String>(
                                              value: country,
                                              child: Text(
                                                country,
                                                style: TextStyle(color: Colors.white),
                                              )))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountry5 = newValue;
                                        });
                                      },
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: search5,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: country5Controller,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search ...',
                                              hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .toLowerCase()
                                              .contains(searchValue.toString().toLowerCase());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalPop(context: context);
                                },
                                child: CustomTextField(
                                  enable: false,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffB74BFF)),
                                  ),
                                  inputHint: fileName1,
                                  suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.upload_file,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check1,
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: -4),
                                        onChanged: (value1) {
                                          setState(() {
                                            check1 = value1!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "is Free Entry Allow ?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9),
                                        maxLines: 2,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: check2,
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: -4),
                                        onChanged: (value2) {
                                          setState(() {
                                            check2 = value2!;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.26,
                                        child: Text(
                                          "is Booking System Present ?",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 9),
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                     
                     Container(
                      height: 120,
                       child: TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        style: TextStyle(color: Colors.white),
                         decoration: InputDecoration(
                          hintText: "Enter Event Description............",
                          hintStyle: TextStyle(color: Colors.white),
                           border: OutlineInputBorder(
                            
                             borderSide: BorderSide(
                                width: 3,
                                color: Colors.white
                             )
                           )
                         ),
                       ),
                     ),

                        SizedBox(
                          height: 15,
                        ),
                        
                        CommonButton(
                          onTap: () {
                            createEvent();
                            print("hello");
                          },
                          buttonText: "Submit",
                          width: double.infinity,
                        ),
                        /*ElevatedButton(onPressed: () async {
                                    createEvent();
                                    setState(() {
                                       formData=FormData();
                                    });
                        }, child: Text("Submit"))*/
                      ],
                    ),
                  ),
                ),
                //Text("Hii",style: TextStyle(color: Colors.white),)
                EventListedPage()
              ]))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? currentDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (currentDate != null && currentDate != selectedDate) {
      setState(() {
        startDateController.text = currentDate.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectDate1() async {
    DateTime? currentDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (currentDate != null && currentDate != selectedDate) {
      setState(() {
        endDateController.text = currentDate.toString().split(" ")[0];
      });
    }
  }
}
