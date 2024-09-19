import 'package:first_project/ui/controllers/completed_task_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:first_project/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/widgets/task_card.dart';
import 'package:get/get.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  static const name = '/completed_task_screen';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTaskList();
          },
          child: ListView.separated(
            itemCount: controller.taskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.taskList[index],
                onRefreshList: _getCompletedTaskList,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ),
      );
    });
  }

  Future<void> _getCompletedTaskList() async {
    final bool result = await _completedTaskController.completedTaskList();
    if (result == false) {
      showSnackBarMessage(
          context, _completedTaskController.errorMessage!, true);
    }
  }
}
