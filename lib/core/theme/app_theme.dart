import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey[50],
      cardColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.light,
        primary: const Color(0xFF0D47A1),
        onPrimary: Colors.white,
        secondary: const Color(0xFF0F3C5C),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.grey[900]!,
        outline: Colors.grey[200],
      ),
      textTheme: GoogleFonts.montserratTextTheme(),
      dividerTheme: DividerThemeData(color: Colors.grey[100]),
      extensions: const [TicketColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D47A1),
        brightness: Brightness.dark,
        primary: const Color(0xFF0D47A1), // Lighter blue for dark mode
        onPrimary: const Color.fromARGB(255, 255, 255, 255),
        secondary: const Color(0xFF0F3C5C),
        onSecondary: Colors.white,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        outline: Colors.grey[800],
      ),
      textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      dividerTheme: DividerThemeData(color: Colors.grey[800]),
      extensions: const [TicketColors.dark],
    );
  }

  static ShadThemeData get shadLight {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadBlueColorScheme.light(primary: Color(0xFF0D47A1)),
      primaryButtonTheme: const ShadButtonTheme(
        backgroundColor: Color(0xFF0D47A1),
        hoverBackgroundColor: Color(0xFF0A3880), // Slightly darker
      ),
    );
  }

  static ShadThemeData get shadDark {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadBlueColorScheme.dark(primary: Color(0xFF0D47A1)),
      primaryButtonTheme: const ShadButtonTheme(
        backgroundColor: Color(0xFF0D47A1),
        hoverBackgroundColor: Color(0xFF0A3880),
      ),
    );
  }
}

@immutable
class TicketColors extends ThemeExtension<TicketColors> {
  final Color? statusDoneBackground;
  final Color? statusDoneText;
  final Color? statusInProgressBackground;
  final Color? statusInProgressText;
  final Color? statusAssignedBackground;
  final Color? statusAssignedText;
  final Color? statusNewBackground;
  final Color? statusNewText;
  final Color? statusDefaultBackground;
  final Color? statusDefaultText;

  final Color? priorityCriticalBackground;
  final Color? priorityCriticalText;
  final Color? priorityHighBackground;
  final Color? priorityHighText;
  final Color? priorityMediumBackground;
  final Color? priorityMediumText;
  final Color? priorityLowBackground;
  final Color? priorityLowText;
  final Color? priorityDefaultBackground;
  final Color? priorityDefaultText;

  const TicketColors({
    required this.statusDoneBackground,
    required this.statusDoneText,
    required this.statusInProgressBackground,
    required this.statusInProgressText,
    required this.statusAssignedBackground,
    required this.statusAssignedText,
    required this.statusNewBackground,
    required this.statusNewText,
    required this.statusDefaultBackground,
    required this.statusDefaultText,
    required this.priorityCriticalBackground,
    required this.priorityCriticalText,
    required this.priorityHighBackground,
    required this.priorityHighText,
    required this.priorityMediumBackground,
    required this.priorityMediumText,
    required this.priorityLowBackground,
    required this.priorityLowText,
    required this.priorityDefaultBackground,
    required this.priorityDefaultText,
  });

