//
//  FilterViewController.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 11/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    
    var master: MasterViewController!
    
    var tags: [String]?
    
    var isGrowing: Bool = false
    var isScoring: Bool = false
    
    var activeTags: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        let leftButton = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(cancelTapped))
        let rightButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            if tags != nil && tags?.count != 0 {
                return tags!.count
            } else {
                return 1
            }
        default:
            fatalError("No such section in filterViewController")
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "По именам"
                if !isScoring {
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = .blue
                } else {
                    cell.textLabel?.textColor = .black
                    cell.backgroundColor = .white
                }
            } else {
                cell.textLabel?.text = "По рейтингу"
                if !isScoring {
                    cell.textLabel?.textColor = .black
                    cell.backgroundColor = .white
                } else {
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = .blue
                }
            }
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.text = "По убыванию"
                if isGrowing {
                    cell.textLabel?.textColor = .black
                    cell.backgroundColor = .white
                } else {
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = .blue
                }
            } else {
                cell.textLabel?.text = "По возрастанию"
                if isGrowing {
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = .blue
                } else {
                    cell.textLabel?.textColor = .black
                    cell.backgroundColor = .white
                }
            }
        case 2:
            if tags != nil && tags?.count != 0 {
                cell.textLabel?.text = tags![indexPath.row]
            } else {
                cell.textLabel?.text = "Нет"
            }
        default:
            fatalError("No such section in filterViewController")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let warningAlert = UIAlertController(title: "Внимание", message: "Приношу свои извинения. Не реализовано", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        
        warningAlert.addAction(ok)
        present(warningAlert, animated: true)
        
        return
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                isScoring = false
            } else {
                isScoring = true
            }
        case 1:
            if indexPath.row == 0 {
                isGrowing = false
            } else {
                isGrowing = true
            }
        case 2:
            if tags != nil && tags?.count != 0 {
                return
            } else {
                // MARK
                return
            }
        default:
            fatalError("No such section!")
        }
        print("happening")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Сортировать по"
        case 1:
            return "Тип сортировки"
        case 2:
            return "Выбрать теги"
        default:
            fatalError("No such section in filterViewController")
        }
    }
    
    @objc func cancelTapped() {
        let dialog = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let unfilter = UIAlertAction(title: "Отключить фильтрацию", style: .destructive) { _ in
            print("Unplug")
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Оставить текущие настройки", style: .cancel) { _ in
            print("leave")
            self.dismiss(animated: true, completion: nil)
        }
        
        dialog.addAction(cancel)
        dialog.addAction(unfilter)
        
        present(dialog, animated: true, completion: nil)
        
    }
    
    @objc func doneTapped() {
        dismiss(animated: true, completion: nil)
    }

}
