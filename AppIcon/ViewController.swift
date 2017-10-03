//
//  ViewController.swift
//  AppIcon
//
//  Created by Seven on 30/09/2017.
//  Copyright © 2017 Seven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initButtonEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initButtonEvent() {
        let views = self.view.subviews
        views.forEach { (view) in
            if let button = view as? UIButton {
                if button.tag > 0 {
                    button.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
                }
            }
        }
    }
    
    @objc func btnClick(sender: UIButton) {
        let iconName = "d\(sender.tag)"
        setAppIcon(name: iconName)
    }

    let appIconNames = ["d1", "d2", "d3", "d4", "d5", "d6"]
    @IBAction func buttonClick(_ sender: Any) {
        let index = Int(arc4random_uniform(UInt32(appIconNames.count)))
        let iconName = appIconNames[index]
        setAppIcon(name: iconName)
    }

    func setAppIcon(name: String) -> Void {
        let application = UIApplication.shared
        if !application.supportsAlternateIcons {
            // 不支持
            return
        }

        if let oldAppName = application.alternateIconName {
            print("oldAppName:\(oldAppName)")
        }

        application.setAlternateIconName(name) { (error) in
            if let error = error {
                print("更换出错\(error)")
            }
        }
    }
}



