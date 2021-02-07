//
//  MVVM_ExerciseTests.swift
//  MVVM-ExerciseTests
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import XCTest
@testable import MVVM_Exercise

class MVVM_ExerciseTests: XCTestCase {
    
    var company: Company!
    var geo: Geo!
    var address: Address!
    var user: User!
   
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        company = Company(name: "Apple", catchPhrase: "Multi-layered client-server neural-net", bs: "")
        geo = Geo(lat: "11.23", lng: "23.11")
        address = Address(street: "", suite: "999", city: "Cuttack", zipcode: "753004", geo: geo)
       
      
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        company = nil
        geo = nil
        address = nil
        user = nil
     
    }
    
    //MARK: Model Test methods
    
    func testComapanyModel() throws {
        XCTAssertEqual(company.name, "Apple")
        XCTAssertTrue(company.bs.isEmpty, "Yes")
    }
    
    func testGeoModel() throws {
        geo = nil
        XCTAssertNil(geo)
    }
    
    func testAddressModel() throws {
        XCTAssertEqual(address.geo.lat, geo.lat)
    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
