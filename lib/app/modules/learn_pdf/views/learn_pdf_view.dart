import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/learn_pdf_controller.dart';

class LearnPdfView extends GetView<LearnPdfController> {
  const LearnPdfView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${controller.products[index]['name']}'),
              leading: CircleAvatar(
                  child: Text('${controller.products[index]['id']}')),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getPdf();
        },
      ),
    );
  }
}
