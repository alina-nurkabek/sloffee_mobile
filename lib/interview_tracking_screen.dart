import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InterviewTrackingScreen extends StatefulWidget {
  @override
  _InterviewTrackingScreenState createState() =>
      _InterviewTrackingScreenState();
}

class _InterviewTrackingScreenState extends State<InterviewTrackingScreen> {
  final List<Map<String, dynamic>> _interviews = [];

  @override
  void initState() {
    super.initState();
    _loadInterviews();
  }

  Future<void> _loadInterviews() async {
    final prefs = await SharedPreferences.getInstance();
    final String? interviewsString = prefs.getString('interviews');
    if (interviewsString != null) {
      setState(() {
        _interviews.addAll(List<Map<String, dynamic>>.from(json.decode(interviewsString)));
      });
    }
  }

  Future<void> _saveInterviews() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('interviews', json.encode(_interviews));
  }

  void _addInterview() {
    setState(() {
      _interviews.add({
        'company': '',
        'status': 'Applied',
        'startDate': DateTime.now(),
        'endDate': DateTime.now(),
        'phases': [],
      });
      _saveInterviews();
    });
  }

  void _removeInterview(int index) {
    setState(() {
      _interviews.removeAt(index);
      _saveInterviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interview Tracker'),
        backgroundColor: Color(0xFFE6E6FA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _addInterview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE6E6FA),
              ),
              child: Text('Add Interview'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _interviews.length,
                itemBuilder: (context, index) {
                  final interview = _interviews[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Company Name',
                            ),
                            onChanged: (value) {
                              interview['company'] = value;
                              _saveInterviews();
                            },
                          ),
                          SizedBox(height: 8.0),
                          DropdownButtonFormField(
                            value: interview['status'],
                            items: ['Applied', 'Approved']
                                .map((status) => DropdownMenuItem(
                                      child: Text(status),
                                      value: status,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                interview['status'] = value;
                                _saveInterviews();
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Status',
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Start Date',
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: interview['startDate'],
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        interview['startDate'] = pickedDate;
                                        _saveInterviews();
                                      });
                                    }
                                  },
                                  controller: TextEditingController(
                                    text: interview['startDate']
                                        .toString()
                                        .split(' ')[0],
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'End Date',
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: interview['endDate'],
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        interview['endDate'] = pickedDate;
                                        _saveInterviews();
                                      });
                                    }
                                  },
                                  controller: TextEditingController(
                                    text: interview['endDate']
                                        .toString()
                                        .split(' ')[0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phases (comma separated)',
                            ),
                            onChanged: (value) {
                              interview['phases'] =
                                  value.split(',').map((s) => s.trim()).toList();
                              _saveInterviews();
                            },
                          ),
                          SizedBox(height: 8.0),
                          Text('Phases: ${interview['phases'].join(', ')}'),
                          SizedBox(height: 8.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeInterview(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
