
import XCTest
@testable import PaceTest

class CardCellTests: XCTestCase {
    
    var card: Card!
    var cell: CardCell!
    
    override func setUp() {
        super.setUp()
        card = Card.init(question: "?",
                         answer: 0,
                         isShown: false,
                         isMatched: false)
        cell = CardCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    func test_SetCard() {
        cell.card = card
        XCTAssertNotNil(cell.card)
        XCTAssertNotNil(cell.card.answer)
    }
    
    func test_Show() {
        // Initial
        cell.card = card
        XCTAssertFalse(cell.card.isShown)
        cell.show()
        XCTAssertFalse(cell.card.isMatched)
    }
    
}
