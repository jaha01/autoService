//
//  autoServiceTests.swift
//  autoServiceTests
//
//  Created by Yaroslav Magin on 14.12.2023.
//

@testable import autoService
import XCTest

public protocol MyVpnInteractorProtocol {
    public func setFullName(username: String, domainName: String?)
}

class MyVpnInteractor {
    private var name: String = ""
    
    public func setFullName(username: String, domainName: String?) {
        name = buildFullName(username: username, domainName: domainName)
    }
    
    func buildFullName(username: String, domainName: String?) -> String {
        if let domainName = domainName {
            return "\(username)\\\(domainName)"
        } else {
            return username
        }
    }
}

//
protocol MyDbServiceProtocol {
    func getItems() -> [String]
}

class MyDbService: MyDbServiceProtocol {
    func getItems() -> [String] {
        // complex login related to firebase
        return []
    }
}

class MockDbService: MyDbServiceProtocol {
    let items: [String]
    
    init(items: [String]) {
        self.items = items
    }
    
    func getItems() -> [String] {
        return items
    }
}

class MyCalcService {
    private let dbService: MyDbServiceProtocol
    
    init(db: MyDbServiceProtocol) {
        self.dbService = db
    }
    
    func doSomeImportantOperation() -> Int {
        return dbService.getItems().count
    }
}

final class autoServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let interactor = MyVpnInteractor()
        
        let result = interactor.buildFullName(username: "yaroslav", domainName: "apple")
        
        XCTAssertEqual(result, "apple\\yaroslav")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
