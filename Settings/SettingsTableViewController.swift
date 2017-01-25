//
//  SettingsTableViewController.swift
//  Settings
//
//  Created by yagom on 2017. 1. 25..
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, SwitchCellDelegate {

    struct Sections {
        static let titles: [String?] = ["User Information", "System Settings"]
        
        static let rowTitles: [[String?]?] = [["Name", "Age", "Gender"],
                                              ["Brightness", "Volume", "Airplain Mode", "Wifi", "Bluetooth"]]
        
        static func numberOfRows(of section: Int) -> Int {
            return rowTitles[section]?.count ?? 0
        }
        
        static func titleForIndexPath(_ indexPath: IndexPath) -> String? {
            return rowTitles[indexPath.section]?[indexPath.row]
        }
        
        static func cellIdentifier(for indexPath: IndexPath) -> String {
            switch indexPath.section {
            case 0:
                return "RightDetailCell"
            case 1:
                switch indexPath.row {
                case 2:
                    return "SwitchCell"
                default:
                    return "RightDetailCell"
                }
            default:
                return ""
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsTableViewController.Sections.titles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.numberOfRows(of: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Sections.cellIdentifier(for: indexPath), for: indexPath)
        
        cell.textLabel?.text = Sections.titleForIndexPath(indexPath)
        
        if let switchCell = cell as? SwitchCell {
            switchCell.onOffSwitch.isOn = UserDefaults.standard.bool(forKey: UserDefaultsKey.airplainMode)
            switchCell.delegate = self
        } else {
            switch indexPath.row {
            case 0:
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: UserDefaultsKey.userName)
            case 1:
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: UserDefaultsKey.userAge)
            case 2:
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: UserDefaultsKey.userGender)
            default:
                cell.detailTextLabel?.text = nil
            }
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections.titles[section]
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destinationViewController = segue.destination as? InputFieldViewController,
            let cell = sender as? UITableViewCell {
        
            guard let cellIndex = self.tableView.indexPath(for: cell)?.row else {
                return
            }
            
            switch cellIndex {
            case 0:
                destinationViewController.inputType = .name
            case 1:
                destinationViewController.inputType = .age
            default:
                return
            }
            
        }
    }
    
    // MARK: - SwitchCellDelegate Methods
    
    func switchCellDidChangeSwitchValue(sender: SwitchCell) {
        if sender.textLabel?.text == "Airplain Mode" {
            UserDefaults.standard.set(sender.onOffSwitch.isOn, forKey: UserDefaultsKey.airplainMode)
            UserDefaults.standard.synchronize()
        }
    }

}
















