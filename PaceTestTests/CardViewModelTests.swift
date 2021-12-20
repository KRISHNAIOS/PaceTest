
import XCTest
@testable import PaceTest

class CardViewModelTests: XCTestCase {
    
    var sut: CardViewModel!
    override func setUp() {
        super.setUp()
        sut = CardViewModel()
    }
    
    func test_increasCount() {
        XCTAssertEqual(sut.stepsCount, 0)
        sut.increaseCount()
        XCTAssertEqual(sut.stepsCount, 1)
    }
    
    func test_resetCount() {
        sut.increaseCount()
        sut.increaseMatchingPairs()
        XCTAssertNotEqual(sut.stepsCount, 0)
        XCTAssertNotEqual(sut.matchingPairs, 0)
        sut.resetCount()
        XCTAssertEqual(sut.stepsCount, 0)
        XCTAssertEqual(sut.matchingPairs, 0)
    }
    
}
