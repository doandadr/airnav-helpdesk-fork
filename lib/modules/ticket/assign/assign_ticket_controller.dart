import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ticket_model.dart';

class Assignee {
  final String id;
  final String name;
  final String department;
  final String avatarUrl;
  final bool available;
  final int activeTickets;

  Assignee({
    required this.id,
    required this.name,
    required this.department,
    this.avatarUrl = '',
    this.available = true,
    this.activeTickets = 0,
  });
}

class AssignTicketController extends GetxController {
  // Selected ticket from navigation
  late final TicketModel selectedTicket;

  // Assignees
  RxList<Assignee> assignees = <Assignee>[].obs;
  RxSet<String> selectedAssigneeIds = <String>{}.obs;

  // form fields
  RxString note = ''.obs;
  Rxn<DateTime> dueDate = Rxn<DateTime>();

  // search
  RxString assigneeSearch = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedTicket = Get.arguments as TicketModel;
    _loadStubData();
  }

  void _loadStubData() {
    assignees.assignAll([
      Assignee(
        id: '1',
        name: 'Budi Santoso',
        department: 'IT Support',
        activeTickets: 3,
      ),
      Assignee(
        id: '2',
        name: 'Ahmad Fauzi',
        department: 'IT Support',
        activeTickets: 2,
      ),
      Assignee(
        id: '3',
        name: 'Dewi Lestari',
        department: 'IT Infrastructure',
        activeTickets: 1,
      ),
    ]);
  }

  // UI helpers
  List<Assignee> get filteredAssignees {
    final q = assigneeSearch.value.trim().toLowerCase();
    if (q.isEmpty) return assignees;
    return assignees
        .where(
          (a) =>
              a.name.toLowerCase().contains(q) ||
              a.department.toLowerCase().contains(q),
        )
        .toList();
  }

  // selection
  void pickAssignee(Assignee a) {
    if (selectedAssigneeIds.contains(a.id)) {
      selectedAssigneeIds.remove(a.id);
    } else {
      selectedAssigneeIds.add(a.id);
    }
  }

  void setNote(String v) => note.value = v;
  void setDueDate(DateTime d) => dueDate.value = d;

  // action: assign (mock)
  Future<void> assignSelected() async {
    if (selectedAssigneeIds.isEmpty) {
      Get.snackbar(
        'assign_ticket_title'.tr,
        'assign_error_no_assignee'.tr,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      return;
    }

    // mock API latency
    Get.snackbar(
      'assign_ticket_title'.tr,
      'assign_progress'.tr,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
    await Future.delayed(const Duration(seconds: 1));

    // Get assignee names for display
    final assigneeNames = assignees
        .where((a) => selectedAssigneeIds.contains(a.id))
        .map((a) => a.name)
        .join(', ');

    // mock notification
    Get.snackbar(
      'assign_ticket_title'.tr,
      'assign_success'.tr
          .replaceAll('{code}', selectedTicket.code)
          .replaceAll('{assignees}', assigneeNames),
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );

    // Go back after assigning
    Get.back();
  }
}
