import 'package:flutter/material.dart';

// ==================== COLORS ====================

class AppColors {
  // Primary brand
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9395FF);
  
  // Light mode
  static const lightTextPrimary = Color(0xFF1B1B1F);
  static const lightTextSecondary = Color(0xFF667085);
  static const lightTextTertiary = Color(0xFF98A2B3);
  static const lightSurface = Color(0xFFFDFDFE);
  static const lightBackground = Color(0xFFF7F8FC);
  static const lightCard = Colors.white;
  
  // Dark mode
  static const darkTextPrimary = Color(0xFFF0F0F5);
  static const darkTextSecondary = Color(0xFF8A8F9D);
  static const darkTextTertiary = Color(0xFF5A6070);
  static const darkSurface = Color(0xFF1E1E24);
  static const darkBackground = Color(0xFF121218);
  static const darkCard = Color(0xFF25252D);
  
  // Universal
  static const error = Color(0xFFEF4444);
  static const success = Color(0xFF10B981);
}

// ==================== THEME EXTENSION ====================

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color surface;
  final Color background;
  final Color card;
  final Color divider;
  final Color shadow;
  final Color overlay;
  final Color searchBar;
  final Color searchBarBorder;
  final List<Color> headerGradient;
  final Color navBackground;
  final Color navActive;
  final Color navInactive;

  const AppThemeExtension({
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.surface,
    required this.background,
    required this.card,
    required this.divider,
    required this.shadow,
    required this.overlay,
    required this.headerGradient,
    required this.searchBar,
    required this.searchBarBorder,
    required this.navBackground,
    required this.navActive,
    required this.navInactive,
  });

  static const light = AppThemeExtension(
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    surface: AppColors.lightSurface,
    background: AppColors.lightBackground,
    card: AppColors.lightCard,
    divider: Color(0xFFE5E7EB),
    shadow: Color(0x1A000000),
    overlay: Color(0x42000000),
    headerGradient: [
      Color(0xFFB7AEFF),
      Color(0xFFB4DFFF),
      Color(0xFFF7F8FC),
    ],
    searchBar: Color(0xFFF7F8FC),
    searchBarBorder: Color(0xFFE5E7EB),
    navBackground: Color(0xB3F6F8FF),
    navActive: Colors.white,
    navInactive: Color(0xFF555B68),
  );

  static const dark = AppThemeExtension(
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    surface: AppColors.darkSurface,
    background: AppColors.darkBackground,
    card: AppColors.darkCard,
    divider: Color(0xFF2A2A35),
    shadow: Color(0x40000000),
    overlay: Color(0x80000000),
    headerGradient: [
      Color(0xFF25252D),
      Color(0xFF1E1E24),
      Color(0xFF121218),
    ],
    searchBar: Color(0xFF121218),
    searchBarBorder: Color(0x1AFFFFFF),
    navBackground: Color(0xB31E1E24),
    navActive: Colors.white,
    navInactive: Color(0xFF8A8F9D),
  );

  static AppThemeExtension of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final ext = Theme.of(context).extension<AppThemeExtension>();
  
    if (ext == null) {
      debugPrint('⚠️ AppThemeExtension null, fallback ke $brightness');
      return brightness == Brightness.dark ? AppThemeExtension.dark : AppThemeExtension.light;
    }
  
    return ext;
  }

  @override
  AppThemeExtension copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? surface,
    Color? background,
    Color? card,
    Color? divider,
    Color? shadow,
    Color? overlay,
    List<Color>? headerGradient,
    Color? searchBar,
    Color? searchBarBorder,
    Color? navBackground,
    Color? navActive,
    Color? navInactive,
  }) {
    return AppThemeExtension(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      card: card ?? this.card,
      divider: divider ?? this.divider,
      shadow: shadow ?? this.shadow,
      overlay: overlay ?? this.overlay,
      headerGradient: headerGradient ?? this.headerGradient,
      searchBar: searchBar ?? this.searchBar,
      searchBarBorder: searchBarBorder ?? this.searchBarBorder,
      navBackground: navBackground ?? this.navBackground,
      navActive: navActive ?? this.navActive,
      navInactive: navInactive ?? this.navInactive,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      card: Color.lerp(card, other.card, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      headerGradient: headerGradient,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
      navActive: Color.lerp(navActive, other.navActive, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
    );
  }
}

// ==================== TYPOGRAPHY ====================

class AppTextStyles {
  static TextStyle display(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppThemeExtension.of(context).textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppThemeExtension.of(context).textPrimary,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static TextStyle title(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppThemeExtension.of(context).textPrimary,
    letterSpacing: -0.1,
    height: 1.4,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppThemeExtension.of(context).textPrimary,
    letterSpacing: -0.1,
    height: 1.45,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppThemeExtension.of(context).textSecondary,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Inverse (untuk di atas gambar gelap)
  static const titleInverse = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.1,
    height: 1.4,
  );

  static const captionInverse = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    height: 1.4,
  );
}

// ==================== SPACING & RADIUS ====================

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppRadius {
  static const sm = 12.0;
  static const md = 22.0;
  static const lg = 24.0;
  static const pill = 30.0;
}

// ==================== THEME DATA ====================

class AppTheme {
  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final ext = isDark ? AppThemeExtension.dark : AppThemeExtension.light;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: ext.background,
      extensions: [ext],
      fontFamily: 'Inter',
      useMaterial3: true,
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: ext.textPrimary),
        titleTextStyle: TextStyle(
          color: ext.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      cardTheme: CardThemeData(
        color: ext.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ext.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: ext.textTertiary,
          fontSize: 14,
        ),
      ),
      
      iconTheme: IconThemeData(
        color: ext.textSecondary,
        size: 24,
      ),
    );
  }
}
