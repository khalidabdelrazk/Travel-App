import 'package:travel/core/api%20manager/api_constants.dart';

abstract class ApiEndPoints{
  static const getHotels = '/hotel/gethotels';
  static const getTrips = '/trip/gettrips';
  static const chatbot = '/chat';
  static const register = '/user/signup';
  static const login = '/user/login';
  static const resetPassword = '/user/forgotpass';
  static String setFav(String tripId) =>
      "${ApiConstants.baseUrl}/user/addwishlist/$tripId";
  // static String notFav(String tripId) =>
  //     "${ApiConstants.baseUrl}/user/addwishlist/$tripId";
}