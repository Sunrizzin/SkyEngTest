//
//  SkyEngUsanovTests.swift
//  SkyEngUsanovTests
//
//  Created by Aleksey Usanov on 15.03.2020.
//  Copyright © 2020 Aleksey Usanov. All rights reserved.
//

import XCTest
import Alamofire
@testable import SkyEngUsanov

class SkyEngUsanovTests: XCTestCase {
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //При некорректном урл - будет ошибка. Так же будет ошибка, если формат данных изменится
    func testRequest() {
        AF.request(AppConfig.coreurl.rawValue).responseArray { (response:AFDataResponse<[SearchResult]>) in
            switch response.result {
            case .failure(_):
                XCTFail()
            case .success(_):
                break
            }
            self.expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
