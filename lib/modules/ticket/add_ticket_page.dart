import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_ticket_controller.dart';

class AddTicketPage extends GetView<AddTicketController> {
  const AddTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text('New Ticket', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSubHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _buildReporterCard(),
                  const SizedBox(height: 16),
                  _buildDescriptionCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader() {
    return Container(
      color: const Color(0xFF0D47A1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.arrow_back, color: Colors.white),
          const SizedBox(width: 16),
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_outline, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Create New Ticket',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Lengkapi form untuk membuat tiket',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEEBEE),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC62828), fontSize: 14),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              spreadRadius: 1,
              blurRadius: 10,
            )
          ]
      ),
      child: child,
    );
  }

  Widget _buildReporterCard() {
    return _buildCard(Column(
      children: [
        _buildSectionHeader('Pelapor Masalah'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildReadOnlyField('NIK', '10014377'),
              const SizedBox(height: 16),
              _buildReadOnlyField('Nama', 'M NABIL AMANI'),
              const SizedBox(height: 16),
              _buildReadOnlyField('Departemen', 'AIRNAV INDONESIA'),
              const SizedBox(height: 16),
              _buildReadOnlyField('Bagian Departemen', 'CORPORATE SERVICES DIVISION'),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildDescriptionCard() {
    return _buildCard(Column(
      children: [
        _buildSectionHeader('Deskripsi Masalah'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdown('Channel', controller.selectedDepartment, controller.departments, controller.onDepartmentChanged),
              const SizedBox(height: 16),
              _buildDropdown('Pipeline', controller.selectedSubDepartment, controller.subDepartments, controller.onSubDepartmentChanged),
              const SizedBox(height: 16),
              _buildDropdown('Kategori Masalah', controller.selectedCategory, controller.categories, controller.onCategoryChanged),
              const SizedBox(height: 16),
              _buildDropdown('Sub Kategori', controller.selectedSubCategory, controller.subCategories, controller.onSubCategoryChanged),
              const SizedBox(height: 16),
              _buildDropdown('Prioritas', controller.selectedPriority, controller.priorities, controller.onPriorityChanged),
              const SizedBox(height: 16),
              _buildDropdown('Source', controller.selectedPriority, controller.priorities, controller.onPriorityChanged),
              const SizedBox(height: 16),
              _buildTextField(label: 'Subject Masalah', hint: 'problem_summary'),
              const SizedBox(height: 16),
              _buildTextField(label: 'Deskripsi Masalah', hint: 'Jelaskan masalah Anda secara detail...', maxLines: 4),
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
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              fillColor: Colors.white,
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
                borderSide: BorderSide(color: Theme.of(Get.context!).primaryColor, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            hint: const Text('-- PILIH --', style: TextStyle(color: Colors.grey, fontSize: 14)),
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

  Widget _buildTextField({required String label, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
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
              borderSide: BorderSide(color: Theme.of(Get.context!).primaryColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDueDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Due Date'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: const [
              Icon(Icons.calendar_today_outlined, color: Colors.blueGrey, size: 20),
              SizedBox(width: 12),
              Text('24 Nov 2025, 16.04', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text('Default: 3 hari dari sekarang', style: TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  Widget _buildAttachmentPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Lampiran', isRequired: false),
        const SizedBox(height: 8),
        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, color: const Color(0xFF0D47A1), size: 32),
              const SizedBox(height: 8),
              const Text('Klik untuk upload', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              const Text('PNG, JPG, PDF, DOC (MAX. 10MB)', style: TextStyle(color: Colors.grey, fontSize: 11)),
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
              backgroundColor: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Submit Ticket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () { /* TODO: Implement reset form */ },
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5)
            ),
            child: const Text('Reset Form', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ),
      ],
    );
  }
}