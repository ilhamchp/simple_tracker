import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      GMSServices.provideAPIKey("AIzaSyDsol1tjzTS_mpuxfRaVIeRslJjY5g3I4I")
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
