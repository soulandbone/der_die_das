import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.flutterDash,
    // Surface color adjustments.
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 1,
    // Convenience direct styling properties.
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 2.0,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 6,
      useM2StyleDividerInM3: true,
      adaptiveElevationShadowsBack: FlexAdaptive.excludeWebAndroidFuchsia(),
      adaptiveAppBarScrollUnderOff: FlexAdaptive.excludeWebAndroidFuchsia(),
      adaptiveRadius: FlexAdaptive.excludeWebAndroidFuchsia(),
      defaultRadiusAdaptive: 10.0,
      elevatedButtonSchemeColor: SchemeColor.secondaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      checkboxSchemeColor: SchemeColor.primaryFixed,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 19,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedBorderWidth: 1.0,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      listTileSelectedSchemeColor: SchemeColor.primary,
      fabUseShape: true,
      fabAlwaysCircular: true,
      fabSchemeColor: SchemeColor.tertiary,
      chipSchemeColor: SchemeColor.outline,
      chipSelectedSchemeColor: SchemeColor.tertiary,
      chipSecondarySelectedSchemeColor: SchemeColor.tertiary,
      cardRadius: 13.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 3.0,
      popupMenuOpacity: 0.91,
      dialogRadius: 18.0,
      appBarScrolledUnderElevation: 1.0,
      drawerElevation: 1.0,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomSheetRadius: 18.0,
      bottomSheetElevation: 2.0,
      bottomSheetModalElevation: 4.0,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.errorContainer,
      bottomNavigationBarOpacity: 0.57,
      menuRadius: 6.0,
      menuElevation: 3.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      menuBarShadowColor: Color(0x00000000),
      searchBarElevation: 4.0,
      searchViewElevation: 4.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onPrimaryContainer,
      navigationBarMutedUnselectedLabel: true,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onPrimaryContainer,
      navigationBarMutedUnselectedIcon: true,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarBackgroundSchemeColor: SchemeColor.primary,
      navigationBarElevation: 1.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
    ),
    // ColorScheme seed generation configuration for light mode.
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    tones: FlexSchemeVariant.candyPop.tones(Brightness.light),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    scheme: FlexScheme.flutterDash,
    // Surface color adjustments.
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 2,
    // Convenience direct styling properties.
    bottomAppBarElevation: 2.0,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 8,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      adaptiveElevationShadowsBack: FlexAdaptive.all(),
      adaptiveAppBarScrollUnderOff: FlexAdaptive.excludeWebAndroidFuchsia(),
      adaptiveRadius: FlexAdaptive.excludeWebAndroidFuchsia(),
      defaultRadiusAdaptive: 10.0,
      elevatedButtonSchemeColor: SchemeColor.secondaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      checkboxSchemeColor: SchemeColor.primaryFixed,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 22,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: false,
      inputDecoratorFocusedBorderWidth: 1.0,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      listTileSelectedSchemeColor: SchemeColor.primary,
      fabUseShape: true,
      fabAlwaysCircular: true,
      fabSchemeColor: SchemeColor.tertiary,
      chipSchemeColor: SchemeColor.outline,
      chipSelectedSchemeColor: SchemeColor.tertiary,
      chipSecondarySelectedSchemeColor: SchemeColor.tertiary,
      cardRadius: 13.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 3.0,
      popupMenuOpacity: 0.91,
      dialogRadius: 18.0,
      appBarBackgroundSchemeColor: SchemeColor.onSecondaryContainer,
      appBarScrolledUnderElevation: 3.0,
      drawerElevation: 1.0,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomSheetRadius: 18.0,
      bottomSheetElevation: 2.0,
      bottomSheetModalElevation: 4.0,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.errorContainer,
      bottomNavigationBarOpacity: 0.57,
      menuRadius: 6.0,
      menuElevation: 3.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      menuBarShadowColor: Color(0x00000000),
      searchBarElevation: 4.0,
      searchViewElevation: 4.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onPrimaryContainer,
      navigationBarMutedUnselectedLabel: true,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onPrimaryContainer,
      navigationBarMutedUnselectedIcon: true,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarBackgroundSchemeColor: SchemeColor.primary,
      navigationBarElevation: 1.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
    ),
    // ColorScheme seed configuration setup for dark mode.
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    tones: FlexSchemeVariant.candyPop.tones(Brightness.dark),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
