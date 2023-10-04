import SnapKit
import UIKit

final class TagLabel: UILabel {
    private let horizontalPadding: CGFloat = 10

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.textAlignment = .center
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = .black
        self.snp.makeConstraints { make in
            make.height.equalTo(30) // o cualquier otro valor que desees para la altura
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + 2 * horizontalPadding, height: originalSize.height)
    }
}
