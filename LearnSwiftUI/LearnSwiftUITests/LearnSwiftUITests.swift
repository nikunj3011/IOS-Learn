//
//  LearnSwiftUITests.swift
//  LearnSwiftUITests
//
//  Created by Nikunj Rathod on 2026-08-31.
//

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
}
