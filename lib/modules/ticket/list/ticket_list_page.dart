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
      appBar: AppBarWidget(
        titleText: 'my_tickets'.tr,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,

          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),

          labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),

          indicatorColor: Colors.white,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,

          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.all(Colors.transparent),

          tabs: controller.tabs.map((tab) => Tab(text: tab.tr)).toList(),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              pinned: false,
              floating: true,
              toolbarHeight: 140,
              flexibleSpace: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    SearchField(
                      onChanged: controller.onSearch,
                      hintText: 'search_ticket_hint'.tr,
                    ),
                    _buildFilterBar(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: controller.tabs.map((tabName) {
            return Obx(() {
              final list = controller.getTicketsForTab(tabName);
              // Using ListView.builder with physics that works with NestedScrollView
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: list.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 0,
                    bottom: index == list.length - 1 ? 12 : 0,
                  ),
                  child: TicketCard(ticket: list[index], activeTab: tabName),
                ),
              );
            });
          }).toList(),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
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

        return Container(
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Get.theme.shadowColor.withOpacity(
                  Get.isDarkMode ? 0.15 : 0.04,
                ),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: PopupMenuButton<String>(
            offset: const Offset(0, 50),
            color: Get.theme.cardColor,
            onSelected: onChanged,
            itemBuilder: (context) {
              return items.map((itemValue) {
                return PopupMenuItem<String>(
                  value: itemValue,
                  child: Text(
                    _getLocalizedValue(itemValue, label),
                    style: GoogleFonts.montserrat(),
                  ),
                );
              }).toList();
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Get.theme.hintColor,
                ),
                floatingLabelStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Get.theme.hintColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor,
                    width: 1.5,
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
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
                      style: GoogleFonts.montserrat(
                        color: Get.theme.textTheme.bodyLarge?.color,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: Get.theme.hintColor,
                  ),
                ],
              ),
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
}
