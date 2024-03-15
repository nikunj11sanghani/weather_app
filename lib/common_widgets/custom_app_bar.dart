import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;

  const CustomAppBar({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: action,
      leading: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.deepPurpleAccent,
          ),
          iconSize: 22,
          constraints: const BoxConstraints(maxHeight: 2),
        ),
      ),
      centerTitle: true,
      title: Text(title,
          style: const TextStyle(
              color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
