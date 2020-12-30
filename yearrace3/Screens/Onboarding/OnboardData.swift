//
//  OnboardData.swift
//  Onboarding
//
//  Created by Stewart Lynch on 2020-06-27.
//

import UIKit

enum OnboardData {
    static func buildSet(width:CGFloat = 350, height: CGFloat = 350) -> OnboardSet {
        let onboardSet = OnboardSet()
        onboardSet.dimensions(width: width, height: height)
        onboardSet.newCard(title: "Welcome to...",
                           image: "YR",
                           text: "YearRace is an ideal app for anyone who likes puzzles.\n\nIn this single-player game, you take turns with the computer to chose calendar dates until one of the two parties reaches a particular date: depending on the game version, December 31 or January 1. Whoever reaches the desired date first wins.")
        onboardSet.newCard(title: "Rules",
                           image: "january",
                           text: "On each move, you can pick any date you want, within certain parameters: \n\n• you can only change either the month or the day (not both),\n\n• and you can't choose a date that doesn't exist or that is in the opposite direction of your target.")
        return onboardSet
    }
}
