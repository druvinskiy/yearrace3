//
//  GameVC.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI
import HorizonCalendar

struct HorizonView: UIViewRepresentable {
    @ObservedObject var game: Game
    @Binding var userSelectedDate: DateComponents?
    @Binding var shouldScroll: Bool
    @Binding var result: Result
    @Binding var submitButtonToggle: Bool
    
    @Binding var inGameOverState: Bool
    let calendar = Calendar(identifier: .gregorian)
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        return df
    }()
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        let date = calendar.date(from: self.game.currentDate)!
        
        calendarView.scroll(
            toDayContaining: date,
            scrollPosition: .centered,
            animated: true)
        
        calendarView.setContent(self.makeContent())
        
        
        calendarView.daySelectionHandler = { day in
            
            guard !inGameOverState else { return }
            
            let components = DateComponents(month: day.month.month, day: day.day)
            self.userSelectedDate = components
            result = .ok
            submitButtonToggle.toggle()
            calendarView.setContent(self.makeContent())
        }
        
        return calendarView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<HorizonView>) {
        let date = calendar.date(from: self.game.currentDate)!
        
        uiView.setContent(self.makeContent())
        
        if shouldScroll {
            uiView.scroll(
                toDayContaining: date,
                scrollPosition: .centered,
                animated: true)
            
            uiView.didEndDecelerating  = { _ in
                shouldScroll = false
            }
        }
    }
    
    private func makeContent() -> CalendarViewContent {
        let startDate = calendar.date(from: DateComponents(month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(month: 12, day: 31))!
        
        let textColor: UIColor
        if #available(iOS 13.0, *) {
            textColor = .label
        } else {
            textColor = .black
        }
        
        let overlaidItemLocations: Set<CalendarViewContent.OverlaidItemLocation>
        if let userSelectedDateComponents = userSelectedDate, result != .ok {
            let dateToOverlay = calendar.date(from: userSelectedDateComponents)!
            overlaidItemLocations = [.day(containingDate: dateToOverlay)]
        } else {
            overlaidItemLocations = []
        }
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            
            .withMonthHeaderItemModelProvider { month in
                let monthDateComponents = month.components
                let monthDate = calendar.date(from: monthDateComponents)!
                let monthText = self.dateFormatter.string(from: monthDate)
                
                return CalendarItemModel<MonthLabel> (
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 22),
                        textAlignment: .natural,
                        textColor: .white,
                        backgroundColor: .clear,
                        isAccessibilityElement: true,
                        accessibilityTraits: [.header]),
                    viewModel: .init(monthText: monthText))
            }
            
            .withDayItemModelProvider { day in
                var invariantViewProperties = DayLabel.InvariantViewProperties(
                    font: UIFont.systemFont(ofSize: 18),
                    textColor: textColor,
                    backgroundColor: .clear)
                
                let computerChoiceDate = calendar.date(from: self.game.currentDate)!
                
                if day == calendar.day(containing: computerChoiceDate) {
                    invariantViewProperties.textColor = .white
                    invariantViewProperties.backgroundColor = UIColor.brandSecondary
                }
                
                if let userSelectedDateComponents = userSelectedDate {
                    let userSelectedDate = calendar.date(from: userSelectedDateComponents)!
                    
                    if day == calendar.day(containing: userSelectedDate) {
                        invariantViewProperties.textColor = .white
                        invariantViewProperties.backgroundColor = UIColor.brandPrimary
                    }
                }
                
                return CalendarItemModel<DayLabel>(
                    invariantViewProperties: invariantViewProperties,
                    viewModel: .init(day: day))
            }
            
            .withOverlayItemModelProvider(for: overlaidItemLocations) { overlayLayoutContext in
                CalendarItemModel<TooltipView>(
                    invariantViewProperties: .init(
                        backgroundColor: #colorLiteral(red: 0.1339150965, green: 0.1508577265, blue: 0.1809139784, alpha: 1),
                        borderColor: .lightGray,
                        font: UIFont.systemFont(ofSize: 14),
                        textColor: .white),
                    viewModel: .init(
                        frameOfTooltippedItem: overlayLayoutContext.overlaidItemFrame,
                        text: result.rawValue))
            }
            
            .withInterMonthSpacing(24)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
    }
}
