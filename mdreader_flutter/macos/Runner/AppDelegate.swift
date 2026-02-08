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
    super.applicationDidFinishLaunching(notification)

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

  // Modern macOS (and recent FlutterAppDelegate) delivers file-open events as URLs
  // via this method instead of the legacy openFile:/openFiles: methods. Without this
  // override, file:// URLs from Finder go to FlutterAppDelegate's default handler
  // (deep linking) and never reach our pending-file mechanism.
  override func application(_ application: NSApplication, open urls: [URL]) {
    for url in urls {
      if url.isFileURL {
        let path = url.path
        if channelReady, let channel = openFileChannel {
          channel.invokeMethod("openFile", arguments: path)
        } else {
          pendingFilePath = path
        }
        break  // Only open the first file
      }
    }

    // Forward non-file URLs to super for deep linking
    let nonFileUrls = urls.filter { !$0.isFileURL }
    if !nonFileUrls.isEmpty {
      super.application(application, open: nonFileUrls)
    }
  }

  // Legacy methods kept as fallback for older macOS versions
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
