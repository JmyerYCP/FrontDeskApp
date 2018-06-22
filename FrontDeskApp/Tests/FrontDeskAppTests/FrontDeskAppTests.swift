import XCTest
@testable import FrontDeskApp

final class FrontDeskAppTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FrontDeskApp().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
