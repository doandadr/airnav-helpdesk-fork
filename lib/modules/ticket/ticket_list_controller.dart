import 'package:airnav_helpdesk/modules/ticket/ticket_model.dart';
import 'package:get/get.dart';

class TicketListController extends GetxController {
  // Reactive lists
  RxList<TicketModel> tickets = <TicketModel>[].obs;
  late List<TicketModel> _allTickets;

  // Search & filters
  RxString keyword = ''.obs;
  RxString statusFilter = ''.obs;      // DONE, ON PROCESS, ASSIGNED, NEW
  RxString priorityFilter = ''.obs;    // Critical, High, Medium, Low
  RxString sortOption = 'date_desc'.obs; // date_desc, date_asc, priority, progress

  @override
  void onInit() {
    super.onInit();
    loadDummyTickets();
  }

  // -----------------------------
  // SEARCH
  // -----------------------------
  void onSearch(String value) {
    keyword.value = value.toLowerCase().trim();
    _applyFilters();
  }

  // -----------------------------
  // FILTERS
  // -----------------------------
  void setStatusFilter(String value) {
    statusFilter.value = value;
    _applyFilters();
  }

  void setPriorityFilter(String value) {
    priorityFilter.value = value;
    _applyFilters();
  }

  // -----------------------------
  // SORTING
  // -----------------------------
  void setSortOption(String value) {
    sortOption.value = value;
    _applyFilters();
  }

  // -----------------------------
  // NAVIGATION (placeholder)
  // -----------------------------
  void goToNewTicket() {
    Get.snackbar('Navigation', 'Go to new ticket page (to be implemented)');
  }

  // -----------------------------
  // LOAD DUMMY DATA
  // -----------------------------
  void loadDummyTickets() {
    final list = [
      TicketModel(
        code: 'T20250311W079',
        title: 'Tidak bisa connect ke VPN kantor',
        date: '2025-03-13 12:17:31',
        category: 'NETWORK',
        subCategory: 'VPN & REMOTE ACCESS',
        progress: 100,
        status: 'DONE',
        priority: 'Medium',
        lastUpdate: '16 Mar 2025, 12.17',
        lastUpdateStatus: 'Done',
      ),
      TicketModel(
        code: 'T20250923W393',
        title: 'Printer tidak bisa print warna',
        date: '2025-09-23 14:38:23',
        category: 'HARDWARE',
        subCategory: 'PRINTER & SCANNER',
        progress: 100,
        status: 'DONE',
        priority: 'Low',
        lastUpdate: '26 Sep 2025, 14.38',
        lastUpdateStatus: 'Done',
      ),
      TicketModel(
        code: 'T20250615W456',
        title: 'Aplikasi ERP error saat login',
        date: '2025-06-15 09:22:15',
        category: 'SOFTWARE',
        subCategory: 'APPLICATION ERROR',
        progress: 50,
        status: 'ON PROCESS',
        priority: 'High',
        lastUpdate: '18 Jun 2025, 09.22',
        lastUpdateStatus: 'In Progress',
      ),
      TicketModel(
        code: 'T20250420W789',
        title: 'Laptop lemot dan sering hang',
        date: '2025-04-20 16:45:30',
        category: 'HARDWARE',
        subCategory: 'COMPUTER & LAPTOP',
        progress: 50,
        status: 'ON PROCESS',
        priority: 'Medium',
        lastUpdate: '23 Apr 2025, 16.45',
        lastUpdateStatus: 'Assigned',
      ),
      TicketModel(
        code: 'T20250301W123',
        title: 'Internet kantor sangat lambat',
        date: '2025-03-01 08:30:45',
        category: 'NETWORK',
        subCategory: 'INTERNET CONNECTION',
        progress: 0,
        status: 'ASSIGNED',
        priority: 'Critical',
        lastUpdate: '04 Mar 2025, 08.30',
        lastUpdateStatus: 'New',
      ),
    ];

    _allTickets = list;
    _applyFilters();
  }

  // -----------------------------
  // FILTERING + SORTING PIPELINE
  // -----------------------------
  void _applyFilters() {
    List<TicketModel> result = List.from(_allTickets);

    // --- SEARCH ---
    if (keyword.isNotEmpty) {
      final q = keyword.value;
      result = result.where((t) {
        return t.code.toLowerCase().contains(q) ||
            t.title.toLowerCase().contains(q) ||
            t.category.toLowerCase().contains(q) ||
            t.subCategory.toLowerCase().contains(q) ||
            t.priority.toLowerCase().contains(q) ||
            t.status.toLowerCase().contains(q);
      }).toList();
    }

    // --- STATUS FILTER ---
    if (statusFilter.isNotEmpty) {
      result = result.where((t) => t.status == statusFilter.value).toList();
    }

    // --- PRIORITY FILTER ---
    if (priorityFilter.isNotEmpty) {
      result = result.where((t) => t.priority == priorityFilter.value).toList();
    }

    // --- SORTING ---
    switch (sortOption.value) {
      case 'date_asc':
        result.sort((a, b) => a.date.compareTo(b.date));
        break;
      case 'date_desc':
        result.sort((a, b) => b.date.compareTo(a.date));
        break;
      case 'progress':
        result.sort((a, b) => b.progress.compareTo(a.progress));
        break;
      case 'priority':
        const prioOrder = {
          'Critical': 4,
          'High': 3,
          'Medium': 2,
          'Low': 1,
        };
        result.sort((a, b) => prioOrder[b.priority]!.compareTo(prioOrder[a.priority]!));
        break;
    }

    tickets.assignAll(result);
  }
}