//
//  GameVC.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI
import HorizonCalendar

struct HorizonView: UIViewRepresentable {
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        return df
    }()
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        
        calendarView.daySelectionHandler = { day in
            
          }
        
        return calendarView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<HorizonView>) {}
    
    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            
            .withMonthHeaderItemModelProvider { month in
                let textColor: UIColor
                if #available(iOS 13.0, *) {
                    textColor = .label
                } else {
                    textColor = .black
                }
                
                let monthDateComponents = month.components
                let monthDate = Calendar.current.date(from: monthDateComponents)!
                let monthText = dateFormatter.string(from: monthDate)
                
                return CalendarItemModel<MonthLabel> (
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 22),
                        textAlignment: .natural,
                        textColor: textColor,
                        backgroundColor: .clear,
                        isAccessibilityElement: true,
                        accessibilityTraits: [.header]),
                    viewModel: .init(monthText: monthText))
            }
    }
}

struct MonthLabel: CalendarItemViewRepresentable {
    
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        let textAlignment: NSTextAlignment
        let textColor: UIColor
        let backgroundColor: UIColor
        let isAccessibilityElement: Bool
        let accessibilityTraits: UIAccessibilityTraits
    }
    
    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let monthText: String
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 5
        #warning("What IS the superview?????  By adding the constraint centerXInSuperview() it has made the stackView spacing work correctly but the stackView itself is left justified in the 'view'.  It seems as though the constraint is unable to attach to a superview, whatever that might be.  Do you need to create a containerView which is pinned to the edges and add the stackView as a subView to the containerView?  It's weird.")
        stackView.centerXInSuperview()
        
        let label = UILabel()
        label.font = invariantViewProperties.font
        label.textAlignment = invariantViewProperties.textAlignment
        label.textColor = invariantViewProperties.textColor
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.isAccessibilityElement = invariantViewProperties.isAccessibilityElement
        label.accessibilityTraits = invariantViewProperties.accessibilityTraits
        
        let imageView = UIImageView()
        imageView.constrainWidth(constant: 123)
        imageView.constrainHeight(constant: 68)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        
        return stackView
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UIStackView) {
        if let label = view.arrangedSubviews.first as? UILabel {
            label.text = viewModel.monthText
        }
        
        if let imageView = view.arrangedSubviews[1] as? UIImageView {
            imageView.image = #imageLiteral(resourceName: "logo")
        }
    }
}
