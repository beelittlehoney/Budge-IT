import 'package:code_breaker/StatisticsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'records_screen.dart';
import 'cards_screen.dart';
import 'menu_screen.dart';
import 'add_record_screen.dart';
import 'all_budgets_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track selected tab

  // List of screens for navigation
  final List<Widget> _screens = [
    HomeContent(),
    RecordsScreen(),
    AddRecordScreen(),
    CardsScreen(), // Change this from 'Center' to CardsScreen()
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_selectedIndex], // Display selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Change tab
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Records"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Cards"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}

// Home Page UI
class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedDate = "31 AUG 2023";
  String selectedBalance = "₱26,000.00";
  String selectedBudget = "₱14,500.00 left";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTotalBalanceSection(),
                SizedBox(height: 20),
                _buildBudgetSection(),
                SizedBox(height: 20),
                _buildCategoriesSection(),
              ],
            ),
          ),
        )
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.arrow_left, color: Colors.white),
              onPressed: () {}),
          Text(selectedDate,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
          IconButton(icon: Icon(Icons.arrow_right, color: Colors.white),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildTotalBalanceSection() {
    return GestureDetector(
      onTap: () {
        _showAccountSelection(); // Show dropdown on tap
      },
      child: _buildCard(
        title: "Total Balance",
        value: selectedBalance,
        trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ),
    );
  }

  void _showAccountSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select Account",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildAccountOption("Total Balance", "₱26,000.40", Icons.account_balance),
              _buildAccountOption("Credit Card", "₱10,000.00", Icons.credit_card),
              _buildAccountOption("Debit Card", "₱13,000.40", Icons.account_balance_wallet),
              _buildAccountOption("Cash", "₱1,000", Icons.money),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountOption(String name, String balance, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(name, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
      subtitle: Text(balance, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
      onTap: () {
        setState(() {
          selectedBalance = balance;
        });
        Navigator.pop(context); // Close the modal
      },
    );
  }


  Widget _buildBudgetSection() {
    return _buildCard(
      title: "Budget",
      value: selectedBudget,
      subtitle: "₱12,450.30 spent this month",
      trailing: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllBudgetsScreen()),
          );
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: Text(
          "All Budgets",
          style: GoogleFonts.poppins(color: Colors.blue, fontSize: 12),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: 12450.30 / 26000.00,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 6,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryItem("Entertainment", Colors.green, 3430, 5000),
              _buildCategoryItem("Food", Colors.orange, 1430, 3000),
              _buildCategoryItem("Transport", Colors.blue, 1200, 2500),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return _buildCard(
      title: "Categories",
      value: "",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Categories", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatisticsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: Text("Statistics", style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
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
                            PieChartSectionData(color: Colors.red, value: 30, radius: 12, showTitle: false),
                            PieChartSectionData(color: Colors.blue, value: 20, radius: 12, showTitle: false),
                            PieChartSectionData(color: Colors.orange, value: 10, radius: 12, showTitle: false),
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
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildRecordItem("Groceries", Icons.shopping_cart, 7000, 6000),
                    _buildRecordItem("Dining Out", Icons.restaurant, 5000, 4000),
                    _buildRecordItem("Transport", Icons.directions_bus, 3000, 2000),
                    _buildRecordItem("Entertainment", Icons.movie, 4000, 4500),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildRecordItem(String label, IconData icon, double budget,
      double spent) {
    bool overspent = spent > budget;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: overspent ? Colors.red : Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          ),
          Text("₱$spent", style: GoogleFonts.poppins(
              color: overspent ? Colors.red : Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    String? subtitle,
    Widget? child,
    Widget? trailing,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.white)),
              if (trailing != null) trailing,
            ],
          ),
          SizedBox(height: 4),
          if (value.isNotEmpty)
            Text(value,
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
          if (subtitle != null) ...[
            SizedBox(height: 4),
            Text(subtitle,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70))
          ],
          if (child != null) ...[SizedBox(height: 16), child],
        ],
      ),
    );
  }


  Widget _buildCategoryItem(String label, Color color, double spent,
      double total) {
    double progress = spent / total; // Compute percentage

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeWidth: 3,
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
              Text(
                "₱${spent.toStringAsFixed(2)} spent",
                style: GoogleFonts.poppins(
                    color: color, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}