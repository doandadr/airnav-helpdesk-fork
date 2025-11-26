import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_bar_widget.dart';
import 'add_ticket_controller.dart';

class AddTicketPage extends GetView<AddTicketController> {
  const AddTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        titleText: 'new_ticket_title'.tr,
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildReporterCard(),
            const SizedBox(height: 16),
            _buildDescriptionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.red[900]!.withOpacity(0.3)
            : const Color(0xFFFEEBEE),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.red[100] : const Color(0xFFC62828),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildReporterCard() {
    return _buildCard(
      Column(
        children: [
          _buildSectionHeader('reporter_section'.tr),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildReadOnlyField('nik_label'.tr, '10014377'),
                const SizedBox(height: 16),
                _buildReadOnlyField('name_label'.tr, 'BUDI'),
                const SizedBox(height: 16),
                _buildReadOnlyField('department_label'.tr, 'IT'),
                const SizedBox(height: 16),
                _buildReadOnlyField(
                  'sub_department_label'.tr,
                  'IT DEVELOPMENT',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return _buildCard(
      Column(
        children: [
          _buildSectionHeader('description_section'.tr),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDropdown(
                  'channel_label'.tr,
                  controller.selectedDepartment,
                  controller.departments,
                  controller.onDepartmentChanged,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  'pipeline_label'.tr,
                  controller.selectedSubDepartment,
                  controller.subDepartments,
                  controller.onSubDepartmentChanged,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  'category_label'.tr,
                  controller.selectedCategory,
                  controller.categories,
                  controller.onCategoryChanged,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  'sub_category_label'.tr,
                  controller.selectedSubCategory,
                  controller.subCategories,
                  controller.onSubCategoryChanged,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  'priority_label'.tr,
                  controller.selectedPriority,
                  controller.priorities,
                  controller.onPriorityChanged,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  'source_label'.tr,
                  controller.selectedSource,
                  controller.sources,
                  controller.onSourceChanged,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'subject_label'.tr,
                  hint: 'subject_hint'.tr,
                  controller: controller.subjectController,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'description_label'.tr,
                  hint: 'description_hint'.tr,
                  maxLines: 4,
                  controller: controller.descriptionController,
                ),
                const SizedBox(height: 16),
                _buildDueDatePicker(),
                const SizedBox(height: 16),
                _buildAttachmentPicker(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = true}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
        children: <TextSpan>[
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          readOnly: true,
          style: const TextStyle(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor:
                Get.theme.inputDecorationTheme.fillColor ?? Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    Rxn<String> value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        Obx(
          () => DropdownButtonFormField<String>(
            value: value.value,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  Get.theme.inputDecorationTheme.fillColor ??
                  Get.theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Get.theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            hint: Text(
              'choose_option'.tr,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor:
                Get.theme.inputDecorationTheme.fillColor ?? Get.theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDueDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('due_date_label'.tr),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.calendar_today_outlined,
                color: Colors.blueGrey,
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                '24 Nov 2025, 16.04',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'default_due_date'.tr,
          style: const TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildAttachmentPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('attachment_label'.tr, isRequired: false),
        const SizedBox(height: 8),
        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: Get.theme.colorScheme.primary,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                'click_to_upload'.tr,
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'file_format_hint'.tr,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.submitTicket,
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'submit_ticket'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              /* TODO: Implement reset form */
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Text(
              'reset_form'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
