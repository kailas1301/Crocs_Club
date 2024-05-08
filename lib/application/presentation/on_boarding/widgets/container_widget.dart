import 'package:flutter/material.dart';

class ContainerWithImage extends StatelessWidget {
  const ContainerWithImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 146, 144, 144),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const NetworkImage(
              'https://imageplaceholder.net/600'), // Placeholder image
          image: AssetImage(imagePath), // Actual image
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
