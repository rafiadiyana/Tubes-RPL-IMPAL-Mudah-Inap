import 'package:course_hotel/config/app_format.dart';
import 'package:course_hotel/model/booking.dart';
import 'package:flutter/material.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';



class DetailBookingPage extends StatelessWidget {
  DetailBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Booking booking = ModalRoute.of(context)!.settings.arguments as Booking;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          header(booking, context),
          const SizedBox(height: 16),
          roomDetails(booking, context),
          const SizedBox(height: 16),
          paymentMethod(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Container paymentMethod(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.iconMandiri,
                  width: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mandiri',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Bank Transfer',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle, color: AppColor.secondary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container roomDetails(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Details',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          itemRoomDetail(
            context,
            'Date',
            AppFormat.date(booking.date),
          ),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Guest', '${booking.guest} Guest'),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Breakfast', booking.breakfast),
          const SizedBox(height: 8),
          itemRoomDetail(context, 'Check-in Time', booking.checkInTime),
          const SizedBox(height: 8),
          itemRoomDetail(
              context, '${booking.night} night',  AppFormat.currency((booking.totalPayment - booking.serviceFee - booking.activities).toDouble())),
          const SizedBox(height: 8),
          itemRoomDetail(
            context,
            'Service fee',
            AppFormat.currency(booking.serviceFee.toDouble()),
          ),
          const SizedBox(height: 8),
          itemRoomDetail(
            context,
            'Activities',
            AppFormat.currency(booking.activities.toDouble()),
          ),
          const SizedBox(height: 8),
          itemRoomDetail(
            context,
            'Total Payment',
            AppFormat.currency(booking.totalPayment.toDouble()),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
          onPressed: () {
            showCancelConfirmationDialog(context, booking);
          },
          style: ElevatedButton.styleFrom(
            primary: AppColor.primary,
          ),
          child: Text(
            'Cancel Booking',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Warna teks diubah menjadi hitam
            ),
          ),
        ),
        ],
      ),
    );
  }

  Row itemRoomDetail(BuildContext context, String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          data,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Container header(Booking booking, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              booking.cover,
              fit: BoxFit.cover,
              height: 70,
              width: 90,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  booking.location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showCancelConfirmationDialog(BuildContext context, Booking booking) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Cancel Booking'),
        content: Text('Are you sure you want to cancel this booking?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Warna teks diubah menjadi hitam
            ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Yes',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Warna teks diubah menjadi hitam
            ),
            ),           
          ),
        ],
      );
    },
  );
}


