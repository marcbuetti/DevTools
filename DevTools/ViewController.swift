//
//  ViewController.swift
//  DevTools
//
//  Created by Marc Büttner on 03.02.24.
//

import Cocoa

class ViewController: NSViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var versionLabel: NSTextField!
    
    @IBOutlet weak var ToolArt: NSComboBox!
    @IBOutlet weak var dockerSocketArt: NSComboBox!
    @IBOutlet weak var dockerControlContainer: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
           versionLabel.stringValue = "Version: \(version) - Build: \(build)"
           print("App-Version: \(version), Build-Nummer: \(build)")
        }
        

        
        
        
        //defaults.set("John Doe", forKey: "UserName")
        
        /*if let userName = defaults.string(forKey: "UserName") {
            testTextField.stringValue = "UserName: \(userName)"
            print("UserName: \(userName)")
        }*/
        // Do any additional setup after loading the view.
    }

    @IBAction func resetSettings(_ sender: Any) {
        ToolArt.stringValue = "Docker"
        defaults.set("Docker", forKey: "toolArt")
        dockerSocketArt.stringValue = "Manual Docker-Socket"
        defaults.set("Manual Docker-Socket", forKey: "dockerSocketArt")
        
    }
    
    @IBAction func saveSettings(_ sender: Any) {
    
    }
    
    
    

}

