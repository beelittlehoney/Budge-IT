import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Menu", style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPremiumButton(),
            SizedBox(height: 20),
            _buildMenuOption(Icons.privacy_tip, "Privacy Policy", () {}),
            _buildMenuOption(Icons.article, "Articles", () {}),
            _buildMenuOption(Icons.star, "Rate us", () {}),
            _buildMenuOption(Icons.support, "Support", () {}),
            _buildMenuOption(Icons.restore, "Restore Purchases", () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.workspace_premium, color: Colors.white),
          SizedBox(width: 10),
          Text("Get Premium", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: GoogleFonts.poppins(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      onTap: onTap,
    );
  }
}
