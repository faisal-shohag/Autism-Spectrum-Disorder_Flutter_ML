import 'package:asd/components/button.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/color.dart';
// import 'package:asd/models/info.dart';
import 'package:asd/models/myData.dart';
import 'package:asd/services/server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'dart:io';

class DiagnosisForm extends StatefulWidget {
  const DiagnosisForm({super.key});

  @override
  State<DiagnosisForm> createState() => _DiagnosisFormState();
}

// Input data
String name = "",
    dateOfBirth = "",
    ageAtAssesment = "",
    gender = "",
    grade = "",
    school = "",
    father = "",
    mother = "",
    home = "",
    parentsEmail = "",
    currentConcerns = "";
List<String> concerns = [];
var pickedFile;

String response = "";
//QA
TextEditingController dateinput = TextEditingController();

class _DiagnosisFormState extends State<DiagnosisForm> {
  String text = "";
  bool isClickPredict = false;

  @override
  void dispose() {
    super.dispose();
    pickedFile = null;
    response = "";
    text = "";
    isClickPredict = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Diagnosis',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/upload.png',
                  height: 150.0,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () async {
                    var file = await BaseClient().getFile();
                    if (file != null) {
                      setState(() {
                        pickedFile = file["file"];
                        text = file["name"];
                        response = "";
                      });
                    } else {
                      ErrorSnackBar(context, 'Image was not selected!');
                    }
                  },
                  icon: const Icon(
                    Remix.image_add_fill,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Pick an Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (pickedFile != null)
                  Image.file(
                    pickedFile,
                    height: 100,
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (text != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Remix.image_fill),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(text)
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    debugPrint('Predict');

                    if (pickedFile == null) {
                      ErrorSnackBar(context, 'Please Pick an Image First!');
                    } else {
                      setState(() {
                        isClickPredict = true;
                      });
                      response = await BaseClient().upload(pickedFile);
                      Provider.of<MyData>(context, listen: false)
                          .updateGVal(response);

                      setState(() {
                        isClickPredict = false;
                      });
                    }
                  },
                  child: FlexButton(
                    buttonText: 'Predict',
                    buttonColor: color2.withOpacity(1),
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (isClickPredict) CircularProgressIndicator(),
                if (response != "")
                  Consumer<MyData>(
                    builder: (context, myData, child) =>
                        Text('Result: ${myData.response}'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoForm extends StatefulWidget {
  const InfoForm({super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  // // Input data
  // String name = "",
  //     dateOfBirth = "",
  //     ageAtAssesment = "",
  //     gender = "",
  //     grade = "",
  //     currentConcerns = "";
  // List<String> concerns = [];
  // //QA
  // TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/parenting.png',
            height: 200.0,
          ),
          TextField(
            decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Remix.user_2_fill),
                border: OutlineInputBorder()),
            onChanged: (text) {
              name = text;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: dateinput,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Date of birth(DD/MM/YY)",
              prefixIcon: Icon(Remix.cake_2_fill),
            ),
            onChanged: (text) {
              dateOfBirth = text;
            },
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                debugPrint(pickedDate
                    .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                debugPrint(formattedDate);
                setState(() {
                  dateinput.text = formattedDate;
                  dateOfBirth =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                debugPrint("Date is not selected");
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Age at assesment",
              prefixIcon: Icon(Remix.edit_circle_fill),
            ),
            onChanged: (text) {
              ageAtAssesment = text;
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "School",
              prefixIcon: Icon(Remix.building_2_fill),
            ),
            onChanged: (text) {
              school = text;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Father",
              prefixIcon: Icon(Remix.empathize_line),
            ),
            onChanged: (text) {
              father = text;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Mother",
              prefixIcon: Icon(Remix.empathize_fill),
            ),
            onChanged: (text) {
              mother = text;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Home Address",
              prefixIcon: Icon(Remix.home_3_fill),
            ),
            onChanged: (text) {
              home = text;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Parent's Email",
              prefixIcon: Icon(Remix.mail_fill),
            ),
            onChanged: (text) {
              parentsEmail = text;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownTextField(
            dropDownItemCount: 2,
            listSpace: 20,
            listPadding: ListPadding(top: 20),
            validator: (value) {
              if (value == null) {
                return "Required field!";
              } else {
                return null;
              }
            },
            textFieldDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Gender",
              prefixIcon: Icon(Remix.men_fill),
            ),
            dropDownList: const [
              DropDownValueModel(name: 'Male', value: 'male'),
              DropDownValueModel(name: 'Female', value: 'female'),
            ],
            onChanged: (value) {
              setState(() {
                gender = value.value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Grade",
                prefixIcon: Icon(
                  Remix.star_fill,
                )),
            onChanged: (text) {
              grade = text;
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          DropDownTextField.multiSelection(
            displayCompleteItem: true,
            textFieldDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Current Concerns",
              prefixIcon: Icon(Remix.health_book_fill),
            ),
            dropDownList: const [
              DropDownValueModel(name: 'Listening', value: "listening"),
              DropDownValueModel(name: 'Hearing', value: "hearing"),
              DropDownValueModel(name: 'Walking', value: "Walking"),
              DropDownValueModel(name: 'Seeing', value: "Seeing"),
            ],
            onChanged: (value) {
              setState(() {
                for (int i = 0; i < value.length; i++) {
                  concerns.add(value[i].value);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class FileUploadForm extends StatefulWidget {
  const FileUploadForm({super.key});

  @override
  State<FileUploadForm> createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<FileUploadForm> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Image.asset(
          'assets/images/upload.png',
          height: 150.0,
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
          onPressed: () async {
            var file = await BaseClient().getFile();
            setState(() {
              if (file != null) {
                pickedFile = file["file"];
                text = file["name"];
              }
            });
          },
          icon: const Icon(
            Remix.image_add_fill,
            color: Colors.white,
          ),
          label: const Text(
            'Pick an Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (text != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Remix.video_fill),
              const SizedBox(
                width: 10,
              ),
              Text(text)
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        if (text != "")
          Image.file(
            pickedFile,
            height: 100,
          ),
      ],
    );
  }
}

class PredictScreen extends StatefulWidget {
  const PredictScreen({super.key});

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        if (pickedFile != null)
          Image.file(
            pickedFile,
            height: 150,
          ),
        const SizedBox(
          height: 10,
        ),
        Consumer<MyData>(
          builder: (context, myData, child) =>
              Text('Result: ${myData.response}'),
        ),
      ],
    );
  }
}
