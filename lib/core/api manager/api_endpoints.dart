import 'package:travel/core/api%20manager/api_constants.dart';

abstract class ApiEndPoints {
  static const getHotels = '${ApiConstants.baseUrl}/hotel/gethotels';
  static const getTrips = '${ApiConstants.baseUrl}/trip/gettrips';
  static const chatbot = '${ApiConstants.chatbotUrl}/chat';
  static const register = '${ApiConstants.baseUrl}/user/signup';
  static const login = '${ApiConstants.baseUrl}/user/login';
  static const resetPassword = '${ApiConstants.baseUrl}/user/forgotpass';
  static const getWishlist = '${ApiConstants.baseUrl}/trip/wishlist';
  static const postTrip = '${ApiConstants.baseUrl}/trip/addtrip';
  static const postHotel = '${ApiConstants.baseUrl}/hotel';
  static String setFav(String tripId) =>
      "${ApiConstants.baseUrl}/user/addwishlist/$tripId";
  static String notFav(String tripId) =>
      "${ApiConstants.baseUrl}/trip/deletewishlist/$tripId";
}
