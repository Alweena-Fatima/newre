import 'package:first_app/pages/home/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categories extends StatelessWidget {
  const categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton(text: '5TH SEMESTER ', code: 'FIVE', image: '5th.png'),
          CategoryButton(text: '3RD SEMESTER', code: 'THIRD', image: '5th.png'),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.text, required this.code, required this.image});
  final String text;
  final String code;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Passing the code of the category to the home page cubit
        context.read<HomePageCubit>().chageCategory(code);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Rounded corners for the card
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 84, 141, 127)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5), // Shadow effect
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Round corners for the image
              child: Image.asset(
                image,
                width: 100, // Adjust size of the image
                height: 100, // Adjust size of the image
                fit: BoxFit.cover, // Make the image cover the container
              ),
            ),
            const SizedBox(height: 10), // Space between the image and text
            Text(
              text,
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Make the text color white for contrast
              ),
            ),
          ],
        ),
      ),
    );
  }
}
