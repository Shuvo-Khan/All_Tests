import 'package:first_project/ui/controllers/progress_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/widgets/task_card.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';
import 'package:get/get.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  static const name = '/progress_task_screen';

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getProgressTaskList();
          },
          child: ListView.separated(
            itemCount: controller.taskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.taskList[index],
                onRefreshList: _getProgressTaskList,
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

  Future<void> _getProgressTaskList() async {
    final bool result = await _progressTaskController.progressTaskList();
    if (result == false) {
      showSnackBarMessage(context, _progressTaskController.errorMessage!, true);
    }
  }
}
