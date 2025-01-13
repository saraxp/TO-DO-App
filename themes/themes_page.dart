import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeNotifier and the CustomThemeExtension
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final customTheme = Theme.of(context).extension<CustomThemeExtension>()!;

    return Scaffold(
      backgroundColor: customTheme.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: customTheme.iconColor),
        title: null,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Themes',
                      style: GoogleFonts.merriweather(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: customTheme.titleColor, // Heading text color
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                  child: Divider(thickness: 1, color: customTheme.dividerColor!,),
                ),
              ],
            ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      side: BorderSide(
                        color: customTheme.borderColor!, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      tileColor: customTheme.tileColor,
                      title: Text(
                        "Simple Navy",
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          color: customTheme.textColor, // Tile text color
                        ),
                      ),
                      trailing: themeNotifier.currentTheme == simpleNavy
                          ? Icon(Icons.check, color: customTheme.iconColor)
                          : null,
                      onTap: () {
                        themeNotifier.switchTheme(simpleNavy);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      side: BorderSide(
                        color: customTheme.borderColor!, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      tileColor: customTheme.tileColor, // Tile background color
                      title: Text(
                        "Brown Gradient",
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          color: customTheme.textColor, // Tile text color
                        ),
                      ),
                      trailing: themeNotifier.currentTheme == brownGradient
                          ? Icon(Icons.check, color: customTheme.iconColor)
                          : null,
                      onTap: () {
                        themeNotifier.switchTheme(brownGradient);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      side: BorderSide(
                        color: customTheme.borderColor!, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      tileColor: customTheme.tileColor, // Tile background color
                      title: Text(
                        "Pink Perfection",
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          color: customTheme.textColor, // Tile text color
                        ),
                      ),
                      trailing: themeNotifier.currentTheme == pinkPerfection
                          ? Icon(Icons.check, color: customTheme.iconColor)
                          : null,
                      onTap: () {
                        themeNotifier.switchTheme(pinkPerfection);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      side: BorderSide(
                        color: customTheme.borderColor!, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      tileColor: customTheme.tileColor, // Tile background color
                      title: Text(
                        "Espresso",
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.w600,
                          color: customTheme.textColor, // Tile text color
                        ),
                      ),
                      trailing: themeNotifier.currentTheme == espresso
                          ? Icon(Icons.check, color: customTheme.iconColor)
                          : null,
                      onTap: () {
                        themeNotifier.switchTheme(espresso);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


