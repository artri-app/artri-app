import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReferenceLinkText extends StatelessWidget {
  final String text;
  final String url;

  const ReferenceLinkText({
    super.key,
    required this.text,
    required this.url,
  });

  Future<void> _openLink() async {
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openLink,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}