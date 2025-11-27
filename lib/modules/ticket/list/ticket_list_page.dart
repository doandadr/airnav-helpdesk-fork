import 'package:airnav_helpdesk/core/config/app_pages.dart';
import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:airnav_helpdesk/core/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ticket_list_controller.dart';
import '../widget/ticket_card.dart';

class TicketListPage extends StatefulWidget {
  const TicketListPage({super.key});

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage>
    with SingleTickerProviderStateMixin {
  late final TicketListController controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TicketListController>();
    _tabController = TabController(vsync: this, length: controller.tabs.length);

    // Syncs TabController (swipe/tap) -> GetX controller
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newIndex = _tabController.index;
        if (controller.activeTab.value != controller.tabs[newIndex]) {
          controller.changeTab(controller.tabs[newIndex]);
        }
      }
    });

    // Syncs GetX controller -> TabController
    // Ensures UI updates if the state is changed from elsewhere
    ever(controller.activeTab, (String activeTab) {
      final newIndex = controller.tabs.indexOf(activeTab);
      if (newIndex != -1 && _tabController.index != newIndex) {
        _tabController.animateTo(newIndex);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(titleText: 'my_tickets'.tr),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildTabs(),
          const SizedBox(height: 8),
          SearchField(
            onChanged: controller.onSearch,
            hintText: 'search_ticket_hint'.tr,
          ),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: controller.tabs.map((tabName) {
                return Obx(() {
                  final list = controller.getTicketsForTab(tabName);
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    itemBuilder: (_, i) => TicketCard(
                      ticket: list[i],
                      activeTab: tabName,
                    ),
                  );
                });
              }).toList(),
            ),
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

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _filterDropdown(
            label: "filter_status".tr,
            value: controller.statusFilter.value,
            items: const ['', 'Done', 'In Progress', 'Assigned', 'New'],
            onChanged: controller.setStatusFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "filter_priority".tr,
            value: controller.priorityFilter.value,
            items: const ['', 'Critical', 'High', 'Medium', 'Low'],
            onChanged: controller.setPriorityFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "filter_sort".tr,
            value: controller.sortOption.value,
            items: const ['', 'date_desc', 'date_asc', 'priority', 'progress'],
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
        final reactiveValue = (label == "filter_status".tr)
            ? controller.statusFilter.value
            : (label == "filter_priority".tr)
                ? controller.priorityFilter.value
                : controller.sortOption.value;

        return PopupMenuButton<String>(
          offset: const Offset(0, 50), // This provides the vertical offset
          color: Colors.white, // Set dropdown menu color to white
          onSelected: onChanged,
          itemBuilder: (context) {
            return items.map((itemValue) {
              return PopupMenuItem<String>(
                value: itemValue,
                child: Text(_getLocalizedValue(itemValue, label)),
              );
            }).toList();
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 14),
              floatingLabelStyle: const TextStyle(fontSize: 16),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                borderSide: const BorderSide(
                  color: Color(0xFF135CA1),
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Colors.white, // Set field color to white
            ),
            isEmpty: reactiveValue.isEmpty,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    reactiveValue.isEmpty
                        ? ''
                        : _getLocalizedValue(reactiveValue, label),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getLocalizedValue(String value, String label) {
    // The "All" option has an empty string value.
    if (value.isEmpty) return 'status_all'.tr;

    // For other values, find the correct translation.
    if (label == 'filter_status'.tr) {
      switch (value) {
        case 'Done':
          return 'status_done'.tr;
        case 'In Progress':
          return 'status_in_progress'.tr;
        case 'Assigned':
          return 'status_assigned'.tr;
        case 'New':
          return 'status_new'.tr;
      }
    } else if (label == 'filter_priority'.tr) {
      switch (value) {
        case 'Critical':
          return 'priority_critical'.tr;
        case 'High':
          return 'priority_high'.tr;
        case 'Medium':
          return 'priority_medium'.tr;
        case 'Low':
          return 'priority_low'.tr;
      }
    } else if (label == 'filter_sort'.tr) {
      switch (value) {
        case 'date_desc':
          return 'sort_date_desc'.tr;
        case 'date_asc':
          return 'sort_date_asc'.tr;
        case 'priority':
          return 'sort_priority'.tr;
        case 'progress':
          return 'sort_progress'.tr;
      }
    }
    // Fallback if no match is found
    return value;
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,

        // TEXT STYLE
        labelColor: const Color(0xFF135CA1),
        unselectedLabelColor: const Color(0xFF475569),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),

        // PADDING agar tab tidak tinggi
        labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

        // INDICATOR SLIDING BIRU
        indicatorColor: const Color(0xFF135CA1),
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,

        // Remove ripple/splash biar smooth
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        // MENAMPILKAN TAB SESUAI NAMA
        tabs: controller.tabs.map((tab) => Tab(text: tab.tr)).toList(),
      ),
    );
  }
}
