//
//  TooltipView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/27/20.
//

import HorizonCalendar
import UIKit

// MARK: - TooltipView

final class TooltipView: UIView {

  // MARK: Lifecycle

  init(invariantViewProperties: InvariantViewProperties) {
    backgroundView = UIView()
    backgroundView.backgroundColor = invariantViewProperties.backgroundColor
    backgroundView.layer.borderColor = invariantViewProperties.borderColor.cgColor
    backgroundView.layer.borderWidth = 1
    backgroundView.layer.cornerRadius = 6

    label = UILabel()
    label.font = invariantViewProperties.font
    label.textAlignment = invariantViewProperties.textAlignment
    label.lineBreakMode = .byTruncatingTail
    label.textColor = invariantViewProperties.textColor
    label.numberOfLines = 0

    super.init(frame: .zero)

    addSubview(backgroundView)
    addSubview(label)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var frameOfTooltippedItem: CGRect? {
    didSet {
      guard frameOfTooltippedItem != oldValue else { return }
      setNeedsLayout()
    }
  }

  var text: String {
    get { label.text ?? "" }
    set { label.text = newValue }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    guard let frameOfTooltippedItem = frameOfTooltippedItem else { return }

    label.sizeToFit()
    let labelSize = CGSize(
      width: min(label.bounds.size.width, bounds.width),
      height: label.bounds.size.height)

    let backgroundSize = CGSize(width: labelSize.width + 24, height: labelSize.height + 24)

    let proposedFrame = CGRect(
      x: frameOfTooltippedItem.midX - (backgroundSize.width / 2),
      y: frameOfTooltippedItem.minY - backgroundSize.height - 15,
      width: backgroundSize.width,
      height: backgroundSize.height)

    let frame: CGRect
    if proposedFrame.maxX > bounds.width {
      frame = proposedFrame.applying(.init(translationX: bounds.width - proposedFrame.maxX, y: 0))
    } else if proposedFrame.minX < 0 {
      frame = proposedFrame.applying(.init(translationX: -proposedFrame.minX, y: 0))
    } else {
      frame = proposedFrame
    }

    backgroundView.frame = frame
    label.center = backgroundView.center
  }

  // MARK: Private

  private let backgroundView: UIView
  private let label: UILabel

}

// MARK: CalendarItemViewRepresentable

extension TooltipView: CalendarItemViewRepresentable {

  struct InvariantViewProperties: Hashable {
    var backgroundColor = UIColor.white
    var borderColor = UIColor.black
    var font = UIFont.systemFont(ofSize: 16)
    var textAlignment = NSTextAlignment.center
    var textColor = UIColor.black
  }

  struct ViewModel: Equatable {
    let frameOfTooltippedItem: CGRect?
    let text: String
  }

  static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> TooltipView
  {
    TooltipView(invariantViewProperties: invariantViewProperties)
  }

  static func setViewModel(_ viewModel: ViewModel, on view: TooltipView) {
    view.frameOfTooltippedItem = viewModel.frameOfTooltippedItem
    view.text = viewModel.text
  }

}
