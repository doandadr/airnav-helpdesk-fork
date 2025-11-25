import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/search_field.dart';
import 'faq_controller.dart';

class FaqPage extends GetView<FaqController> {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(
        titleText: 'FAQ',
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          // Search Bar
          SearchField(onChanged: controller.onSearch, hintText: 'Cari FAQ...'),
          // Filter Tabs
          Container(
            color: Get.theme.cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: _buildFilterTabs(),
          ),
          // FAQ List
          Expanded(
            child: Obx(() {
              final items = controller.filteredFaqItems;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildFaqItem(items[index], index);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.categories.map((category) {
            final isSelected = controller.selectedCategory.value == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? Get.theme.colorScheme.onPrimary
                        : Get.theme.textTheme.bodyLarge?.color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    controller.selectCategory(category);
                  }
                },
                backgroundColor: Get.isDarkMode
                    ? Colors.grey[800]
                    : Colors.grey[200],
                selectedColor: Get.theme.colorScheme.primary,
                checkmarkColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Get.theme.colorScheme.primary
                        : Colors.transparent,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildFaqItem(FaqItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Get.theme.dividerColor, width: 1.5),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: PageStorageKey<int>(index),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            item.question,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Get.theme.textTheme.bodyLarge?.color,
              height: 1.4,
            ),
          ),
          trailing: Icon(
            item.isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: Colors.teal[400],
            size: 28,
          ),
          onExpansionChanged: (expanded) {
            controller.togglePanel(index);
          },
          initiallyExpanded: item.isExpanded,
          children: [
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Get.theme.textTheme.bodyMedium?.color,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
