//
//  structViewController.swift
//  APICalling
//
//  Created by TudipTech on 27/01/22.
//

import UIKit

class structViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "ListTitle".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        NetworkManager.shared.callStructAPI{ (status, _) in
    
            
            if status {
                self.tableView.reloadData()
            } else {
                self.openAlert(title: "", message: "Offline".localized, alertStyle: .alert, actionTitles: ["OK"], actionStyles: [.default])
            }
        }
        //tableView.reloadData()
    }
}

extension structViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NetworkManager.shared.structure.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StructureTableViewCell") as! StructureTableViewCell
        let structObj = NetworkManager.shared.structure[indexPath.row]
        NetworkManager.shared.fetchCellImage(structobj: structObj) { (data, structObj) in
            DispatchQueue.main.async {
                cell.nameLabel.text = structObj.name
                cell.structImageView.image = UIImage(data: data)
            }
        }
        return cell
    }
    
}
