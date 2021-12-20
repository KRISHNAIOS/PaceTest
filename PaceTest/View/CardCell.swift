import UIKit

class CardCell: UICollectionViewCell {
    static let identifier = "CardCellIdentifier"
    private let animationDuration = 0.5
    private(set) var isShown = false
    var card: Card = Card(question: "?",
                          answer: 0,
                          isShown: false,
                          isMatched: false)
    let answerLabel = UILabel()
    let questionLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        contentView.addSubview(answerLabel)
        contentView.addSubview(questionLabel)
        answerLabel.frame = rect
        questionLabel.frame = rect
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0),
            answerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0),
            answerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0),
        ])
        contentView.backgroundColor = .orange
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setCardDisplay(answer: Int) {
        card = Card(question: "?",
                    answer: answer,
                    isShown: false,
                    isMatched: false)
        questionLabel.isHidden = false
        answerLabel.isHidden = true
        questionLabel.text = "?"
        answerLabel.text = "\(card.answer)"
        isShown = false
    }
    
    func show() {
        isShown = !isShown
        flipCards()
    }
    
    private func flipCards() {
        if isShown {
            questionLabel.isHidden = true
            answerLabel.isHidden = false
            contentView.backgroundColor = .white
            UIView.transition(from: self.contentView,
                              to: self.contentView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        } else {
            questionLabel.isHidden = false
            answerLabel.isHidden = true
            contentView.backgroundColor = .orange
            UIView.transition(from: self.contentView,
                              to: self.contentView,
                              duration: animationDuration,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
    }
}
