class Endpoint {
  static const String baseURL = "https://applaundry.mobileprojp.com/api";
  static const String register = "$baseURL/register";
  static const String profile = "$baseURL/profile";
  static const String login = "$baseURL/login";
  static const String addlayanan = "$baseURL/layanan";
  static const String listlayanan = "$baseURL/layanan";
  static const String addorder = "$baseURL/orders";
  static const String listorder = "$baseURL/orders";
  static const String detailorder = "$baseURL/orders/4";

  // DELETE
  static String deletelayanan(int id) => "$baseURL/layanan/$id";
  static String cancelorder(int id) => "$baseURL/orders/$id";
}
