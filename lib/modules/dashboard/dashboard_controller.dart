import 'package:airnav_helpdesk/modules/dashboard/models/help_request.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // State variables
  var availability = false.obs;
  var period = 'Monthly'.obs;

  // Data
  final RxList<HelpRequest> requests = <HelpRequest>[
    HelpRequest(
      name: 'Fauziman',
      title: 'Wifi not working.',
      date: 'Nov 28',
      responseDue: 'Response due in 5 hours',
      tags: ['Urgent', 'Direktorat Teknik / Abdul Aziz'],
      status: 'Open',
      highlight: 'NEW',
    ),
    HelpRequest(
      name: 'Fauziman',
      title: 'Wifi not working.',
      date: 'Nov 28',
      responseDue: 'Response due in 5 hours',
      tags: ['Urgent', 'Direktorat Teknik / Abdul Aziz'],
      status: 'Open',
      highlight: 'OVERDUE',
    ),
    HelpRequest(
      name: 'Fauziman',
      title: 'Wifi not working.',
      date: 'Nov 28',
      responseDue: 'Response due in 5 hours',
      tags: ['Urgent', 'Direktorat Teknik / Abdul Aziz'],
      status: 'Open',
      highlight: 'NEW',
    ),
  ].obs;

  // Methods to update state
  void setAvailability(bool value) {
    availability.value = value;
  }

  void setPeriod(String? value) {
    if (value != null) {
      period.value = value;
    }
  }
}
