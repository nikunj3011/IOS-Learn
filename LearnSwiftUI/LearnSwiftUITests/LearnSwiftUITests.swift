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
}