  @override
  TicketColors copyWith({
    Color? statusDoneBackground,
    Color? statusDoneText,
    Color? statusInProgressBackground,
    Color? statusInProgressText,
    Color? statusAssignedBackground,
    Color? statusAssignedText,
    Color? statusNewBackground,
    Color? statusNewText,
    Color? statusDefaultBackground,
    Color? statusDefaultText,
    Color? priorityCriticalBackground,
    Color? priorityCriticalText,
    Color? priorityHighBackground,
    Color? priorityHighText,
    Color? priorityMediumBackground,
    Color? priorityMediumText,
    Color? priorityLowBackground,
    Color? priorityLowText,
    Color? priorityDefaultBackground,
    Color? priorityDefaultText,
  }) {
    return TicketColors(
      statusDoneBackground: statusDoneBackground ?? this.statusDoneBackground,
      statusDoneText: statusDoneText ?? this.statusDoneText,
      statusInProgressBackground:
          statusInProgressBackground ?? this.statusInProgressBackground,
      statusInProgressText: statusInProgressText ?? this.statusInProgressText,
      statusAssignedBackground:
          statusAssignedBackground ?? this.statusAssignedBackground,
      statusAssignedText: statusAssignedText ?? this.statusAssignedText,
      statusNewBackground: statusNewBackground ?? this.statusNewBackground,
      statusNewText: statusNewText ?? this.statusNewText,
      statusDefaultBackground:
          statusDefaultBackground ?? this.statusDefaultBackground,
      statusDefaultText: statusDefaultText ?? this.statusDefaultText,
      priorityCriticalBackground:
          priorityCriticalBackground ?? this.priorityCriticalBackground,
      priorityCriticalText: priorityCriticalText ?? this.priorityCriticalText,
      priorityHighBackground:
          priorityHighBackground ?? this.priorityHighBackground,
      priorityHighText: priorityHighText ?? this.priorityHighText,
      priorityMediumBackground:
          priorityMediumBackground ?? this.priorityMediumBackground,
      priorityMediumText: priorityMediumText ?? this.priorityMediumText,
      priorityLowBackground:
          priorityLowBackground ?? this.priorityLowBackground,
      priorityLowText: priorityLowText ?? this.priorityLowText,
      priorityDefaultBackground:
          priorityDefaultBackground ?? this.priorityDefaultBackground,
      priorityDefaultText: priorityDefaultText ?? this.priorityDefaultText,
    );
  }

  @override
  TicketColors lerp(ThemeExtension<TicketColors>? other, double t) {
    if (other is! TicketColors) {
      return this;
    }
    return TicketColors(
      statusDoneBackground: Color.lerp(
        statusDoneBackground,
        other.statusDoneBackground,
        t,
      ),
      statusDoneText: Color.lerp(statusDoneText, other.statusDoneText, t),
      statusInProgressBackground: Color.lerp(
        statusInProgressBackground,
        other.statusInProgressBackground,
        t,
      ),
      statusInProgressText: Color.lerp(
        statusInProgressText,
        other.statusInProgressText,
        t,
      ),
      statusAssignedBackground: Color.lerp(
        statusAssignedBackground,
        other.statusAssignedBackground,
        t,
      ),
      statusAssignedText: Color.lerp(
        statusAssignedText,
        other.statusAssignedText,
        t,
      ),
      statusNewBackground: Color.lerp(
        statusNewBackground,
        other.statusNewBackground,
        t,
      ),
      statusNewText: Color.lerp(statusNewText, other.statusNewText, t),
      statusDefaultBackground: Color.lerp(
        statusDefaultBackground,
        other.statusDefaultBackground,
        t,
      ),
      statusDefaultText: Color.lerp(
        statusDefaultText,
        other.statusDefaultText,
        t,
      ),
      priorityCriticalBackground: Color.lerp(
        priorityCriticalBackground,
        other.priorityCriticalBackground,
        t,
      ),
      priorityCriticalText: Color.lerp(
        priorityCriticalText,
        other.priorityCriticalText,
        t,
      ),
      priorityHighBackground: Color.lerp(
        priorityHighBackground,
        other.priorityHighBackground,
        t,
      ),
      priorityHighText: Color.lerp(priorityHighText, other.priorityHighText, t),
      priorityMediumBackground: Color.lerp(
        priorityMediumBackground,
        other.priorityMediumBackground,
        t,
      ),
      priorityMediumText: Color.lerp(
        priorityMediumText,
        other.priorityMediumText,
        t,
      ),
      priorityLowBackground: Color.lerp(
        priorityLowBackground,
        other.priorityLowBackground,
        t,
      ),
      priorityLowText: Color.lerp(priorityLowText, other.priorityLowText, t),
      priorityDefaultBackground: Color.lerp(
        priorityDefaultBackground,
        other.priorityDefaultBackground,
        t,
      ),
      priorityDefaultText: Color.lerp(
        priorityDefaultText,
        other.priorityDefaultText,
        t,
      ),
    );
  }

