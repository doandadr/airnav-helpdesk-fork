// Updated Ticket List Page with filtering, sorting, and search
import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:airnav_helpdesk/core/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_list_controller.dart';
import '../widget/ticket_card.dart';

class TicketListPage extends GetView<TicketListController> {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBarWidget(titleText: 'Tiket Saya'),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildTabs(),
          const SizedBox(height: 8),
          SearchField(
            onChanged: controller.onSearch,
            hintText: 'Cari tiket...',
          ),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final list = controller.tickets;
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                itemBuilder: (_, i) => TicketCard(
                  ticket: list[i],
                  activeTab: controller.activeTab.value,
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToNewTicket,
        backgroundColor: const Color(0xFF0D47A1),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
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
            items: const ['', 'Done', 'In Progress', 'Assigned', 'New'],
            onChanged: controller.setStatusFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Priority",
            value: controller.priorityFilter.value,
            items: const ['', 'Critical', 'High', 'Medium', 'Low'],
            onChanged: controller.setPriorityFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Sort",
            value: controller.sortOption.value,
            items: const ['date_desc', 'date_asc', 'priority', 'progress'],
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
        child: Obx(() {
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e.isEmpty ? 'All' : e)))
            .toList(),
        onChanged: (val) => onChanged(val ?? ''),
      );
    }));
  }

  Widget _buildTabs() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.tabs
                  .map((tab) => _tabItem(
                        tab,
                        controller.activeTab.value == tab,
                        () => controller.changeTab(tab),
                      ))
                  .toList(),
            ),
          ),
        ));
  }

  Widget _tabItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: active ? const Color(0xFF135CA1) : const Color(0xFF475569),
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: active ? 30 : 0, // Stretches under the active text
              color: const Color(0xFF135CA1),
            ),
          ],
        ),
      ),
    );
  }
}
