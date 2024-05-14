import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/learn_pdf/bindings/learn_pdf_binding.dart';
import '../modules/learn_pdf/views/learn_pdf_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LEARN_PDF;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LEARN_PDF,
      page: () => const LearnPdfView(),
      binding: LearnPdfBinding(),
    ),
  ];
}
