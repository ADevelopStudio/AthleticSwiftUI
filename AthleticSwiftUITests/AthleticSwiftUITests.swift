//
//  AthleticSwiftUITests.swift
//  AthleticSwiftUITests
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import XCTest
import SwiftUI
@testable import AthleticSwiftUI

class AthleticSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testMocks() throws {
        let _ = Article.example
        let _ = Team.example
        let _ = Author.example
        let _ =  League.example
    }
    
    func testApi() async {
        let serviceManager = AthleticNetworkModel()
        let promiseValidDataArticles = expectation(description: "Object from API is correct")
        let promiseValidDataAuthors = expectation(description: "Object from API is correct")
        do {
            let _ = try await serviceManager.fetchFilteringValues(type: .author)
            promiseValidDataAuthors.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try await serviceManager.fetchArticles()
            promiseValidDataArticles.fulfill()
        } catch {
            print("Error:", error)
            XCTFail(error.localizedDescription)
        }
        wait(for: [promiseValidDataArticles, promiseValidDataAuthors], timeout: 10)
    }
    
    func testApiFail() async {
        let serviceManager = AthleticNetworkModel()
        let promiseInvalidData = expectation(description: "Object from API is NOT correct")
        do {
            let _ = try await serviceManager.fetchArticles(filter: .byLeague(id: "@"))
            XCTFail("Somehow the object is good")
        } catch {
            print("Error:", error)
            promiseInvalidData.fulfill()
        }
        wait(for: [promiseInvalidData], timeout: 10)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
