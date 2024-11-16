import 'package:first_project/ui/controllers/add_new_task_controller.dart';
import 'package:first_project/ui/controllers/cancelled_task_controller.dart';
import 'package:first_project/ui/controllers/change_status_controller.dart';
import 'package:first_project/ui/controllers/completed_task_controller.dart';
import 'package:first_project/ui/controllers/delete_task_controller.dart';
import 'package:first_project/ui/controllers/forgot_password_email_controller.dart';
import 'package:first_project/ui/controllers/new_task_list_controllers.dart';
import 'package:first_project/ui/controllers/new_task_status_count_controller.dart';
import 'package:first_project/ui/controllers/profile_update_controller.dart';
import 'package:first_project/ui/controllers/progress_task_controller.dart';
import 'package:first_project/ui/controllers/reset_password_controller.dart';
import 'package:first_project/ui/controllers/sign_in_controller.dart';
import 'package:first_project/ui/controllers/sign_up_controller.dart';
import 'package:first_project/ui/controllers/verify_otp_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(NewTaskListController());
    Get.put(NewTaskListCountController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ProgressTaskController());
    Get.put(AddNewTaskController());
    Get.put(ForgotPasswordEmailController());
    Get.put(VerifyOtpController());
    Get.put(ResetPasswordController());
    Get.put(ProfileUpdateController());
    Get.put(DeleteTaskController());
    Get.put(ChangeStatusController());
  }

}