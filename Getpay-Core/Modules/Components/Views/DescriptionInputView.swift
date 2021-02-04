import UIKit

// MARK: - Class

public final class DescriptionInputView: UIView {
    
    // MARK: - Private variables
    
    private var placeholder: String = "Adicione uma descrição 😊"
        
    // MARK: - Public variables
    
    public lazy var userDescription: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = placeholder
        textView.textColor = GPColors.heyman.color
        textView.isScrollEnabled = false
        textView.font = FontFamily.Calibri.regular.font(size: 16)
        return textView
    }()
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func configure(placeholder: String) {
        self.placeholder = placeholder
    }
}

extension DescriptionInputView {
    
    // MARK: - Private methods
        
    private func setupLayout() {
        addComponents()
        setupUserDescription()
        backgroundColor = GPColors.maggie.color
    }
    
    private func addComponents() {
        addSubview(userDescription, constraints: true)
    }

    private func setupUserDescription() {
        NSLayoutConstraint.activate([
            userDescription.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            userDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            userDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: UITextViewDelegate

extension DescriptionInputView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == GPColors.heyman.color {
            textView.text = nil
            textView.textColor = GPColors.edna.color
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = GPColors.heyman.color
        }
    }
}
