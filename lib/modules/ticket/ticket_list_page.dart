// Updated Ticket List Page with filtering, sorting, and search
import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_list_controller.dart';
import 'widget/ticket_card.dart';

class TicketListPage extends GetView<TicketListController> {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          _buildSearchField(),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final list = controller.tickets;
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                itemBuilder: (_, i) => TicketCard(ticket: list[i]),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToNewTicket,
        child: const Icon(Icons.add),
      ),
    );
  }

  // -----------------------------
  // TABS
  // -----------------------------
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _tabItem('My Tickets', true, () {}),
          const SizedBox(width: 20),
          _tabItem('New Ticket', false, controller.goToNewTicket),
        ],
      ),
    );
  }

  Widget _tabItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: active ? const Color(0xFF135CA1) : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (active)
            Container(
              height: 2,
              width: 60,
              color: const Color(0xFF135CA1),
            )
        ],
      ),
    );
  }

  // -----------------------------
  // SEARCH FIELD
  // -----------------------------
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Material(
        elevation: 2.0,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
        child: TextField(
          onChanged: controller.onSearch,
          decoration: InputDecoration(
            hintText: 'Cari tiket...',
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Color(0xFF135CA1), width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // FILTER BAR (Status, Priority, Sorting)
  // -----------------------------
  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _filterDropdown(
            label: "Status",
            value: controller.statusFilter.value,
            items: const ['','DONE','ON PROCESS','WAITING','NEW'],
            onChanged: controller.setStatusFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Priority",
            value: controller.priorityFilter.value,
            items: const ['','Critical','High','Medium','Low'],
            onChanged: controller.setPriorityFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Sort",
            value: controller.sortOption.value,
            items: const ['date_desc','date_asc','priority','progress'],
            onChanged: controller.setSortOption,
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Expanded(
        child: Obx((){
          final reactiveValue = (label == "Status")
              ? controller.statusFilter.value
              : (label == "Priority")
              ? controller.priorityFilter.value
              : controller.sortOption.value;

          return DropdownButtonFormField<String>(
            isExpanded: true,
            value: reactiveValue.isEmpty ? null : reactiveValue,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF135CA1), width: 1.5),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e.isEmpty ? 'All' : e))).toList(),
            onChanged: (val) => onChanged(val ?? ''),
          );
        })
    );
  }
}