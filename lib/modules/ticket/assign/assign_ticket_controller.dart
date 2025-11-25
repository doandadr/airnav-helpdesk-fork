import 'package:get/get.dart';

import '../list/ticket_list_controller.dart';
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
  // Tickets to pick from (for simplicity reuse TicketModel)
  RxList<TicketModel> tickets = <TicketModel>[].obs;
  RxSet<String> selectedTicketCodes = <String>{}.obs;

  // Assignees
  RxList<Assignee> assignees = <Assignee>[].obs;
  Rxn<Assignee> selectedAssignee = Rxn<Assignee>();

  // form fields
  RxString note = ''.obs;
  RxString priority = 'Medium'.obs;
  Rxn<DateTime> dueDate = Rxn<DateTime>();

  // search
  RxString ticketSearch = ''.obs;
  RxString assigneeSearch = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStubData();
  }

  void _loadStubData() {
    // populate from TicketListController if available
    try {
      final tctrl = Get.find<TicketListController>();
      tickets.assignAll(tctrl.tickets);
    } catch (_) {
      // fallback - create small stubs
      tickets.assignAll([
        TicketModel(
          code: 'T20250301W123',
          title: 'Koneksi internet lambat',
          date: '2025-03-01 08:30:45',
          category: 'NETWORK',
          subCategory: 'INTERNET CONNECTION',
          progress: 0,
          status: 'NEW',
          priority: 'Critical',
          lastUpdate: '04 Mar 2025, 08.30',
          lastUpdateStatus: 'New',
        ),
        TicketModel(
          code: 'T20250302W124',
          title: 'Printer tidak bisa print',
          date: '2025-03-02 10:15:00',
          category: 'HARDWARE',
          subCategory: 'PRINTER & SCANNER',
          progress: 0,
          status: 'NEW',
          priority: 'Medium',
          lastUpdate: '02 Mar 2025, 10.15',
          lastUpdateStatus: 'New',
        ),
      ]);
    }

    assignees.assignAll([
      Assignee(id: '1', name: 'Budi Santoso', department: 'IT Support', activeTickets: 3),
      Assignee(id: '2', name: 'Ahmad Fauzi', department: 'IT Support', activeTickets: 2),
      Assignee(id: '3', name: 'Dewi Lestari', department: 'IT Infrastructure', activeTickets: 1),
    ]);
  }

  // UI helpers
  List<TicketModel> get filteredTickets {
    final q = ticketSearch.value.trim().toLowerCase();
    if (q.isEmpty) return tickets;
    return tickets.where((t) {
      return t.code.toLowerCase().contains(q) ||
          t.title.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q) ||
          t.subCategory.toLowerCase().contains(q);
    }).toList();
  }

  List<Assignee> get filteredAssignees {
    final q = assigneeSearch.value.trim().toLowerCase();
    if (q.isEmpty) return assignees;
    return assignees.where((a) => a.name.toLowerCase().contains(q) || a.department.toLowerCase().contains(q)).toList();
  }

  // selection
  void toggleTicketSelection(String code) {
    if (selectedTicketCodes.contains(code)) {
      selectedTicketCodes.remove(code);
    } else {
      selectedTicketCodes.add(code);
    }
  }

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
    if (selectedTicketCodes.isEmpty) {
      Get.snackbar('Assign', 'Pilih minimal 1 ticket first');
      return;
    }
    if (selectedAssignee.value == null) {
      Get.snackbar('Assign', 'Pilih assignee terlebih dahulu');
      return;
    }

    // mock API latency
    Get.snackbar('Assign', 'Assigning...');
    await Future.delayed(const Duration(seconds: 1));

    // update local ticket statuses
    // for (final code in selectedTicketCodes) {
    //   final tIndex = tickets.indexWhere((t) => t.code == code);
    //   if (tIndex != -1) {
    //     final t = tickets[tIndex];
    //     tickets[tIndex] = t.copyWith(status: 'ASSIGNED');
    //   }
    // }

    // mock notification
    Get.snackbar('Assign', 'Assigned ${selectedTicketCodes.length} ticket(s) to ${selectedAssignee.value!.name}');

    // clear selections but stay on page
    selectedTicketCodes.clear();
    selectedAssignee.value = null;
    note.value = '';
    priority.value = 'Medium';
    dueDate.value = null;
  }
}
