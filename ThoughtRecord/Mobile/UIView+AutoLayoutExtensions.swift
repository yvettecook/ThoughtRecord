import UIKit

enum Edge {
    case Top
    case Left
    case Bottom
    case Right
}

extension UIViewController {
    func pinToTopLayoutGuide(view subview: UIView, withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: subview, attribute: .Top,
            relatedBy: .Equal,
            toItem: topLayoutGuide, attribute: .Bottom,
            multiplier: 1, constant: inset
        )

        view.addConstraint(constraint)

        return constraint
    }
}

extension UIView {

    func pinToSuperview(edges: [Edge], constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) {
        for edge in edges {
            switch edge {
            case .Top: pinToSuperviewTop(withInset: constant, priority: priority)
            case .Left: pinToSuperviewLeft(withInset: constant, priority: priority)
            case .Bottom: pinToSuperviewBottom(withInset: constant, priority: priority)
            case .Right: pinToSuperviewRight(withInset: constant, priority: priority)
            }
        }
    }

    func pinToSuperviewTop(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        return alignTopToView(superview, constant: inset, priority: priority)
    }

    func limitToSuperviewTop(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Top,
            relatedBy: .GreaterThanOrEqual,
            toItem: superview, attribute: .Top,
            multiplier: 1, constant: inset
        )

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func pinToSuperviewBottom(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        return alignBottomToView(superview, constant: -inset, priority: priority)
    }

    func limitToSuperviewBottom(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: superview, attribute: .Bottom,
            relatedBy: .GreaterThanOrEqual,
            toItem: self, attribute: .Bottom,
            multiplier: 1, constant: inset
        )

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func pinToSuperviewLeft(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Left,
            relatedBy: .Equal,
            toItem: superview, attribute: .Left,
            multiplier: 1, constant: inset)

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func limitToSuperviewLeft(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Left,
            relatedBy: .GreaterThanOrEqual,
            toItem: superview, attribute: .Left,
            multiplier: 1, constant: inset)

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func pinToSuperviewRight(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: superview, attribute: .Right,
            relatedBy: .Equal,
            toItem: self, attribute: .Right,
            multiplier: 1, constant: inset)

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func limitToSuperviewRight(withInset inset: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: superview, attribute: .Right,
            relatedBy: .GreaterThanOrEqual,
            toItem: self, attribute: .Right,
            multiplier: 1, constant: inset)

        constraint.priority = priority
        superview.addConstraint(constraint)

        return constraint
    }

    func pinViewToMyRight(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func pinViewToMyBottom(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func addSizeConstraints(width width: CGFloat, height: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) {
        addWidthConstraint(withConstant: width, priority: priority)
        addHeightConstraint(withConstant:height, priority: priority)
    }

    func addHeightConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }

    func addMaxHeightConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }

    func addWidthConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }

    func addMaxWidthConstraint(withConstant constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }

    func equalWidthTo(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func equalHeightTo(view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Height,
            relatedBy: .Equal, toItem: view,
            attribute: .Height, multiplier: multiplier,
            constant: constant
        )
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func maxHeightEqualTo(view: UIView, multiplier: CGFloat = 1, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: view, attribute: .Height, multiplier: multiplier, constant: 0)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func positionInContainer(containerView: UIView, insets: UIEdgeInsets) {

        precondition(containerView == self.superview, "containerView is not the superview of self")
        self.translatesAutoresizingMaskIntoConstraints = false

        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal,
            toItem: containerView, attribute: .Top, multiplier: 1.0, constant: insets.top))

        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal,
            toItem: containerView, attribute: .Left, multiplier: 1.0, constant: insets.left))

        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal,
            toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: insets.bottom))

        containerView.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal,
            toItem: containerView, attribute: .Right, multiplier: 1.0, constant: insets.right))

    }

    func centerInContainer(containerView: UIView, margin: CGFloat) {

        let edgeInsets = UIEdgeInsets(top: margin, left: margin, bottom: -margin, right: -margin)
        self.positionInContainer(containerView, insets: edgeInsets)

    }

    func pinToSuperviewEdges(withInset inset: CGFloat = 0) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        self.positionInContainer(superview, insets: edgeInsets)
    }

    func centerInSuperview(withInset inset: CGFloat = 0) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        self.positionInContainer(superview, insets: edgeInsets)
    }

}

