import 'package:first_project/ui/controllers/add_new_task_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/widgets/tm_app_bar.dart';
import 'package:first_project/ui/widgets/snack_bar_message.dart';
import 'package:get/get.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const name = '/add_new_task_screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEControlloer =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _shouldRefreshPreviousPage = false;
  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shouldRefreshPreviousPage);
      },
      child: Scaffold(
        appBar: const TMAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  Text(
                    'Add New Task',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEControlloer,
                    maxLines: 5,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    final bool result = await _addNewTaskController.addNewTask(
        _titleTEController.text, _descriptionTEControlloer.text);

    if (result) {
      _shouldRefreshPreviousPage = true;
      _clearTextFields();
      showSnackBarMessage(context, 'New task added!');
    } else {
      showSnackBarMessage(context, _addNewTaskController.errorMessage!, true);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEControlloer.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEControlloer.dispose();
    super.dispose();
  }
}
