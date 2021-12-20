
import XCTest
@testable import PaceTest

class PaceTestTests: XCTestCase {
    
    var sut: ViewController!

    override func setUp() {
        super.setUp()
        sut = ViewController()
        sut.loadView()
        let view = sut.view
        XCTAssertNotNil(view)
    }
    
}
