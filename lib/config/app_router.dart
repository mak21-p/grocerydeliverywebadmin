import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return StartupScreen.route();
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case StartupScreen.routeName:
        return StartupScreen.route();
      case GroceryhomeScreen.routeName:
        return GroceryhomeScreen.route();
      case GroceryProductListScreen.routeName:
        return GroceryProductListScreen.route(
            category: settings.arguments as String);
      case CartScreen.routeName:
        return CartScreen.route();
      case GroceryCheckoutScreen.routeName:
        return GroceryCheckoutScreen.route();
      case SingleProductScreen.routeName:
        return SingleProductScreen.route(
            category: settings.arguments as String,
            docName: settings.arguments as String);
      case GroceryLocationScreen.routeName:
        return GroceryLocationScreen.route();
      case VerifyPhoneNumberScreen.id:
        return _route(VerifyPhoneNumberScreen(
            phoneNumber: settings.arguments as dynamic));
      case PhoneAuthScreen.routeName:
        return PhoneAuthScreen.route();
      case LocationInfoScreen.routeName:
        return LocationInfoScreen.route();
      case AdminScreen.routeName:
        return AdminScreen.route();
      case AdminAddProductScreen.routeName:
        return AdminAddProductScreen.route(
            category: settings.arguments as String);
      case AdminRemoveProductScreen.routeName:
        return AdminRemoveProductScreen.route(
            category: settings.arguments as String);
      case GrocerySignupScreen.routeName:
        return GrocerySignupScreen.route();
      case AdminOrdersScreen.routeName:
        return AdminOrdersScreen.route();
      case GrocerySearchScreen.routeName:
        return GrocerySearchScreen.route();
      case ContactUsScreen.routeName:
        return ContactUsScreen.route();
      case TermsAndConditionsScreen.routeName:
        return TermsAndConditionsScreen.route();
      case GroceryFaqScreen.routeName:
        return GroceryFaqScreen.route();
      case AdminViewOrderScreen.routeName:
        return AdminViewOrderScreen.route(
            orderId: settings.arguments as String);
        break;
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text('error')),
            ),
        settings: RouteSettings(name: '/error'));
  }
}
