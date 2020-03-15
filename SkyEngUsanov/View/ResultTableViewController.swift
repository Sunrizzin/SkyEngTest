//
//  ResultTableViewController.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class ResultTableViewController: UITableViewController {
    
    var id: Int = 0
    var search = try! Realm().objects(SearchResult.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search = try! Realm().objects(SearchResult.self).filter("id == \(id)")
        self.tableView.reloadData()
        self.navigationItem.title = search[0].text + " " + "(\(search[0].meanings[0].transcription))"
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search[0].meanings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConfig.resultIdentifier.rawValue, for: indexPath) as! ResultTableViewCell
        let imageUrl = search[0].meanings[indexPath.row].imageUrl
        if let url = URL(string: "https:" + imageUrl) {
            cell.iconImage.sd_setImage(with: url, completed: nil)
        }
        
        if let translation = search[0].meanings[indexPath.row].translation {
            cell.translateLabel.text = translation.text + " " + translation.note
        }
        
        return cell
    }
}
