import Combine
import Foundation

final class SemanticsLessonViewModel: ObservableObject {
    @Published private(set) var originalStructName = "Alex"
    @Published private(set) var copiedStructName = "Alex"
    @Published private(set) var originalClassName = "Alex"
    @Published private(set) var copiedClassName = "Alex"

    var structOriginalDescription: String { "Original: \(originalStructName)" }
    var structCopyDescription: String { "Copy: \(copiedStructName)" }
    var classOriginalDescription: String { "Original: \(originalClassName)" }
    var classCopyDescription: String { "Copy: \(copiedClassName)" }

    func runStructExample() {
        let original = PlayerValue(name: "Alex")
        var copy = original
        copy.name = "Sam"
        originalStructName = original.name
        copiedStructName = copy.name
    }

    func runClassExample() {
        let original = PlayerReference(name: "Alex")
        let copy = original
        copy.name = "Sam"
        originalClassName = original.name
        copiedClassName = copy.name
    }

    func reset() {
        originalStructName = "Alex"
        copiedStructName = "Alex"
        originalClassName = "Alex"
        copiedClassName = "Alex"
    }
}
