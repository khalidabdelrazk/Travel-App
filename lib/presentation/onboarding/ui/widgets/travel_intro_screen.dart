import 'package:flutter/material.dart';
import 'package:travel/core/theme/app_theme.dart';


class TravelIntroScreen extends StatelessWidget {
  final String? backgroundImage;
  final String? title;
  final String? description;
  final String? nextText;
  final String? backText;
  final VoidCallback? onNextPressed;
  final VoidCallback? onBackPressed;
  final Color? color;

  const TravelIntroScreen({
    super.key,
    this.color,
    this.backgroundImage,
    this.title,
    this.description,
    this.nextText,
    this.backText,
    this.onNextPressed,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          if (backgroundImage != null)
            SizedBox.expand(
              child: Image.asset(
                backgroundImage!,
                fit: BoxFit.cover,
              ),
            ),

          /// Overlay content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: color ?? Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: AppTheme.appTextDarkTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  if (description != null) ...[
                    SizedBox(height: 12),
                    Text(
                      description!,
                      style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: 20),

                  /// Buttons
                  Column(
                    children: [
                      if (nextText != null && onNextPressed != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onNextPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              nextText!,
                              style: AppTheme.appTextDarkTheme.bodyMedium,
                            ),
                          ),
                        ),
                      if (backText != null && nextText != null)
                        SizedBox(height: 12),
                      if (backText != null && onBackPressed != null)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: onBackPressed,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.amber, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              backText!,
                              style: AppTheme.appTextDarkTheme.bodyMedium,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}