  // Helper methods to get colors by status/priority string
  Color getStatusColor(String status) {
    switch (status) {
      case 'Done':
        return statusDoneBackground!;
      case 'In Progress':
        return statusInProgressBackground!;
      case 'Assigned':
        return statusAssignedBackground!;
      case 'New':
        return statusNewBackground!;
      default:
        return statusDefaultBackground!;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'Done':
        return statusDoneText!;
      case 'In Progress':
        return statusInProgressText!;
      case 'Assigned':
        return statusAssignedText!;
      case 'New':
        return statusNewText!;
      default:
        return statusDefaultText!;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return priorityCriticalBackground!;
      case 'High':
        return priorityHighBackground!;
      case 'Medium':
        return priorityMediumBackground!;
      case 'Low':
        return priorityLowBackground!;
      default:
        return priorityDefaultBackground!;
    }
  }

  Color getPriorityTextColor(String priority) {
    switch (priority) {
      case 'Critical':
        return priorityCriticalText!;
      case 'High':
        return priorityHighText!;
      case 'Medium':
        return priorityMediumText!;
      case 'Low':
        return priorityLowText!;
      default:
        return priorityDefaultText!;
    }
  }

  static const light = TicketColors(
    statusDoneBackground: Color(0xFFE8F5E9), // Colors.green.shade50
    statusDoneText: Color(0xFF2E7D32), // Colors.green.shade800
    statusInProgressBackground: Color(0xFFE3F2FD), // Colors.blue.shade50
    statusInProgressText: Color(0xFF1565C0), // Colors.blue.shade800
    statusAssignedBackground: Color(0xFFFFFDE7), // Colors.yellow.shade50
    statusAssignedText: Color(0xFFF9A825), // Colors.yellow.shade800
    statusNewBackground: Color(0xFFF3E5F5), // Colors.purple.shade50
    statusNewText: Color(0xFF6A1B9A), // Colors.purple.shade800
    statusDefaultBackground: Color(0xFFEEEEEE), // Colors.grey.shade200
    statusDefaultText: Color(0xFF424242), // Colors.grey.shade800
    priorityCriticalBackground: Color(0xFFFFEBEE), // Colors.red.shade50
    priorityCriticalText: Color(0xFFC62828), // Colors.red.shade800
    priorityHighBackground: Color(0xFFFFF3E0), // Colors.orange.shade50
    priorityHighText: Color(0xFFEF6C00), // Colors.orange.shade800
    priorityMediumBackground: Color(0xFFFFFDE7), // Colors.yellow.shade50
    priorityMediumText: Color(0xFFF9A825), // Colors.yellow.shade800
    priorityLowBackground: Color(0xFFE8F5E9), // Colors.green.shade50
    priorityLowText: Color(0xFF2E7D32), // Colors.green.shade800
    priorityDefaultBackground: Color(0xFFEEEEEE), // Colors.grey.shade200
    priorityDefaultText: Color(0xFF424242), // Colors.grey.shade800
  );

  static const dark = TicketColors(
    statusDoneBackground: Color(0xFF1B5E20), // Darker green
    statusDoneText: Color(0xFFA5D6A7), // Lighter green text
    statusInProgressBackground: Color(0xFF0D47A1), // Darker blue
    statusInProgressText: Color(0xFF90CAF9), // Lighter blue text
    statusAssignedBackground: Color(0xFFF57F17), // Darker yellow/orange
    statusAssignedText: Color(0xFFFFF59D), // Lighter yellow text
    statusNewBackground: Color(0xFF4A148C), // Darker purple
    statusNewText: Color(0xFFCE93D8), // Lighter purple text
    statusDefaultBackground: Color(0xFF424242), // Darker grey
    statusDefaultText: Color(0xFFEEEEEE), // Lighter grey text
    priorityCriticalBackground: Color(0xFFB71C1C), // Darker red
    priorityCriticalText: Color(0xFFEF9A9A), // Lighter red text
    priorityHighBackground: Color(0xFFE65100), // Darker orange
    priorityHighText: Color(0xFFFFCC80), // Lighter orange text
    priorityMediumBackground: Color(0xFFF57F17), // Darker yellow
    priorityMediumText: Color(0xFFFFF59D), // Lighter yellow text
    priorityLowBackground: Color(0xFF1B5E20), // Darker green
    priorityLowText: Color(0xFFA5D6A7), // Lighter green text
    priorityDefaultBackground: Color(0xFF424242), // Darker grey
    priorityDefaultText: Color(0xFFEEEEEE), // Lighter grey text
  );
}
