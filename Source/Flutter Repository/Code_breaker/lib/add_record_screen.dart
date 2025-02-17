import 'package:flutter/material.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  int _selectedTabIndex = 0;
  String _selectedSubcategory = "Plane";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Add Record", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            SizedBox(height: 16),
            _buildExpenseHeader(),
            SizedBox(height: 20),
            _buildAccountSection(),
            _buildCategorySection(),
            _buildSubcategorySection(),
            _buildDateTimeSection(),
            _buildNotesSection(),
            Spacer(),
            _buildAddRecordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ["Expense", "Income", "Transfer"].asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        bool isSelected = _selectedTabIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedTabIndex = index),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: isSelected ? Colors.red : Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              if (isSelected) Container(height: 2, width: 50, color: Colors.red, margin: EdgeInsets.only(top: 4)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExpenseHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Expense", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
        Text("-₱400.32", style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildAccountSection() {
    return ListTile(
      leading: Icon(Icons.credit_card, color: Colors.white),
      title: Text("Credit Card", style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }

  Widget _buildCategorySection() {
    return ListTile(
      leading: Icon(Icons.directions_car, color: Colors.green),
      title: Text("Transport", style: TextStyle(color: Colors.green)),
      trailing: Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }

  Widget _buildSubcategorySection() {
    List<Map<String, dynamic>> subcategories = [
      {"name": "Taxi", "icon": Icons.local_taxi},
      {"name": "Rent", "icon": Icons.house},
      {"name": "Plane", "icon": Icons.airplanemode_active},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: subcategories.map((sub) {
        bool isSelected = _selectedSubcategory == sub["name"];
        return GestureDetector(
          onTap: () => setState(() => _selectedSubcategory = sub["name"]),
          child: Chip(
            label: Row(
              children: [
                Icon(sub["icon"], color: isSelected ? Colors.green : Colors.white, size: 16),
                SizedBox(width: 4),
                Text(sub["name"], style: TextStyle(color: isSelected ? Colors.green : Colors.white)),
              ],
            ),
            backgroundColor: isSelected ? Colors.green.withOpacity(0.3) : Colors.grey[800],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateTimeSection() {
    return ListTile(
      leading: Icon(Icons.calendar_today, color: Colors.white),
      title: Text("23 Aug 2023, 09:34 PM", style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }

  Widget _buildNotesSection() {
    return ListTile(
      leading: Icon(Icons.note, color: Colors.white),
      title: Text("From airport to Makati City", style: TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }

  Widget _buildAddRecordButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {},
        child: Text("Add Record", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}