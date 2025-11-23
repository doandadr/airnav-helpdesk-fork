import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'add_ticket_controller.dart';

class AddTicketPage extends GetView<AddTicketController> {
  const AddTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Ticket')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              _buildSelect(
                label: 'Department',
                value: controller.selectedDepartment,
                items: controller.departments,
                onChanged: controller.onDepartmentChanged,
              ),
              const SizedBox(height: 16),
              _buildSelect(
                label: 'Sub-department',
                value: controller.selectedSubDepartment,
                items: controller.subDepartments,
                onChanged: controller.onSubDepartmentChanged,
              ),
              const SizedBox(height: 16),
              _buildSelect(
                label: 'Category',
                value: controller.selectedCategory,
                items: controller.categories,
                onChanged: controller.onCategoryChanged,
              ),
              const SizedBox(height: 16),
              _buildSelect(
                label: 'Sub-category',
                value: controller.selectedSubCategory,
                items: controller.subCategories,
                onChanged: controller.onSubCategoryChanged,
              ),
              const SizedBox(height: 16),
              ShadInput(
                controller: controller.subjectController,
                placeholder: const Text('Subject'),
              ),
              const SizedBox(height: 16),
              _buildSelect(
                label: 'Priority',
                value: controller.selectedPriority,
                items: controller.priorities,
                onChanged: controller.onPriorityChanged,
              ),
              const SizedBox(height: 16),
              ShadInput(
                controller: controller.descriptionController,
                placeholder: const Text('Describe Your Issue'),
                maxLines: 5,
                minLines: 3,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  // Implement file picking logic
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade50,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap to upload file',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ShadButton(
                onPressed: controller.submitTicket,
                width: double.infinity,
                child: const Text('Submit Ticket'),
              ),
            ],
          ),
        ),
      ],
    ));
  }

   Widget _buildLabel(String label, {bool isRequired = true}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
        children: <TextSpan>[
          if (isRequired)
            const TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSelect({
    required String label,
    required Rxn<String> value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Obx(
      () => ShadSelect<String>(
        placeholder: Text(label),
        initialValue: value.value,
        options: items
            .map((item) => ShadOption(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        selectedOptionBuilder: (context, value) {
          return Text(value);
        },
      ),
    );
  }
}