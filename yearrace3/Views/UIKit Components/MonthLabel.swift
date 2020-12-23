//
//  MonthLabel.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/22/20.
//

import HorizonCalendar

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
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.brandPrimary
        view.constrainHeight(constant: 35)
        view.layer.cornerRadius = 10
        
        let label = UILabel()
        label.font = invariantViewProperties.font
        label.textAlignment = invariantViewProperties.textAlignment
        label.textColor = invariantViewProperties.textColor
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.isAccessibilityElement = invariantViewProperties.isAccessibilityElement
        label.accessibilityTraits = invariantViewProperties.accessibilityTraits
        
        view.addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
        return view
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UIView) {
        if let label = view.subviews.first as? UILabel {
            label.text = viewModel.monthText
        }
    }
}
