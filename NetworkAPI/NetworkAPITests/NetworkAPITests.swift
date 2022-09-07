//
//  NetworkAPITests.swift
//  NetworkAPITests
//
//  Created by cagla copuroglu on 7.09.2022.
//

import XCTest
@testable import NetworkAPI

class NetworkAPITests: XCTestCase {
    
    var dummyService = NetworkService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDailyForecastRequest() throws {
        dummyService.requestCurrentForecastWeather(lat: 51.50998, lon: 0.1337) { response in
            guard let responseData = response.main?.temp else { return }
            
            XCTAssertEqual(responseData, 4)
            
        } failure: { err in
            XCTAssertFalse(false)
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
