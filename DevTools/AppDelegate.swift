import SwiftUI
import Cocoa
import Sparkle

// ViewModel, das den Zustand der Update-Überprüfung verwaltet
final class CheckForUpdatesViewModel: ObservableObject {
    @Published var canCheckForUpdates = false
    private var updater: SPUUpdater

    init(updater: SPUUpdater) {
        self.updater = updater
        updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }

    func checkForUpdates() {
        updater.checkForUpdates()
    }
}

// SwiftUI View für den "Check for Updates" Button
struct CheckForUpdatesView: View {
    @ObservedObject var viewModel: CheckForUpdatesViewModel

    var body: some View {
        Button("Check for Updates", action: viewModel.checkForUpdates)
            .disabled(!viewModel.canCheckForUpdates)
    }
}

@main
struct swiftui_menu_barApp: App {
    @State var currentNumber: String = "1"
    
    private let updaterController: SPUStandardUpdaterController
    @ObservedObject private var checkForUpdatesViewModel: CheckForUpdatesViewModel

    let windowManager = WindowManager()
    let defaults = UserDefaults.standard

    init() {
        self.updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        self.checkForUpdatesViewModel = CheckForUpdatesViewModel(updater: updaterController.updater)
    }

    var body: some Scene {
        MenuBarExtra(currentNumber, systemImage: "wrench.and.screwdriver.fill") {
            Button("Two") {
                currentNumber = "2"
            }
            .keyboardShortcut("2")

            Button("Neues Storyboard-Fenster öffnen") {
                if let userName = defaults.string(forKey: "UserName") {
                    print("UserName: \(userName)")
                }
            }
            .keyboardShortcut("3")
            
            Divider()
            
            CheckForUpdatesView(viewModel: checkForUpdatesViewModel)
            
            Button("Settings") {
                windowManager.openStoryboardWindow()
            }
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
    }
}

// WindowManager, um Fenster zu verwalten
class WindowManager {
    func openStoryboardWindow() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let windowController = storyboard.instantiateController(withIdentifier: "SettingsView") as? NSWindowController else {
            return
        }
        
        guard let window = windowController.window else {
            return
        }

        let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600)
        let windowSize = window.frame.size
        let x = (screenSize.width - windowSize.width) / 2
        let y = (screenSize.height - windowSize.height) / 2
        window.setFrame(NSRect(x: x, y: y, width: windowSize.width, height: windowSize.height), display: true)

        windowController.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

