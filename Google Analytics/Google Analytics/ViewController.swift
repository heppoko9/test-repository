//
//  ViewController.swift
//  Google Analytics
//
//  Created by 中村昭 on 2018/09/23.
//  Copyright © 2018年 中村昭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sendScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapButton(_ sender: Any) {
        sendEvent(category: "TOP", action: "タップ", label: "ボタン")
    }
}

extension ViewController {
    
    func tracker() -> GAITracker? {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.allowIDFACollection = true
        return tracker
    }
    
    func sendScreen() {
        let tracker = self.tracker()
        
        tracker?.set(kGAIScreenName, value: "トップ")
        
        // ボタン押した数を継続的にとりたいのでUserDefaultsで永続化
        // let tapCount = UserDefaults.standard.integer(forKey: "customDimensionTapCount")
        // 先ほど作ったindex = 1のfieldを生成
        let field = GAIFields.customDimension(for: 1)
        // fieldとvalue(String)をセット
        tracker?.set(field, value: "ディメンション１")
        
        let params = GAIDictionaryBuilder.createScreenView().build() as! [AnyHashable: Any]
        tracker?.send(params)
    }
    
    func sendEvent(category: String, action: String, label: String) {
        let tracker = self.tracker()
        let params = GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: label, value: nil).build() as! [AnyHashable: Any]
        tracker?.send(params)
    }
    
}

