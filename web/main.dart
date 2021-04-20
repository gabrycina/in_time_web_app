import 'package:flutter_web_ui/ui.dart' as ui;
import 'package:pwa/client.dart' as pwa;
import 'package:in_time/main.dart' as app;

main() async {
  // register PWA ServiceWorker for offline caching.
  await ui.webOnlyInitializePlatform();
  app.main();

  pwa.Client();

}