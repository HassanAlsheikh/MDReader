import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  private var openFileChannel: FlutterMethodChannel?
  private var pendingFilePath: String?

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    if let window = NSApplication.shared.windows.first,
       let flutterViewController = window.contentViewController as? FlutterViewController {
      openFileChannel = FlutterMethodChannel(
        name: "com.hassanalsheikh.mdreader/open_file",
        binaryMessenger: flutterViewController.engine.binaryMessenger
      )

      // If a file was opened before the channel was ready, send it now
      if let path = pendingFilePath {
        openFileChannel?.invokeMethod("openFile", arguments: path)
        pendingFilePath = nil
      }
    }
  }

  override func application(_ sender: NSApplication, openFile filename: String) -> Bool {
    if let channel = openFileChannel {
      channel.invokeMethod("openFile", arguments: filename)
    } else {
      // App not fully launched yet — queue the path
      pendingFilePath = filename
    }
    return true
  }

  override func application(_ sender: NSApplication, openFiles filenames: [String]) {
    if let first = filenames.first {
      if let channel = openFileChannel {
        channel.invokeMethod("openFile", arguments: first)
      } else {
        pendingFilePath = first
      }
    }
    sender.reply(toOpenOrPrint: .success)
  }
}
