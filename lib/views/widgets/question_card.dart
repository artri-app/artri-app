import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  // final String answer;
  // final VoidCallback onPressed;
  // final VoidCallback onVerify;
  // final VoidCallback onDeny;
  final IconData leadingIcon;

  const QuestionCard({
    super.key,
    required this.question,
    // required this.answer,
    // required this.onPressed,
    // required this.onVerify,
    // required this.onDeny,
    this.leadingIcon = Icons.help_outline, // Default leading icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      elevation: 4,
      color: Colors.white, // Background color
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxWidth: 400, // Adjust based on your needs
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading icon
              Icon(
                leadingIcon,
                size: 32,
                color: Colors.blueGrey[700],
              ),
              const SizedBox(width: 16),

              // Question and Answer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.green[700],
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red[700],
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
