//
//  ViewController.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift
import JGProgressHUD

class ViewController: UIViewController {
    
    public let presenter = SearchPresenter(apiService: APIService())
    let search = try! Realm().objects(SearchResult.self).sorted(byKeyPath: "id")
    var searchText: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "searchText")
        }
        get {
            return UserDefaults.standard.string(forKey: "searchText")
        }
    }
    var token: NotificationToken?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(searchViewDelegate: self)
        
        setupUI()
        
        self.token = search.observe({ (result) in
            switch result {
            case .error(_):
                self.showAlert()
            case .initial(_):
                print("")
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.tableView.reloadSections([0], with: .fade)
            }
        })
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        if let text = searchBar.text {
            presenter.refresh(view: self.tableView, text)
        }
    }
    
    private func setupUI() {
        if let text = self.searchText {
            self.searchBar.text = text
        }
        self.searchBar.becomeFirstResponder()
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            if let controller = segue.destination as? ResultTableViewController {
                controller.id = self.search[self.tableView.indexPathForSelectedRow!.row].id
            }
        }
    }
}

extension ViewController: SearchViewDelegate {
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Something happened", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true) {
            self.presenter.refresh(view: self.tableView, "")
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let searchText = searchBar.text {
                self.searchText = searchText
                self.presenter.refresh(view: self.tableView, searchText)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConfig.searchIdentifier.rawValue) as! SearchTableViewCell
        cell.resultLabel.text = search[indexPath.row].text
        return cell
    }
}
