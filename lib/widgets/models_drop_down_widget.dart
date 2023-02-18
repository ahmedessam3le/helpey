import 'package:flutter/material.dart';
import 'package:helpey/services/api_services.dart';
import 'package:helpey/widgets/text_widget.dart';

import '../constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String _currentModel = 'text-davinci-003';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiServices.getAIModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TextWidget(label: snapshot.error.toString());
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: Constants.scaffoldBackgroundColor,
                    iconEnabledColor: Colors.white,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: TextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: _currentModel,
                    onChanged: (value) {
                      setState(() {
                        _currentModel = value.toString();
                      });
                    },
                  ),
                );
        });
  }
}
