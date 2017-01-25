//
//  SwitchCell.swift
//  Settings
//
//  Created by JoSeongGyu on 2017. 1. 25..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCellDidChangeSwitchValue(sender: SwitchCell)
}


class SwitchCell: UITableViewCell {

    weak var onOffSwitch: UISwitch!
    
    var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.accessoryView = UISwitch()
        onOffSwitch = self.accessoryView as? UISwitch
        onOffSwitch.addTarget(self, action: #selector(switchValueChanged(sender:)),
                              for: UIControlEvents.valueChanged)
    }
    
    

    func switchValueChanged(sender: UISwitch) {
        if let delegate = self.delegate {
            delegate.switchCellDidChangeSwitchValue(sender: self)
        }
        
        
        // delegate 대신
        // Notification Center로 노티피케이션 발송해도 됩니다
    }
    

}
