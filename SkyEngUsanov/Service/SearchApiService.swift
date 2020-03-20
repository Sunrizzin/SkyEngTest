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
    
    func search(text: String, _ completion: @escaping (Bool) -> Void) {
        
        if let url = URL(string: AppConfig.coreurl.rawValue + text) {
            
            AF.request(url).responseArray { (response:AFDataResponse<[SearchResult]>) in
                switch response.result {
                case .failure(_):
                    completion(false)
                case .success(let items):
                    let realm = try! Realm()
                    DispatchQueue.main.async {
                        do {
                            try realm.write {
                                realm.deleteAll()
                                autoreleasepool {
                                    for item in items {
                                        realm.add(item, update: .all)
                                    }
                                }
                                completion(true)
                            }
                        } catch {
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
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
