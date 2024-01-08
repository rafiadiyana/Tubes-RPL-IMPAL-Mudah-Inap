import 'package:course_hotel/config/app_route.dart';
import 'package:course_hotel/model/booking.dart';
import 'package:course_hotel/source/booking_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/c_user.dart';
import '../model/hotel.dart';

class HotelBookingForm extends StatefulWidget {

  
  @override
  _HotelBookingFormState createState() => _HotelBookingFormState();
  
  final cUser = Get.put(CUser());
}

class _HotelBookingFormState extends State<HotelBookingForm> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _guestsController = TextEditingController();
  String _includeBreakfast = 'Included'; // default value
  List<String> _includeBreakfastOptions = ['Included', 'Not Included'];
  
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration (nights)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _guestsController,
              decoration: InputDecoration(labelText: 'Number of Guests'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Breakfast',
              style: TextStyle(fontSize: 13),
            ),
            DropdownButton<String>(
              value: _includeBreakfast,
              onChanged: (String? newValue) {
                setState(() {
                  _includeBreakfast = newValue ?? '';
                });
              },
              items: _includeBreakfastOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: () {
                int night = int.tryParse(_durationController.text) ?? 0;
                int guest = int.tryParse(_guestsController.text) ?? 1;
                int totalPayment = hotel.price * night  + 100000 + 150000;
                String breakfast = _includeBreakfast;
                String startDate = _startDateController.text;

                final cUser = Get.put(CUser());
                BookingSource.addBooking(
                  cUser.data.id!,
                  Booking(
                    id: '',
                    idHotel: hotel.id,
                    cover: hotel.cover,
                    name: hotel.name,
                    location: hotel.location,
                    date: _startDateController.text,
                    guest: int.tryParse(_guestsController.text) ?? 1,
                    breakfast: _includeBreakfast,
                    checkInTime: '08.00 WIB',
                    night: int.tryParse(_durationController.text) ?? 0,
                    serviceFee: 100000,
                    activities: 150000,
                    totalPayment: hotel.price * night  + 100000 + 150000,
                    status: 'PAID',
                    isDone: false,
                  ),
                );
                Navigator.pushNamed(context, AppRoute.checkout, arguments: {'hotel': hotel, 'night': night, 'totalPayment': totalPayment, 'breakfast': breakfast, 'startDate': startDate, 'guest': guest},);
              },
              child: 
                Text("Next")
            ),
          ],
        ),
      ),
    );
  }
}