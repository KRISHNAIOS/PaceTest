
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewTopActions: UIView!
    
    var viewModel: CardViewModel = CardViewModel()
    var countingLabel = UILabel()
    var previousCell : CardCell?
    var currentCell : CardCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        loadTopView()
        setUpCardsDisplay()
    }
    
    private func loadTopView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 100
        stackView.translatesAutoresizingMaskIntoConstraints = false
        countingLabel.text = "Steps: 0"
        countingLabel.textColor = .white
        countingLabel.textAlignment = .center
        let buttonRestart =  UIButton(frame: CGRect(x: 10,
                                                    y: 0,
                                                    width: 150,
                                                    height: 60))
        buttonRestart.setTitle("Restart",
                               for: .normal)
        buttonRestart.setTitleColor(.white,
                                    for: .normal)
        buttonRestart.addTarget(self,
                                action: #selector(restartAction),
                                for: .touchUpInside)
        viewTopActions.addSubview(stackView)
        viewTopActions.backgroundColor = .clear
        stackView.addArrangedSubview(countingLabel)
        stackView.addArrangedSubview(buttonRestart)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewTopActions.topAnchor, constant: 0.0),
            stackView.bottomAnchor.constraint(equalTo: viewTopActions.bottomAnchor, constant: 0.0),
            stackView.leadingAnchor.constraint(equalTo: viewTopActions.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: viewTopActions.trailingAnchor, constant: -20.0),
            
            countingLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0.0),
            countingLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0.0),
            countingLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0.0),
            
        ])
    }
    
    private func setUpCardsDisplay() {
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    @objc func restartAction() {
        viewModel.resetCount()
        previousCell = nil
        currentCell = nil
        countingLabel.text = "Steps: 0"
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else {
            return
        }
        if !cell.card.isMatched && cell != previousCell {
            viewModel.increaseCount()
            countingLabel.text = "Steps: "+"\(viewModel.stepsCount)"
            cell.show()
            if let previousCard = previousCell {
                if cell.answerLabel.text == previousCard.answerLabel.text {
                    cell.card.isMatched = true
                    previousCard.card.isMatched = true
                    viewModel.increaseMatchingPairs()
                    previousCell = nil
                    showCongratulationsMessage()
                } else {
                    previousCard.card.isMatched = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        previousCard.show()
                        cell.show()
                    })
                    previousCell = nil
                }
            } else {
                previousCell = cell
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let amountPerRow = CGFloat(Int(sqrt(Double(20))))
        let interSpaces = (10*(amountPerRow-1))
        let availableSpace = collectionView.frame.width - interSpaces
        let itemWidth =  availableSpace / amountPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }

}

// MARK: - Data Source
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CardViewModel.CARD_PAIRS_VALUE
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError("Error")
        }
        if indexPath.row < CardViewModel.CARD_PAIRS_VALUE/2 {
            let answerValue = viewModel.generatedPairsArray[indexPath.row]
            cell.setCardDisplay(answer: answerValue.0)
        } else {
            let index = indexPath.row - CardViewModel.CARD_PAIRS_VALUE/2
            let answerValue = viewModel.generatedPairsArray[index]
            cell.setCardDisplay(answer: answerValue.1)
        }
        cell.backgroundColor = .clear
        return cell
    }

}

extension ViewController {
    private func showCongratulationsMessage() {
        if viewModel.checkGameOver() {
            let refreshAlert = UIAlertController(title: "Congratulations", message: "You won in " + "\(viewModel.stepsCount)" + "Steps", preferredStyle: .alert)
            refreshAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (action: UIAlertAction!) in
                self.restartAction()
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
}
