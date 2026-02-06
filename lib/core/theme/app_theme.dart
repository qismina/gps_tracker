import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Colors
  static const Color primaryPurple = Color(0xFF705196);
  static const Color white = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  
  static const Color textDark = Color(0xFF2D3748);
  static const Color textMedium = Color(0xFF4A5568);
  static const Color textLight = Color(0xFF718096);
  static const Color textGrey = Color(0xFF9E9E9E);
  
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFFF6B6B);
  static const Color warningOrange = Color(0xFFFFA726);
  
  static const Color cardBackground = Colors.white;
  static const Color dividerColor = Color(0xFFE2E8F0);
  
  // Text Styles
  static const TextStyle appTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textDark,
    letterSpacing: -0.5,
  );
  
  static const TextStyle screenTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: 0.5,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textMedium,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textMedium,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textLight,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: textLight,
  );
  
  static const TextStyle timerText = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: primaryPurple,
    letterSpacing: -1,
  );
  
  static const TextStyle distanceText = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: primaryPurple,
    letterSpacing: -0.5,
  );
  
  static const TextStyle countdownText = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: primaryPurple,
    letterSpacing: -2,
  );
  
  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textGrey,
    letterSpacing: 0.5,
  );
  
  static const TextStyle dialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  
  static const TextStyle dialogContent = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textMedium,
    height: 1.5,
  );
  
  // Button Styles
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryPurple,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    textStyle: buttonText,
  );
  
  static ButtonStyle largePrimaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryPurple,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: white,
      letterSpacing: 0.5,
    ),
  );
  
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: white,
    foregroundColor: primaryPurple,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: primaryPurple, width: 2),
    ),
    elevation: 0,
    textStyle: buttonText.copyWith(color: primaryPurple),
  );
  
  static ButtonStyle textButton = TextButton.styleFrom(
    foregroundColor: primaryPurple,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: primaryPurple,
    ),
  );
  
  static ButtonStyle iconButton({Color? backgroundColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? white,
      foregroundColor: primaryPurple,
      padding: const EdgeInsets.all(16),
      shape: const CircleBorder(),
      elevation: 2,
    );
  }
  
  static ButtonStyle dangerButton = ElevatedButton.styleFrom(
    backgroundColor: errorRed,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    textStyle: buttonText,
  );
  
  static ButtonStyle successButton = ElevatedButton.styleFrom(
    backgroundColor: successGreen,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
    textStyle: buttonText,
  );
  
  // Card Styles 
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 24,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: primaryPurple.withValues(alpha: 0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
        spreadRadius: -4,
      ),
    ],
  );
  
  static BoxDecoration statsCardDecoration = BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: primaryPurple.withValues(alpha: 0.15), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: primaryPurple.withValues(alpha: 0.2),
        blurRadius: 28,
        offset: const Offset(0, 10),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 20,
        offset: const Offset(0, 6),
        spreadRadius: -2,
      ),
    ],
  );
  
  static BoxDecoration optionCardDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 24,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
    ],
  );
  
  // Dialog Styles
  static RoundedRectangleBorder dialogShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );
  
  static AlertDialog confirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return AlertDialog(
      shape: dialogShape,
      title: Text(title, style: dialogTitle),
      content: Text(content, style: dialogContent),
      actions: [
        TextButton(
          onPressed: onCancel,
          style: textButton,
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: primaryButton,
          child: Text(confirmText),
        ),
      ],
    );
  }
  
  // Snackbar Styles
  static SnackBar successSnackbar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: successGreen,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 4),
    );
  }
  
  static SnackBar errorSnackbar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: errorRed,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 4),
    );
  }
  
  static SnackBar warningSnackbar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: warningOrange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
    );
  }
  
  // Input Decoration
  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: bodyMedium.copyWith(color: textLight),
      labelStyle: bodyMedium.copyWith(color: primaryPurple),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: primaryPurple) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorRed, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
  
  // AppBar Theme
  static const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: white,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: textDark),
    titleTextStyle: TextStyle(
      color: textDark,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: appBarTheme,
      fontFamily: 'SF Pro Display',
      
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
      textButtonTheme: TextButtonThemeData(style: textButton),
      
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: cardBackground,
      ),
      
      dialogTheme: DialogThemeData(
        shape: dialogShape,
        backgroundColor: white,
      ),
      
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),
      
      iconTheme: const IconThemeData(
        color: primaryPurple,
      ),
    );
  }
  
  // Spacing Constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius Constants
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  
  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
}