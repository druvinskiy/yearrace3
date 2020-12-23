//
//  GameVC.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI
import HorizonCalendar

final class HorizonView: UIViewRepresentable {
//    private var selectedDay: Day?
    
    let game = GetDec31()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        return df
    }()
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
//        var components = DateComponents(year: 2020, month: 07, day: 11)
        
//        let july2020 = Calendar.current.date(from: components)!
        
//        calendarView.scroll(
//            toDayContaining: july2020,
//            scrollPosition: .centered,
//            animated: true)
                        
//        self.selectedDay = Calendar.current.day(containing: july2020)
        
        
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            let components = DateComponents(month: day.month.month, day: day.day)
            self.game.chooseDate(date: components)
            
            self.game.makeMove()
            
            let date = Calendar.current.date(from: self.game.currentDate)!
            
            calendarView.scroll(
                toDayContaining: date,
                scrollPosition: .centered,
                animated: true)
        }
        
        return calendarView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<HorizonView>) {}
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(month: 12, day: 31))!
        
        let textColor: UIColor
        if #available(iOS 13.0, *) {
          textColor = .label
        } else {
          textColor = .black
        }
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: (startDate...endDate),
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            
            .withMonthHeaderItemModelProvider { [weak self] month in
                let monthDateComponents = month.components
                let monthDate = Calendar.current.date(from: monthDateComponents)!
                let monthText = self?.dateFormatter.string(from: monthDate)
                
                return CalendarItemModel<MonthLabel> (
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 22),
                        textAlignment: .natural,
                        textColor: .white,
                        backgroundColor: .clear,
                        isAccessibilityElement: true,
                        accessibilityTraits: [.header]),
                    viewModel: .init(monthText: monthText ?? ""))
            }
            
            .withDayItemModelProvider { day in
                  var invariantViewProperties = DayLabel.InvariantViewProperties(
                    font: UIFont.systemFont(ofSize: 18),
                    textColor: textColor,
                    backgroundColor: .clear)

//                if day == self.selectedDay {
//                    invariantViewProperties.textColor = .white
//                    invariantViewProperties.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2352941176, blue: 0.8196078431, alpha: 1)
//                  }
                  
                  return CalendarItemModel<DayLabel>(
                    invariantViewProperties: invariantViewProperties,
                    viewModel: .init(day: day))
              }
            
            .withInterMonthSpacing(24)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
    }
}
