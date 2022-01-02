import 'package:get/get.dart';
import 'package:main_todo/app/data/providers/task/provider.dart';
import 'package:main_todo/app/data/services/storge/repository.dart';
import 'package:main_todo/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeControll(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
