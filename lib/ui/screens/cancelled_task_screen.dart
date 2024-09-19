import 'package:first_project/ui/controllers/cancelled_task_controller.dart';
import 'package:first_project/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/widgets/task_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/centered_circular_progress_indicator.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  static const name = '/cancelled_task_screen';

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>(builder: (controller) {
      return Visibility(
        visible: !controller.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCancelledTaskList();
          },
          child: ListView.separated(
            itemCount: controller.taskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: controller.taskList[index],
                onRefreshList: _getCancelledTaskList,
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

  Future<void> _getCancelledTaskList() async {
    final bool result = await _cancelledTaskController.cancelledTaskList();
    if (result == false) {
      showSnackBarMessage(
          context, _cancelledTaskController.errorMessage!, true);
    }
  }
}
