import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/app_bar_widget.dart';
import 'assign_ticket_controller.dart';

class AssignTicketPage extends GetView<AssignTicketController> {
  const AssignTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: 'assign_ticket_title'.tr,
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const SizedBox(height: 12),
            _ticketInfoSection(),
            const SizedBox(height: 16),
            _assigneeSection(),
            const SizedBox(height: 16),
            _detailsSection(context),
            const SizedBox(height: 16),
            _prioritySection(),
            const SizedBox(height: 20),
            _actionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.assignment_ind)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'assign_ticket_title'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'assign_ticket_subtitle'.tr,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.confirmation_num),
            const SizedBox(width: 8),
            Text('ticket'.tr),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.selectedTicket.code,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                controller.selectedTicket.title,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'label_category'.tr,
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.selectedTicket.category,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'priority_label'.tr,
                          style: TextStyle(
                            fontSize: 11,
                            color: Get.theme.textTheme.bodySmall?.color,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          controller.selectedTicket.priority,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _assigneeSection() {
    return Obx(() {
      // Make Obx reactive to selectedAssignee
      controller.selectedAssignee.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(width: 8),
              Text('select_assignee'.tr),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (v) => controller.assigneeSearch.value = v,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'search_assignee_hint'.tr,
              filled: true,
              fillColor:
                  Get.theme.inputDecorationTheme.fillColor ??
                  Get.theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, i) =>
                _assigneeItem(controller.filteredAssignees[i]),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: controller.filteredAssignees.length,
          ),
        ],
      );
    });
  }

  Widget _assigneeItem(Assignee a) {
    final selected = controller.selectedAssignee.value?.id == a.id;
    return InkWell(
      onTap: () => controller.pickAssignee(a),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade200,
          ),
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(child: Text(a.name.substring(0, 1))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    a.department,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (a.available)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('available'.tr),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('busy'.tr),
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            Text('due_date'.tr),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() {
          final date = controller.dueDate.value;
          return InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                controller.setDueDate(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
                color:
                    Get.theme.inputDecorationTheme.fillColor ??
                    Get.theme.cardColor,
              ),
              child: Row(
                children: [
                  Text(
                    date != null
                        ? DateFormat('dd MMM yyyy').format(date)
                        : 'select_date_hint'.tr,
                    style: TextStyle(
                      color: date != null
                          ? Get.theme.textTheme.bodyMedium?.color
                          : Get.theme.hintColor,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.calendar_month, color: Colors.grey),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _prioritySection() {
    final priorities = ['Low', 'Medium', 'High', 'Critical'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.flag),
            const SizedBox(width: 8),
            Text('priority_label'.tr),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
              color:
                  Get.theme.inputDecorationTheme.fillColor ??
                  Get.theme.cardColor,
            ),
            child: DropdownButton<String>(
              value: controller.priority.value,
              isExpanded: true,
              underline: const SizedBox(),
              items: priorities.map((String priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(
                    'priority_${priority.toLowerCase()}'.tr,
                    style: TextStyle(
                      color: Get.theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.setPriority(newValue);
                }
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _actionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              controller.selectedAssignee.value = null;
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red.shade700,
              backgroundColor: Colors.red.shade50,
              side: BorderSide(color: Colors.red.shade200),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('reset'.tr),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.assignSelected,
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('assign_button'.tr),
          ),
        ),
      ],
    );
  }
}
