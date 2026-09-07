//
//  LearnSwiftUITests.swift
//  LearnSwiftUITests
//
//  Created by Nikunj Rathod on 2026-08-31.
//

import Foundation
import Testing
@testable import LearnSwiftUI

struct LearnSwiftUITests {
    @Test func passingScoreUsesSuccessMessage() {
        #expect(ControlFlowViewModel.scoreMessage(for: 70) == "Great job — you passed!")
    }

    @Test func scoreBelowThresholdUsesPracticeMessage() {
        #expect(ControlFlowViewModel.scoreMessage(for: 69) == "Keep practicing — nearly there.")
    }

    @Test(arguments: [StudyDay.monday, .wednesday, .friday])
    func everyStudyDayHasAPlan(day: StudyDay) {
        #expect(!ControlFlowViewModel.plan(for: day).isEmpty)
    }

    @Test func functionAcceptsAParameterAndReturnsAValue() {
        #expect(FunctionsLessonViewModel.greet(name: "Sam") == "Hello, Sam!")
    }

    @Test func functionAcceptsAClosure() {
        let result = FunctionsLessonViewModel.calculate(4, 3) { $0 * $1 }
        #expect(result == 12)
    }

    @Test func guardLetHandlesMissingOptional() {
        #expect(OptionalsLessonViewModel.guardLetMessage(for: nil) == "Please enter a nickname first.")
    }

    @Test func collectionIgnoresAnEmptyTopic() {
        let viewModel = CollectionsLessonViewModel()
        let originalCount = viewModel.topics.count
        viewModel.newTopic = "   "
        viewModel.addTopic()
        #expect(viewModel.topics.count == originalCount)
    }

    @Test func classCopiesShareTheSameReference() {
        let original = PlayerReference(name: "Alex")
        let copy = original
        copy.name = "Sam"
        #expect(original.name == "Sam")
    }

    @Test func protocolAllowsDifferentConcreteTypes() {
        let item: any LessonDescribing = SwiftTopic(title: "Protocols")
        #expect(ProtocolsLessonViewModel.describe(item) == "Learn Protocols with Swift.")
    }

    @Test func genericSwapWorksWithStrings() {
        let result = GenericsLessonViewModel.swapped("Swift", "UI")
        #expect(result.0 == "UI")
        #expect(result.1 == "Swift")
    }

    @Test func enumCarriesAssociatedData() {
        let state = LessonLoadingState.loaded(topic: "Enums")
        #expect(state == .loaded(topic: "Enums"))
    }

    @Test func validationThrowsForShortName() {
        #expect(throws: ValidationError.nameTooShort(minimum: 3)) {
            try ErrorHandlingLessonViewModel.validate("A")
        }
    }

    @Test func observableCounterUsesConfiguredStep() {
        let counter = ObservationCounter()
        counter.step = 3
        counter.increment()
        #expect(counter.count == 3)
    }

    @Test func injectedServiceCanBeReplaced() {
        let viewModel = DependencyInjectionViewModel(greetingProvider: TestGreetingService())
        viewModel.name = "Sam"
        #expect(viewModel.greeting == "Test greeting for Sam")
    }

    @Test func repositoryHidesItsDataSource() async throws {
        let repository: any CourseRepository = InMemoryCourseRepository()
        let courses = try await repository.fetchCourses()
        #expect(courses.map(\.title) == ["Swift", "SwiftUI"])
    }

    @Test func codableDecodesNetworkJSON() throws {
        let json = #"{"userId":1,"id":7,"title":"Learn networking","completed":false}"#.data(using: .utf8)!
        let todo = try JSONDecoder().decode(NetworkTodo.self, from: json)
        #expect(todo.id == 7)
        #expect(todo.title == "Learn networking")
    }
}
