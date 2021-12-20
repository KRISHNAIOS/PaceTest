
import Foundation

class CardInteractor : CardInteractorInputProtocol {
    
    var presenter: CardInteractorOutputProtocol?
    private var matchedCards = [Card]()
    private var shownCards = [Card]()
    private var cardsAmount = 0
    
    func startCardGame(cardsAmount: Int) throws {
        self.cardsAmount = cardsAmount
       // let content = try localDatamanager.fetchContent(amount: cardsAmount/2)
        let deck = createDeck(from: [1,2,3,4,5,6])
        presenter?.cardGameDidStart(with: deck)
    }

    func checkGameStatus() {
        if matchedCards.count == cardsAmount {
            presenter?.cardGameDidFinish()
            resetGame()
        } else {
            presenter?.match()
        }
    }

    func resetGame() {
        matchedCards.removeAll()
        shownCards.removeAll()
    }
    
    func didSelect(card: Card) {

//        guard let unpaired = unpairedCard() else {
//            // There are not enoght showed cards.
//            shownCards.append(card)
//            return
//        }
//
//        guard card.isShown(of: unpaired) else {
//            // Is not a match.
//            isNotMatch(of: [card, unpaired])
//            return
//        }
//
//        // Is a match!
//        isMatch(of: [card, unpaired])
    }

    private func isNotMatch(of cards: [Card]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.hide(cards: cards)
        }
    }

    private func isMatch(of cards: [Card]) {
        matchedCards.append(contentsOf: cards)
        checkGameStatus()
    }

    private func unpairedCard() -> Card? {
        guard shownCards.count > 0 else { return nil }
        return shownCards.removeLast()
    }
    
    func createDeck(from content: [Int], seed: UInt64? = nil) -> [Card] {
        var deck = [Card]()

        for value in content {
            //deck.append(contentsOf: [value, value.getCopy()]) // create card, and a pair.
        }

       // deck.shuffled(seed: seed)
        return deck
    }
}
