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
  @override
  Widget build(BuildContext context) {
    final aiModelsViewModel =
        Provider.of<AIModelsViewModel>(context, listen: true);
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
                    value: aiModelsViewModel.currentModel,
                    onChanged: (value) {
                      aiModelsViewModel.setCurrentModel(value.toString());
                    },
                  ),
                );
        });
  }
}
