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
  Rxn<Assignee> selectedAssignee = Rxn<Assignee>();

  // form fields
  RxString note = ''.obs;
  RxString priority = 'Medium'.obs;
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
    if (selectedAssignee.value?.id == a.id) {
      selectedAssignee.value = null;
    } else {
      selectedAssignee.value = a;
    }
  }

  void setNote(String v) => note.value = v;
  void setPriority(String v) => priority.value = v;
  void setDueDate(DateTime d) => dueDate.value = d;

  // action: assign (mock)
  Future<void> assignSelected() async {
    if (selectedAssignee.value == null) {
      Get.snackbar('Assign', 'Pilih assignee terlebih dahulu');
      return;
    }

    // mock API latency
    Get.snackbar('Assign', 'Assigning...');
    await Future.delayed(const Duration(seconds: 1));

    // mock notification
    Get.snackbar(
      'Assign',
      'Assigned ticket ${selectedTicket.code} to ${selectedAssignee.value!.name}',
    );

    // Go back after assigning
    Get.back();
  }
}
