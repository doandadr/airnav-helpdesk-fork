import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Widget? leading;
  const AppBarWidget({
    super.key,
    required this.titleText,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D47A1),
      elevation: 0,
      toolbarHeight: 80,
      leading: leading,
      title: Row(
        children: [
          // Image.asset('assets/logo.png', height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                titleText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Helpdesk AIRNAV',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              splashRadius: 24,
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
