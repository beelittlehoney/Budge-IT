import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsScreen extends StatefulWidget {
  @override
  CardsScreenState createState() => CardsScreenState();
}

class CardsScreenState extends State<CardsScreen> {
  bool _isCardNumberVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Wallet Cards", style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.blue, size: 30),
            onPressed: () {}, // TODO: Add new card functionality
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _buildCardCategory("My Credit Card", Colors.blue),
            _buildCardCategory("My Debit Card", Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildCardCategory(String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        _buildCard(color),
      ],
    );
  }

  Widget _buildCard(Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("BPI", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _isCardNumberVisible
                  ? Text("1234 5678 9101 1234", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))
                  : Text("****  ****  ****  1234", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(_isCardNumberVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isCardNumberVisible = !_isCardNumberVisible;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text("Aldrin", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          SizedBox(height: 4),
          Text("CVV: ***", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("Expire Date: **/**", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
