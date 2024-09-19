import 'package:first_project/data/models/task_status_model.dart';
import 'package:first_project/ui/controllers/new_task_list_controllers.dart';
import 'package:first_project/ui/controllers/new_task_status_count_controller.dart';
import 'package:first_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:first_project/ui/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:first_project/ui/screens/add_new_task_screen.dart';
import 'package:first_project/ui/widgets/task_card.dart';
import 'package:first_project/ui/widgets/task_summary_card.dart';
import 'package:get/get.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const name = '/new_task_screen';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();
  final NewTaskListCountController _newTaskListCountController =
      Get.find<NewTaskListCountController>();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: GetBuilder<NewTaskListController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: controller.taskList[index],
                        onRefreshList: _getNewTaskList,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<NewTaskListCountController>(builder: (controller) {
          return Visibility(
              visible: controller.inProgress == false,
              replacement: const CenteredCircularProgressIndicator(),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getTaskSummaryCardList(),
                ),
              ));
        }));
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummarycardList = [];
    for (TaskStatusModel t in _newTaskListCountController.taskStatusCountList) {
      taskSummarycardList
          .add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));
    }
    return taskSummarycardList;
  }

  Future<void> _onTapAddFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBarMessage(context, _newTaskListController.errorMessage!, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final bool result = await _newTaskListCountController.getTaskStatusCount();
    if (result == false) {
      showSnackBarMessage(
          context, _newTaskListCountController.errorMessage!, true);
    }
  }
}
