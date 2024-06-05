import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _totalApplications = 0;
  int _totalInterviews = 0;
  int _totalOffers = 0;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final String? interviewsString = prefs.getString('interviews');
    if (interviewsString != null) {
      final List<Map<String, dynamic>> interviews = List<Map<String, dynamic>>.from(json.decode(interviewsString));

      int applications = interviews.length;
      int interviewsCount = interviews.where((i) => i['status'] == 'Approved').length;
      int offers = interviews.where((i) => i['status'] == 'Offer').length;

      setState(() {
        _totalApplications = applications;
        _totalInterviews = interviewsCount;
        _totalOffers = offers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color(0xFFE6E6FA), // Lavender purple color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle, size: 40, color: Colors.deepPurple),
                      title: Text('Profile Information'),
                      subtitle: Text('View and update your profile information.'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.work, size: 40, color: Colors.deepPurple),
                      title: Text('Track Interviews'),
                      subtitle: Text('Manage your upcoming and ongoing interviews.'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).pushNamed('/interview-tracker');
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Statistics',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.approval, size: 40, color: Colors.deepPurple),
                            Text('Applications'),
                            Text('$_totalApplications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.thumb_up, size: 40, color: Colors.deepPurple),
                            Text('Interviews'),
                            Text('$_totalInterviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.done_all, size: 40, color: Colors.deepPurple),
                            Text('Offers'),
                            Text('$_totalOffers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
