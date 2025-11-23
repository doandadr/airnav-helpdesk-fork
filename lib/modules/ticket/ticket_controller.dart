// lib/modules/ticket/ticket_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_model.dart';

class TicketController extends GetxController {
  // Tabs: 0 = My Tickets, 1 = New Ticket (kept for UI parity)
  final tabIndex = 0.obs;
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final tickets = <TicketModel>[].obs;

  // for pull-to-refresh
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    super.onInit();
    // populate dummy tickets
    tickets.assignAll(_dummyTickets);
  }

  List<TicketModel> get filteredTickets {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return tickets;
    return tickets.where((t) {
      return t.code.toLowerCase().contains(q) ||
          t.category.toLowerCase().contains(q) ||
          (t.subCategory ?? '').toLowerCase().contains(q);
    }).toList();
  }

  void setTab(int idx) => tabIndex.value = idx;

  Future<void> refresh() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500)); // simulate
    // nothing changes for offline demo (but could fetch repo)
    isLoading.value = false;
  }

  void openDetail(TicketModel t) {
    // navigate to detail page (create a detail page and binding later)
    Get.toNamed('/ticket/detail', arguments: t.toJson());
  }

  // create a new ticket in-memory
  Future<void> createTicket({
    required String titleCode,
    required String category,
    String? subCategory,
  }) async {
    final newTicket = TicketModel(
      id: DateTime.now().millisecondsSinceEpoch,
      code: titleCode,
      createdAt: DateTime.now().toIso8601String(),
      category: category,
      subCategory: subCategory,
      progress: 0,
      status: 'new',
      statusText: 'new',
    );
    tickets.insert(0, newTicket);
  }
}

/// Dummy data matching UI
final _dummyTickets = <TicketModel>[
  TicketModel(
    id: 1,
    code: 'T20250311W079',
    createdAt: '2025-03-13 12:17:31',
    category: 'NETWORK',
    subCategory: 'VPN & REMOTE ACCESS',
    progress: 100,
    status: 'solved',
    statusText: 'done',
  ),
  TicketModel(
    id: 2,
    code: 'T20250923W393',
    createdAt: '2025-09-23 14:38:23',
    category: 'HARDWARE',
    subCategory: 'PRINTER & SCANNER',
    progress: 100,
    status: 'solved',
    statusText: 'done',
  ),
  TicketModel(
    id: 3,
    code: 'T20250615W456',
    createdAt: '2025-06-15 09:22:15',
    category: 'SOFTWARE',
    subCategory: 'APPLICATION ERROR',
    progress: 50,
    status: 'in_progress',
    statusText: 'in progress',
  ),
  TicketModel(
    id: 4,
    code: 'T20250420W789',
    createdAt: '2025-04-20 16:45:30',
    category: 'HARDWARE',
    subCategory: 'COMPUTER & LAPTOP',
    progress: 50,
    status: 'assigned',
    statusText: 'assigned',
  ),
  TicketModel(
    id: 5,
    code: 'T20250301W123',
    createdAt: '2025-03-01 08:30:45',
    category: 'NETWORK',
    subCategory: 'INTERNET CONNECTION',
    progress: 0,
    status: 'waiting',
    statusText: 'new',
  ),
];
