import 'package:flutter/material.dart';

import '../ticket_model.dart';

class TicketCard extends StatelessWidget {
  final TicketModel ticket;
  const TicketCard({super.key, required this.ticket});

  Color _statusColor(String status) {
    switch (status) {
      case 'DONE':
        return Colors.green.shade100;
      case 'ON PROCESS':
        return Colors.blue.shade100;
      case 'ASSIGNED':
        return Colors.yellow.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red.shade100;
      case 'High':
        return Colors.orange.shade100;
      case 'Medium':
        return Colors.yellow.shade100;
      case 'Low':
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(ticket.code,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(ticket.status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(ticket.status,
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey.shade800)),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _priorityColor(ticket.priority),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(ticket.priority,
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey.shade800)),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(ticket.title,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600)),

          const SizedBox(height: 12),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kategori',
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(ticket.category,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sub Kategori',
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(ticket.subCategory,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Progres',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('${ticket.progress}%',
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ticket.progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: ticket.progress == 100
                      ? Colors.green
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(ticket.lastUpdate,
                  style:
                  TextStyle(fontSize: 10, color: Colors.grey.shade600)),
            ],
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF175fa4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: const Text('Lihat Detail',
                  style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}