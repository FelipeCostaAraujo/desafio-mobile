import 'package:flutter/material.dart';

class FavoriteListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const FavoriteListTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