extension UIView {

    func centerViewsVertically(view1 view1: UIView, view2: UIView) {
        let topSpacer = UIView()
        let bottomSpacer = UIView()
        self.addSubview(topSpacer)
        self.addSubview(bottomSpacer)
        topSpacer.hidden = true
        bottomSpacer.hidden = true

        topSpacer.pinToSuperviewTop()
        topSpacer.pinViewToMyBottom(view1)
        view1.pinViewToMyBottom(view2)
        view2.pinViewToMyBottom(bottomSpacer)
        bottomSpacer.pinToSuperviewBottom()
        topSpacer.equalHeightTo(bottomSpacer)
    }

}

// MARK: - Attach to Sibling

extension UIView {
    func attachToBottomOf(
        view: UIView,
        withConstant constant: CGFloat = 0,
                     priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Top,
            relatedBy: .Equal,
            toItem: view, attribute: .Bottom,
            multiplier: 1.0, constant: constant
        )

        constraint.priority = priority

        addSiblingConstraint(constraint)

        return constraint
    }

    func limitToBottomOf(
        view: UIView,
        withConstant constant: CGFloat = 0,
                     priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Top,
            relatedBy: .GreaterThanOrEqual,
            toItem: view, attribute: .Bottom,
            multiplier: 1.0, constant: constant
        )

        constraint.priority = priority

        addSiblingConstraint(constraint)

        return constraint
    }

    func attachToRightOf(
        view: UIView,
        withConstant constant: CGFloat = 0,
                     priority: UILayoutPriority = UILayoutPriorityRequired
        ) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(
            item: self, attribute: .Left,
            relatedBy: .Equal,
            toItem: view, attribute: .Right,
            multiplier: 1.0, constant: constant
        )

        constraint.priority = priority

        addSiblingConstraint(constraint)

        return constraint
    }

    private func addSiblingConstraint(constraint: NSLayoutConstraint) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        if let firstItem = constraint.firstItem as? UIView where firstItem != superview {
            firstItem.translatesAutoresizingMaskIntoConstraints = false
        }

        if let secondItem = constraint.secondItem as? UIView where secondItem != superview {
            secondItem.translatesAutoresizingMaskIntoConstraints = false
        }

        superview.addConstraint(constraint)
    }
}


// MARK: Aligning sibling views

extension UIView {

    func alignTopToView(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func alignBottomToView(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func alignLeftToView(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func alignRightToView(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }
        translatesAutoresizingMaskIntoConstraints = false
        if view != superview {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraint = NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: constant)
        constraint.priority = priority
        superview.addConstraint(constraint)
        return constraint
    }

    func alignHorizontalCenter(withView view: UIView, withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .CenterX,
            relatedBy: .Equal,
            toItem: view, attribute: .CenterX,
            multiplier: multiplier, constant: 0
        )

        addSiblingConstraint(constraint)

        return constraint
    }

    func alignHorizontalCenterWithSuperview(withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let superview = unWrappedSuperview()
        return alignHorizontalCenter(withView: superview, withMultiplier: multiplier)
    }

    func alignVerticalCenter(withView view: UIView, withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .CenterY,
            relatedBy: .Equal,
            toItem: view, attribute: .CenterY,
            multiplier: multiplier, constant: 0
        )

        addSiblingConstraint(constraint)

        return constraint
    }

    func alignVerticalCenterWithSuperview(withMultiplier multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        let superview = unWrappedSuperview()
        return alignVerticalCenter(withView: superview, withMultiplier: multiplier)
    }

    private func unWrappedSuperview() -> UIView {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        self.translatesAutoresizingMaskIntoConstraints = false

        return superview
    }

}


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

@IBDesignable
final class StylableButton: UIButton {
    @IBInspectable var shadowColor: UIColor? = nil {
        didSet {
            layer.shadowColor = shadowColor?.CGColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
}
