import RxCocoa
import RxSwift
import UIKit

// MARK: - SwitchAnimationDirection

public enum SwitchAnimationDirection {
    case left
    case right
}

// MARK: - Class

public class GPTabButton: UIStackView {
    
    // MARK: - Public variable

    var currentButtonIndex = BehaviorRelay<Int>(value: 0)

    // MARK: - Private Properties

    private var buttons: [UIButton] = [UIButton]()

    private var current: UIButton? {
        didSet {
            current?.isSelected = true
            current?.titleLabel?.font = FontFamily.Calibri.bold.font(size: 16)
        }
    }

    private lazy var lineLeftAnchor = lineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = GPColors.homer.color
        return view
    }()

    private var dBag = DisposeBag()

    // MARK: Initializers

    public init(titles: [String]) {
        super.init(frame: .zero)

        for title in titles {
            let button: UIButton = {
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(GPColors.homer.color, for: .selected)
                button.titleLabel?.font = FontFamily.Calibri.regular.font(size: 16)
                button.setTitleColor(GPColors.krusty.color, for: .normal)
                return button
            }()
            buttons.append(button)
        }

        setupStack()
        setupRx()
        addComponents()
        setupComponents()
    }

    required public init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func animateLine(direction: SwitchAnimationDirection, percentage: CGFloat) {
    
        // starting variables
        guard percentage > 0 else { return }
        guard let current = self.current else { return }
        let origin = current.frame.origin.x
        let buttonWidth = current.frame.width
        var index = buttons.firstIndex(of: current) ?? 0

        // handling direction
        switch direction {
        case .right:
            lineLeftAnchor.constant = origin + (buttonWidth * percentage)
            if index < buttons.count - 1 {
                index += 1
            }
        default:
            lineLeftAnchor.constant = origin - (buttonWidth * percentage)
            if index >= 1 {
                index -= 1
            }
        }

        // animation
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }

        // changing the current button
        if percentage >= 0.51 {
            if let index = buttons.firstIndex(of: current) {
                setCurrent(button: buttons[index], animated: false)
            }
        }
    }

    // MARK: - Internal Methods
    
    func setCurrent(buttonIndex index: Int) {
        guard index < buttons.count else { return }
        let button = buttons[index]
        setCurrent(button: button, animated: true)
    }

    // MARK: - Private Methods
    
    private func setupStack() {
        axis = .horizontal
        distribution = .fillEqually
    }

    private func addComponents() {
        for button in buttons {
            addArrangedSubview(button)
        }
        addSubview(lineView, constraints: true)
        bringSubviewToFront(lineView)
    }

    private func setupRx() {
        for (index, button) in buttons.enumerated() {
            button.rx.tap.bind { [weak self] in
                guard let self = self else { return }
                self.setCurrent(button: button, animated: true)
                self.currentButtonIndex.accept(index)
            }.disposed(by: dBag)
        }
    }

    private func setCurrent(button: UIButton, animated: Bool) {
        current?.isSelected = false
        current?.titleLabel?.font = FontFamily.Calibri.regular.font(size: 16)
        current = button

        guard animated else { return }
        DispatchQueue.main.async {
            self.lineLeftAnchor.constant = button.frame.origin.x
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    private func setupComponents() {
        buttons.first?.isSelected = true
        current = buttons.first

        if let current = current {
            lineView.widthAnchor.constraint(equalTo: current.widthAnchor).isActive = true
        }
        lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        lineLeftAnchor.isActive = true
    }
}
