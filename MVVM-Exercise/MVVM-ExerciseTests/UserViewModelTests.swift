//
//  UserViewModelTests.swift
//  MVVM-ExerciseTests
//
//  Created by Shakti Prakash Srichandan on 08/02/21.
//

import XCTest
import Combine
@testable import MVVM_Exercise

class UserViewModelTests: XCTestCase {
    
    var sut: UserViewModel!
    var mockApiService: MocknetworkFetcher!
 
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
       mockApiService = MocknetworkFetcher()
       sut = UserViewModel(apiService: mockApiService)
       
    }

    override func tearDownWithError() throws {
        super.tearDown()
      
       
       
    }
    
    func testMockServiceApi() {
       
        let expectation = XCTestExpectation(description: "users")

        mockApiService.getUserDetails().sink(receiveCompletion: { _ in }) { response in
            XCTAssertTrue(!response.isEmpty)
            XCTAssertEqual(response.count, 2)
            expectation.fulfill()
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 1)
        
    }


    func testViewModel() {
        XCTAssertTrue(sut.itemCount == 0)
        let expectation = self.expectation(description: "Users")
        sut.fetchUsersDetails()
        sut.requestSucceeded = {
          expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.itemCount, 2)
        XCTAssertEqual(sut.itemAt(0).name, User.testUserOne.name)
        
   
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }

}

class MocknetworkFetcher: NetworkFetchable {
    
    func getUserDetails() -> AnyPublisher<[User], MEError> {
        
        
        return Just([User.testUserOne,User.testUserTwo])
            .setFailureType(to: MEError.self)
            .eraseToAnyPublisher()
       
    }
    
    
}
