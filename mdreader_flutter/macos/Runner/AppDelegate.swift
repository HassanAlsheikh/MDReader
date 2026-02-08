import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  private var openFileChannel: FlutterMethodChannel?
  private var pendingFilePath: String?
  private var channelReady = false

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

      // Dart calls this to check for a file queued before Flutter was ready
      openFileChannel?.setMethodCallHandler { [weak self] (call, result) in
        if call.method == "getPendingFile" {
          self?.channelReady = true
          let path = self?.pendingFilePath
          self?.pendingFilePath = nil
          result(path)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }

  override func application(_ sender: NSApplication, openFile filename: String) -> Bool {
    if channelReady, let channel = openFileChannel {
      channel.invokeMethod("openFile", arguments: filename)
    } else {
      pendingFilePath = filename
    }
    return true
  }

  override func application(_ sender: NSApplication, openFiles filenames: [String]) {
    if let first = filenames.first {
      if channelReady, let channel = openFileChannel {
        channel.invokeMethod("openFile", arguments: first)
      } else {
        pendingFilePath = first
      }
    }
    sender.reply(toOpenOrPrint: .success)
  }
}
