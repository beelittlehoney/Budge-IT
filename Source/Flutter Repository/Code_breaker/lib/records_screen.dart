import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsScreen extends StatefulWidget {
  @override
  RecordsScreenState createState() => RecordsScreenState();
}

class RecordsScreenState extends State<RecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("Records", style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.blue, size: 30),
            onPressed: () {}, // TODO: Add new record functionality
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _buildDateHeader("16 September 2023"),
                  _buildRecordItem("Shopping", "Credit Card", -25.56, Icons.shopping_bag, Colors.orange),
                  _buildRecordItem("Salary", "Cash", 500.50, Icons.attach_money, Colors.green, true),
                  _buildRecordItem("Vacation", "Credit Card", -25.56, Icons.beach_access, Colors.red),
                  Divider(color: Colors.white24),
                  _buildDateHeader("15 September 2023"),
                  _buildRecordItem("Shopping", "Credit Card", -25.56, Icons.shopping_bag, Colors.orange),
                  _buildRecordItem("Salary", "Cash", 500.50, Icons.attach_money, Colors.green, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search Record",
          hintStyle: GoogleFonts.poppins(color: Colors.white54),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white54),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        date,
        style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildRecordItem(String title, String paymentMethod, double amount, IconData icon, Color iconColor, [bool showDelete = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                Text(paymentMethod, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          if (showDelete)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {}, // TODO: Delete functionality
            ),
          Text(
            (amount >= 0 ? "+₱" : "-₱") + amount.abs().toStringAsFixed(2),
            style: GoogleFonts.poppins(
              color: amount >= 0 ? Colors.green : Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
