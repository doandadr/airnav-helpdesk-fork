import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'faq_controller.dart';

class FaqPage extends GetView<FaqController> {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              controller.togglePanel(index);
            },
            children: controller.faqItems.map<ExpansionPanel>((FaqItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.question),
                  );
                },
                body: ListTile(
                  title: Text(item.answer),
                  tileColor: Colors.grey[100],
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
