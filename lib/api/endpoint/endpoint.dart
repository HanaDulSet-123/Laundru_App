class Endpoint {
  static const String baseURL = "https://applaundry.mobileprojp.com/api";
  static const String register = "$baseURL/register";
  static const String profile = "$baseURL/me";
  static const String login = "$baseURL/login";
  static const String listlayanan = "$baseURL/layanan";
  static const String addorder = "$baseURL/orders";
  static const String categories = "$baseURL/categories";
  static const String listuser = "$baseURL/me";
  static const String listitem = "$baseURL/items";
  static const String listorder = "$baseURL/orders";

  static String detailorder(int id) => "$baseURL/orders/$id";
  static String updateorder(int id) => "$baseURL/orders/$id";

  // DELETE
  static String deletelayanan(int id) => "$baseURL/layanan/$id";
  static String cancelorder(int id) => "$baseURL/orders/$id";
}
