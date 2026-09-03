import Combine
import Foundation

final class GenericsLessonViewModel: ObservableObject {
    @Published var firstNumber = 10
    @Published var secondNumber = 20
    @Published var firstWord = "Swift"
    @Published var secondWord = "UI"

    var swappedNumbers: (Int, Int) { Self.swapped(firstNumber, secondNumber) }
    var swappedWords: (String, String) { Self.swapped(firstWord, secondWord) }
    var numbersDescription: String { "Swapped: \(swappedNumbers.0), \(swappedNumbers.1)" }
    var wordsDescription: String { "Swapped: \(swappedWords.0), \(swappedWords.1)" }

    static func swapped<T>(_ first: T, _ second: T) -> (T, T) {
        (second, first)
    }
}
