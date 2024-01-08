import 'package:course_hotel/source/hotel_source.dart';
import 'package:get/get.dart';

import '../model/hotel.dart';

class CNearby extends GetxController {
  final _category = 'All Place'.obs;
  String get category => _category.value;
  set category(n) {
    _category.value = n;
    update();
  }

  List<String> get categories => [
        'All Place',
        'Industrial',
        'Village',
      ];

  final _listHotel = <Hotel>[].obs;
  List<Hotel> get listHotel => _listHotel.value;

  getListHotel() async {
    _listHotel.value = await HotelSource.getHotel();
    update();
  }

  @override
  void onInit() {
    getListHotel();
    super.onInit();
  }
}
