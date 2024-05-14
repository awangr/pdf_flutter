import 'package:get/get.dart';

import '../controllers/learn_pdf_controller.dart';

class LearnPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LearnPdfController>(
      () => LearnPdfController(),
    );
  }
}
