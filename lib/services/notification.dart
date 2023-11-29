import 'package:asd/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print('Token: $fcmToken');

    //initialize further settings for push notification
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    //go to notification screen
    navigatorKey.currentState?.pushNamed(
      '/notifications',
      arguments: message,
    );
  }

  //handle forground and background settings
  Future initPushNotification() async {
    //app was tarminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
