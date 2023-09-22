import UIKit

extension UIView {
    enum ConstraintMode {
        case equal
        case grOE
        case lsOE
    }
    
    // MARK: - Pin left
        @discardableResult
        func pinLeft(
            to otherView: UIView,
            _ const: Double = 0,
            _ mode: ConstraintMode = .equal
        ) ->NSLayoutConstraint {
            pinConstraint(mode: mode, leadingAnchor, otherView.leadingAnchor, constant: const)
        }
    
    // MARK: - Pin left
        @discardableResult
        func pinLeft(
            to anchor: NSLayoutXAxisAnchor,
            _ const: Double = 0,
            _ mode: ConstraintMode = .equal
        ) ->NSLayoutConstraint {
            pinConstraint(mode: mode, leadingAnchor, anchor, constant: const)
        }
    
    // MARK: - Pin right
    @discardableResult
    func pinRight(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, trailingAnchor, otherView.trailingAnchor, constant: -const)
    }

    @discardableResult
    func pinRight(
        to anchor: NSLayoutXAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, trailingAnchor, anchor, constant: -const)
    }

    // MARK: - Pin top
    @discardableResult
    func pinTop(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, topAnchor, otherView.topAnchor, constant: const)
    }

    @discardableResult
    func pinTop(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, topAnchor, anchor, constant: const)
    }

    // MARK: - Pin bottom
    @discardableResult
    func pinBottom(
        to otherView: UIView,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, bottomAnchor, otherView.bottomAnchor, constant: -const)
    }

    @discardableResult
    func pinBottom(
        to anchor: NSLayoutYAxisAnchor,
        _ const: Double = 0,
        _ mode: ConstraintMode = .equal
    ) -> NSLayoutConstraint {
        pinConstraint(mode: mode, bottomAnchor, anchor, constant: -const)
    }

    // MARK: - Pin center
    @discardableResult
    func pinCenterX(
        to otherView: UIView,
        _ const: Double = 0
    ) -> NSLayoutConstraint {
        pinConstraint(mode: .equal, centerXAnchor, otherView.centerXAnchor, constant: const)
    }

    @discardableResult
    func pinCenterY(
        to otherView: UIView,
        _ const: Double = 0
    ) -> NSLayoutConstraint {
        pinConstraint(mode: .equal, centerYAnchor, otherView.centerYAnchor, constant: const)
    }

    // MARK: - Pin width
    @discardableResult
    func pinWidth(
        to otherView: UIView,
        multiplier: Double = 1
    ) -> NSLayoutConstraint {
        pinConstraint(mode: .equal, widthAnchor, otherView.widthAnchor, multiplier: multiplier)
    }

    // MARK: - Pin height
    @discardableResult
    func pinHeight(
        to otherView: UIView,
        multiplier: Double = 1
    ) -> NSLayoutConstraint {
        pinConstraint(mode: .equal, heightAnchor, otherView.heightAnchor, multiplier: multiplier)
    }

    // MARK: - Set width
    @discardableResult
    func setWidth(_ width: Double) -> NSLayoutConstraint {
        pinDimension(mode: .equal, widthAnchor, constant: width)
    }

    // MARK: - Set height
    @discardableResult
    func setHeight(_ height: Double) -> NSLayoutConstraint {
        pinDimension(mode: .equal, heightAnchor, constant: height)
    }
    
    
    // MARK: - Private methods
        @discardableResult
        private func pinConstraint<Axis: AnyObject, AnyAnchor: NSLayoutAnchor<Axis>>(
            mode: ConstraintMode,
            _ firstConstraint: AnyAnchor,
            _ secondConstraint: AnyAnchor,
            constant: Double = 0
        ) -> NSLayoutConstraint {
            let const = CGFloat(constant)
            let result: NSLayoutConstraint

            translatesAutoresizingMaskIntoConstraints = false

            switch mode {
            case .equal:
                result = firstConstraint.constraint(equalTo: secondConstraint, constant: const)
            case .grOE:
                result = firstConstraint.constraint(greaterThanOrEqualTo: secondConstraint, constant: const)
            case .lsOE:
                result = firstConstraint.constraint(lessThanOrEqualTo: secondConstraint, constant: const)
            }

            result.isActive = true
            return result
        }

        @discardableResult
        private func pinConstraint(
            mode: ConstraintMode,
            _ firstConstraint: NSLayoutDimension,
            _ secondConstraint: NSLayoutDimension,
            multiplier: Double = 0
        ) -> NSLayoutConstraint {
            let mult = CGFloat(multiplier)
            let result: NSLayoutConstraint

            translatesAutoresizingMaskIntoConstraints = false

            switch mode {
            case .equal:
                result = firstConstraint.constraint(equalTo: secondConstraint, multiplier: mult)
            case .grOE:
                result = firstConstraint.constraint(greaterThanOrEqualTo: secondConstraint, multiplier: mult)
            case .lsOE:
                result = firstConstraint.constraint(lessThanOrEqualTo: secondConstraint, multiplier: mult)
            }

            result.isActive = true
            return result
        }

        @discardableResult
        private func pinDimension(
            mode: ConstraintMode,
            _ dimension: NSLayoutDimension,
            constant: Double = 0
        ) -> NSLayoutConstraint {
            let const = CGFloat(constant)
            let result: NSLayoutConstraint

            translatesAutoresizingMaskIntoConstraints = false

            switch mode {
            case .equal:
                result = dimension.constraint(equalToConstant: const)
            case .grOE:
                result = dimension.constraint(greaterThanOrEqualToConstant: const)
            case .lsOE:
                result = dimension.constraint(lessThanOrEqualToConstant: const)
            }

            result.isActive = true
            return result
        }

    
}
