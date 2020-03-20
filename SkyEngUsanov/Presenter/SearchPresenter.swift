//
//  SearchPresenter.swift
//  SkyEngUsanov
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import Foundation
import JGProgressHUD
import UIKit

protocol SearchViewDelegate: NSObjectProtocol {
    func showAlert()
}

class SearchPresenter {
    
    private let apiService: APIService
    weak private var searchViewDelegate: SearchViewDelegate?
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func setViewDelegate(searchViewDelegate: SearchViewDelegate?) {
        self.searchViewDelegate = searchViewDelegate
    }
    
    func refresh(view: UIView, _ searchText: String) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: view)
        apiService.search(text: searchText) { (state) in
            hud.dismiss(animated: true)
            if !state {
                self.searchViewDelegate?.showAlert()
            }
        }
    }
}
