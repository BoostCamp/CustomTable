//
//  InputFieldViewController.swift
//  Settings
//
//  Created by yagom on 2017. 1. 25..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class InputFieldViewController: UIViewController {

    enum InputType: String {
        case name = "Name"
        case age = "Age"
    }
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var inputType: InputType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let type = self.inputType else {
            print("입력 타입이 정해지지 않음. 인풋타입을 정한 후에 옮겨와야 합니다")
            return
        }
        
        switch type {
        case .name:
            self.titleLabel.text = "Enter your name"
            self.inputField.text = UserDefaults.standard.string(forKey: UserDefaultsKey.userName)
        case .age:
            self.titleLabel.text = "Enter your age"
            self.inputField.text = UserDefaults.standard.string(forKey: UserDefaultsKey.userAge)
            self.inputField.keyboardType = .numberPad
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let type = inputType else {
            return
        }
        
        let valueKey: String
        
        switch type {
        case .name:
            valueKey = UserDefaultsKey.userName
        case .age:
            valueKey = UserDefaultsKey.userAge
        }
        
        UserDefaults.standard.set(inputField.text, forKey: valueKey)
        UserDefaults.standard.synchronize()
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
