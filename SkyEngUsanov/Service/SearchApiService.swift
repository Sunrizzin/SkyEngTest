//
//  SearchApiService.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import JGProgressHUD

class APIService {
    private let realm = try! Realm()
    
    func search(view: UIView, text: String, _ completion: @escaping (Bool) -> Void) {
        
        if let url = URL(string: AppConfig.coreurl.rawValue + text) {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Loading"
            hud.show(in: view)
            
            AF.request(url).responseArray { (response:AFDataResponse<[SearchResult]>) in
                switch response.result {
                case .failure(_):
                    hud.dismiss(animated: true)
                    completion(false)
                case .success(let items):
                    DispatchQueue.main.async {
                        do {
                            try self.realm.write {
                                self.realm.deleteAll()
                                autoreleasepool {
                                    for item in items {
                                        self.realm.add(item, update: .all)
                                    }
                                }
                                hud.dismiss(animated: true)
                                completion(true)
                            }
                        } catch {
                            hud.dismiss(animated: true)
                            completion(false)
                        }
                    }
                }
            }
        } else {
            completion(false)
        }
    }
    
    func clearData() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
}
