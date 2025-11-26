import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_bar_widget.dart';
import '../ticket_model.dart';
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
            _ticketSection(),
            const SizedBox(height: 16),
            _assigneeSection(),
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

  Widget _ticketSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.confirmation_num),
                  const SizedBox(width: 8),
                  Text('select_ticket'.tr),
                ],
              ),
              Text(
                '${controller.selectedTicketCodes.length} ${'selected_count'.tr}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (v) => controller.ticketSearch.value = v,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'search_ticket_hint'.tr,
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
            itemBuilder: (_, i) => _ticketItem(controller.filteredTickets[i]),
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: controller.filteredTickets.length,
          ),
        ],
      ),
    );
  }

  Widget _ticketItem(TicketModel ticket) {
    final selected = controller.selectedTicketCodes.contains(ticket.code);
    return InkWell(
      onTap: () => controller.toggleTicketSelection(ticket.code),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          // Add a blue border when selected for better visual feedback
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox is removed, the whole card is now the tap area.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.code,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(ticket.title),
                  const SizedBox(height: 8),
                  Text(
                    ticket.category,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _actionBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              controller.selectedTicketCodes.clear();
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
