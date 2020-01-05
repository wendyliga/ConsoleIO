import XCTest

@testable import ConsoleIO

internal final class StringTests: XCTestCase {
    internal static var allTests = [
        ("test_nonEmpty_withNonEmptyString", test_nonEmpty_withNonEmptyString),
        ("test_nonEmpty_withEmptyString", test_nonEmpty_withEmptyString),
        ("test_nonEmpty_withNilString", test_nonEmpty_withNilString),
    ]
    
    internal func test_nonEmpty_withNonEmptyString() {
        let string = "Hello World"
        
        XCTAssertEqual(string.nonEmpty, "Hello World")
    }
    
    internal func test_nonEmpty_withEmptyString() {
        let string = ""
        
        XCTAssertEqual(string.nonEmpty, nil)
    }
    
    internal func test_nonEmpty_withNilString() {
        let string: String? = nil
        
        XCTAssertEqual(string?.nonEmpty, nil)
    }
}
