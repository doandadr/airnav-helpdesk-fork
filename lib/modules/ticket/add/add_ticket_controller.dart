import 'package:airnav_helpdesk/modules/dashboard/dashboard_controller.dart';
import 'package:airnav_helpdesk/modules/dashboard/models/help_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTicketController extends GetxController {
  // Dropdown values
  final Rxn<String> selectedDepartment = Rxn<String>();
  final Rxn<String> selectedSubDepartment = Rxn<String>();
  final Rxn<String> selectedCategory = Rxn<String>();
  final Rxn<String> selectedSubCategory = Rxn<String>();
  final Rxn<String> selectedPriority = Rxn<String>();

  // Text Controllers
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Dropdown items - using dummy data for now
  final List<String> departments = ['IT', 'HR', 'Finance', 'Teknik'];
  final List<String> subDepartments = ['Jaringan', 'Software', 'Hardware'];
  final List<String> categories = ['Permintaan', 'Insiden'];
  final List<String> subCategories = ['Akses Wifi', 'Kerusakan Printer'];
  final List<String> priorities = ['Low', 'Medium', 'High', 'Urgent'];

  void onDepartmentChanged(String? value) {
    selectedDepartment.value = value;
    // You might want to reset or filter sub-departments here
    selectedSubDepartment.value = null;
  }

  void onSubDepartmentChanged(String? value) {
    selectedSubDepartment.value = value;
  }

  void onCategoryChanged(String? value) {
    selectedCategory.value = value;
    // You might want to reset or filter sub-categories here
    selectedSubCategory.value = null;
  }

  void onSubCategoryChanged(String? value) {
    selectedSubCategory.value = value;
  }

  void onPriorityChanged(String? value) {
    selectedPriority.value = value;
  }

  void submitTicket() {
    if (selectedDepartment.value != null &&
        selectedCategory.value != null &&
        selectedPriority.value != null &&
        subjectController.text.isNotEmpty) {
      // Find DashboardController to add the new request
      // In a real app, this might be handled by a repository or service
      try {
        final dashboardController = Get.find<DashboardController>();

        final newRequest = HelpRequest(
          name: 'Current User', // Mock user
          title: subjectController.text,
          date: 'Just now',
          responseDue: 'Response due in 24 hours',
          tags: [
            selectedPriority.value!,
            '${selectedDepartment.value} / ${selectedSubDepartment.value ?? "General"}',
          ],
          status: 'Open',
          highlight: 'NEW',
          description: descriptionController.text,
        );

        dashboardController.requests.insert(0, newRequest);

        Get.snackbar(
          'Success',
          'Ticket submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear form
        _clearForm();

        // Navigate back
        Get.back();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Could not submit ticket. Dashboard controller not found.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill all required fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _clearForm() {
    selectedDepartment.value = null;
    selectedSubDepartment.value = null;
    selectedCategory.value = null;
    selectedSubCategory.value = null;
    selectedPriority.value = null;
    subjectController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
