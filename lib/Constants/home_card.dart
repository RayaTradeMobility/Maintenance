import 'package:flutter/material.dart';

class HomeCart extends StatelessWidget {
  const HomeCart({
    Key? key,
    required this.image,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.grey,
      color: Colors.white.withOpacity(0.7),
      elevation: 19.0,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
