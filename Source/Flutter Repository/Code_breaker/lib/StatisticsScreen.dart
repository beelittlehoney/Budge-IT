import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Statistics", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDateSelector(),
            SizedBox(height: 16),
            _buildPieChart(),
            SizedBox(height: 16),
            _buildLegend(),
            SizedBox(height: 16),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_left, color: Colors.white),
        SizedBox(width: 8),
        Text("31 AUG 2023", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
        SizedBox(width: 8),
        Icon(Icons.arrow_right, color: Colors.white),
      ],
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 60,
              sections: [
                PieChartSectionData(color: Colors.green, value: 40, radius: 12, showTitle: false),
                PieChartSectionData(color: Colors.blue, value: 30, radius: 12, showTitle: false),
                PieChartSectionData(color: Colors.orange, value: 20, radius: 12, showTitle: false),
                PieChartSectionData(color: Colors.purple, value: 10, radius: 12, showTitle: false),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Expense", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
              Text("₱5,350.43", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem("Food", Colors.orange, "₱3,430"),
        _buildLegendItem("Shopping", Colors.blue, "₱1,560"),
        _buildLegendItem("Health", Colors.purple, "₱360"),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color, String amount) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 4),
        Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
        SizedBox(width: 4),
        Text(amount, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBarChart() {
    return Column(
      children: [
        _buildBarChartItem("Food", Colors.blue, 3430, 5000),
        _buildBarChartItem("Entertainment", Colors.orange, 3430, 5000),
        _buildBarChartItem("Health", Colors.purple, 3430, 5000),
      ],
    );
  }

  Widget _buildBarChartItem(String category, Color color, double spent, double total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(category, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          ),
          Expanded(
            flex: 4,
            child: LinearProgressIndicator(
              value: spent / total,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          SizedBox(width: 8),
          Text("₱$spent", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
