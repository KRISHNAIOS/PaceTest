
import Foundation

class CardViewModel {
    static let CARD_PAIRS_VALUE : Int = 20
    
    init() {
        self.generatedPairsArray = generateRandomPairs()
    }
    
    var generatedPairsArray : [(Int, Int)] = []
    var stepsCount: Int = 0
    var matchingPairs: Int = 0
    
    private func generateRandomPairs()-> [(Int,Int)] {
        var firstArray : [Int] = []
        var secondArray : [Int] = []
        for _ in 0...CardViewModel.CARD_PAIRS_VALUE/2-1 {
            let random = Int.random(in: 1...100)
            firstArray.append(random)
            secondArray.append(random)
        }
        let shuffledArray = secondArray.shuffled()
        for i in 0...CardViewModel.CARD_PAIRS_VALUE/2-1 {
            generatedPairsArray.append((firstArray[i],shuffledArray[i]))
        }
        return generatedPairsArray
    }
    
    func increaseCount() {
        stepsCount += 1
    }
    
    func resetCount() {
        stepsCount = 0
        matchingPairs = 0
    }
    
    func increaseMatchingPairs() {
        matchingPairs += 1
    }
    
    func checkGameOver() -> Bool {
        if matchingPairs == CardViewModel.CARD_PAIRS_VALUE/2 {
            return true
        }
        return false
    }
}
