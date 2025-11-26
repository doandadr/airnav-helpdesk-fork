import 'package:airnav_helpdesk/modules/ticket/ticket_model.dart';
import 'package:get/get.dart';

class TicketListController extends GetxController {
  // Reactive lists
  RxList<TicketModel> tickets = <TicketModel>[].obs;
  late List<TicketModel> _allTickets;

  // Tabs
  final List<String> tabs = [
    'ticket_tab_list',
    'ticket_tab_waiting_confirm',
    'ticket_tab_waiting_assign',
  ];
  RxString activeTab = 'ticket_tab_list'.obs;

  // Search & filters
  RxString keyword = ''.obs;
  RxString statusFilter = ''.obs; // Done, In Progress, Assigned, New
  RxString priorityFilter = ''.obs; // Critical, High, Medium, Low
  RxString sortOption =
      'date_desc'.obs; // date_desc, date_asc, priority, progress

  @override
  void onInit() {
    super.onInit();
    loadDummyTickets();
  }

  // -----------------------------
  // TABS
  // -----------------------------
  void changeTab(String tab) {
    activeTab.value = tab;
    // When changing tabs, we might want to reset other filters
    statusFilter.value = '';
    _applyFilters();
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
    Get.toNamed('/ticket/add');
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
        status: 'Done',
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
        status: 'Done',
        priority: 'Low',
        lastUpdate: '26 Sep 2025, 14.38',
        lastUpdateStatus: 'Done',
      ),
      TicketModel(
        code: 'T20250615W456',
        title: 'Aplikasi ArsipKu error saat login',
        date: '2025-06-15 09:22:15',
        category: 'SOFTWARE',
        subCategory: 'APPLICATION ERROR',
        progress: 50,
        status: 'In Progress',
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
        status: 'In Progress',
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
        status: 'Assigned',
        priority: 'Critical',
        lastUpdate: '04 Mar 2025, 08.30',
        lastUpdateStatus: 'New',
      ),
      TicketModel(
        code: 'T20250721W881',
        title: 'Email tidak bisa mengirim lampiran',
        date: '2025-07-21 10:00:00',
        category: 'SOFTWARE',
        subCategory: 'EMAIL CLIENT',
        progress: 0,
        status: 'Assigned',
        priority: 'High',
        lastUpdate: '22 Jul 2025, 10.00',
        lastUpdateStatus: 'New',
      ),
      TicketModel(
        code: 'T20250815W902',
        title: 'Monitor mati total',
        date: '2025-08-15 13:30:00',
        category: 'HARDWARE',
        subCategory: 'MONITOR',
        progress: 0,
        status: 'Assigned',
        priority: 'Medium',
        lastUpdate: '16 Aug 2025, 13.30',
        lastUpdateStatus: 'New',
      ),
      TicketModel(
        code: 'T20251005W555',
        title: 'Tidak bisa akses shared folder',
        date: '2025-10-05 11:05:00',
        category: 'NETWORK',
        subCategory: 'FILE SHARING',
        progress: 0,
        status: 'New',
        priority: 'Medium',
        lastUpdate: '05 Oct 2025, 11.05',
        lastUpdateStatus: 'New',
      ),
      TicketModel(
        code: 'T20251006W621',
        title: 'Request install software design',
        date: '2025-10-06 09:15:12',
        category: 'SOFTWARE',
        subCategory: 'INSTALLATION',
        progress: 0,
        status: 'New',
        priority: 'Low',
        lastUpdate: '06 Oct 2025, 09.15',
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

    // --- TAB FILTER ---
    switch (activeTab.value) {
      case 'ticket_tab_waiting_confirm':
        result = result.where((t) => t.status == 'Assigned').toList();
        break;
      case 'ticket_tab_waiting_assign':
        result = result.where((t) => t.status == 'New').toList();
        break;
      case 'ticket_tab_list':
      default:
        // No additional filtering
        break;
    }

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
        const prioOrder = {'Critical': 4, 'High': 3, 'Medium': 2, 'Low': 1};
        result.sort(
          (a, b) => prioOrder[b.priority]!.compareTo(prioOrder[a.priority]!),
        );
        break;
    }

    tickets.assignAll(result);
  }
}
