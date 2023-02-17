import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String _currentModel = 'Model 1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Constants.scaffoldBackgroundColor,
      iconEnabledColor: Colors.white,
      items: Constants.getModelItems,
      value: _currentModel,
      onChanged: (value) {
        setState(() {
          _currentModel = value.toString();
        });
      },
    );
  }
}
