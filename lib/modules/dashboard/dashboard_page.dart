import 'package:airnav_helpdesk/modules/dashboard/models/help_request.dart';
import 'package:airnav_helpdesk/modules/dashboard/widgets/request_card.dart';
import 'package:airnav_helpdesk/modules/dashboard/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 72,
        title: const Text(
          'Helpdesk',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person_outline, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Container(height: 4, color: Colors.black, width: double.infinity),
            const SizedBox(height: 14),

            // Availability + period
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Availability Status',
                        style: TextStyle(fontSize: 12, color: Colors.teal),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Obx(() => Switch(
                      value: controller.availability.value,
                      onChanged: controller.setAvailability,
                    )),
                  ],
                ),
                // period dropdown
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.period.value,
                      items: const [
                        DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                        DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                        DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                      ],
                      onChanged: controller.setPeriod,
                    ),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 18),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.4,
              children: const [
                StatCard(icon: Icons.phone_in_talk, label: 'Completed Requests', value: '0'),
                StatCard(icon: Icons.star_border, label: 'Average Rating', value: '0'),
                StatCard(icon: Icons.check_circle_outline, label: 'Completed Requests', value: '0'),
                StatCard(icon: Icons.star_border, label: 'Average Rating', value: '0'),
              ],
            ),

            const SizedBox(height: 18),
            const Text(
              'Recent Help Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.requests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final r = controller.requests[index];
                    return RequestCard(request: r);
                  },
                )),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}