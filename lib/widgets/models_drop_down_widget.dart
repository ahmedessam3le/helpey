import 'package:flutter/material.dart';
import 'package:helpey/view_models/ai_models_view_model.dart';
import 'package:helpey/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? _currentModel;
  @override
  Widget build(BuildContext context) {
    final aiModelsViewModel =
        Provider.of<AIModelsViewModel>(context, listen: false);
    _currentModel = aiModelsViewModel.currentModel;
    return FutureBuilder(
        future: aiModelsViewModel.fetchAIModels(),
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
                      aiModelsViewModel.setCurrentModel(value.toString());
                    },
                  ),
                );
        });
  }
}
