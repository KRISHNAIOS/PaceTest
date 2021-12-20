import Foundation
import UIKit


protocol CardPresenterProtocol: AnyObject {

    var view: CardViewProtocol? { get set }
    var interactor: CardInteractorInputProtocol? { get set }
    func startCardGame()
    func index(for card: Card) -> Int?
    func card(at index: Int) -> Card?
    func didSelect(card: Card)
    func amountOfCards() -> Int
}

protocol CardViewProtocol: AnyObject {
    var presenter: CardPresenterProtocol? { get set }
    func reloadCollection()
    func show(content: String)
    func show(message: String)
    func show(error: Error, completion: (() -> Swift.Void)?)
    func show(cards: [Card])
    func hide(cards: [Card])
}

protocol CardInteractorOutputProtocol: AnyObject {
    func cardGameDidStart(with deck: [Card])
    func cardGameDidFinish()
    func match()
    func show(cards: [Card])
    func hide(cards: [Card])
}

protocol CardInteractorInputProtocol: AnyObject {
    var presenter: CardInteractorOutputProtocol? { get set }
    func startCardGame(cardsAmount: Int) throws
    func didSelect(card: Card)

}

class CardPresenter: CardPresenterProtocol, CardInteractorOutputProtocol {
    
    weak var view: CardViewProtocol?
    var interactor: CardInteractorInputProtocol? = CardInteractor()
    
    init() {}

    private var deck = [Card]()
    
    func startCardGame() {
//        view?.show(content: GameString.tapCard.localized)
//        do {
//            try interactor?.startGame(cardsAmount: amountOfCards())
//            view?.show(message: GameString.start.localized)
//        } catch {
//            show(error: error)
//        }
    }

    func cardGameDidStart(with deck: [Card]) {
        self.deck = deck
        view?.reloadCollection()
    }

    func cardGameDidFinish() {
        deck.removeAll()
        view?.show(content: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startCardGame()
        }
    }

    func match() {
        view?.show(content: "")
    }
    
    
    func didSelect(card: Card) {
        view?.show(cards: [card])
        view?.show(content: "")
        interactor?.didSelect(card: card)
    }

    func show(cards: [Card]) {
        view?.show(cards: cards)
    }

    func hide(cards: [Card]) {
        view?.hide(cards: cards)
        view?.show(content: "")
    }

    func show(error: Error) {
        view?.show(error: error, completion: nil)
    }
    
    func card(at index: Int) -> Card? {
        guard deck.count > index && index >= 0 else { return nil }
        return deck[index]
    }

    func index(for card: Card) -> Int? {
        return 1
    }

    func amountOfCards() -> Int {
        return 0
    }

    
}
