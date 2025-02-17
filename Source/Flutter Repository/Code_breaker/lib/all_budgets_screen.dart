import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllBudgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Budgets", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalBudgetCard(),
            SizedBox(height: 16),
            _buildBudgetCategoryCard("Entertainment", "₱10,000", "-₱5,450.30 spent", "₱4,549.70 left", Colors.green, Colors.purple),
            _buildBudgetCategoryCard("Food", "₱5,000", "-₱9,549.70 spent", "₱5,549.70 overspending", Colors.red, Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBudgetCard() {
    return _buildBudgetCategoryCard(
      "Total Budget",
      "₱25,000",
      "-₱5,450.30 spent",
      "₱4,549.70 left",
      Colors.white,
      Colors.blue,
    );
  }

  Widget _buildBudgetCategoryCard(String title, String budget, String spent, String remaining, Color titleColor, Color progressColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(color: titleColor, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(budget, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: title == "Food" ? 1.23 : 0.19, // Overspending for food
            backgroundColor: Colors.grey[800],
            color: progressColor,
            minHeight: 5,
          ),
          SizedBox(height: 8),
          Text(spent, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
          Text(remaining, style: GoogleFonts.poppins(color: title == "Food" ? Colors.red : Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
