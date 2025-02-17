import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For DateFormat
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'login_page.dart'; // Import your LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BudgetTrackerScreen(),
    );
  }
}

class BudgetTrackerScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      icon: 'assets/icons/electronic.png',
      title: 'Electronic',
      subtitle: 'Credit Card',
      amount: -1325.56,
      date: DateTime(2023, 8, 31, 20, 45),
    ),
    Transaction(
      icon: 'assets/icons/shopping.png',
      title: 'Shopping',
      subtitle: 'Credit Card',
      amount: -2425.56,
      date: DateTime(2023, 8, 31, 20, 45),
    ),
    Transaction(
      icon: 'assets/icons/taxi.png',
      title: 'Taxi',
      subtitle: 'Cash',
      amount: -485.10,
      date: DateTime(2023, 8, 28, 18, 35),
    ),
    Transaction(
      icon: 'assets/icons/doctor.png',
      title: 'Doctor',
      subtitle: 'Credit Card',
      amount: -1140.90,
      date: DateTime(2023, 8, 31, 20, 45),
    ),
    Transaction(
      icon: 'assets/icons/shopping.png',
      title: 'Shopping',
      subtitle: 'Credit Card',
      amount: -5125.56,
      date: DateTime(2023, 8, 31, 20, 45),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header Section
                _buildHeader(),
                const SizedBox(height: 20),
                // Transactions List Section
                _buildTransactionList(),
                const SizedBox(height: 30),
                // Call-to-Action Button
                _buildStartNowButton(context),
                const SizedBox(height: 20),
                // Footer Text Section
                _buildFooterText(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/logo.png', // Update to your logo path
          width: 137,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        Text(
          'Track Your Budget',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Track your income and expenses easily\n'
              'It is safe and the app does not save any data.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // Transactions List Section
  Widget _buildTransactionList() {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: -50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TransactionItem(transaction: transactions[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Start Now Button Section
  Widget _buildStartNowButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the Login Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0068FF),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Start Now',
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Footer Text Section
  Widget _buildFooterText() {
    return Text.rich(
      TextSpan(
        text: 'By continuing, you accept the ',
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.white70,
        ),
        children: [
          TextSpan(
            text: 'privacy policy',
            style: const TextStyle(color: Colors.white),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'terms of use.',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class Transaction {
  final String icon;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;

  Transaction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });
}

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetails(transaction: transaction),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'transaction-${transaction.title}', // Unique tag for Hero transition
              child: Image.asset(
                transaction.icon,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    transaction.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₱${transaction.amount.abs().toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy, hh:mm a').format(transaction.date),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetails({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(transaction.title)),
      body: Center(
        child: Hero(
          tag: 'transaction-${transaction.title}', // Matching tag for Hero animation
          child: Image.asset(
            transaction.icon,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
