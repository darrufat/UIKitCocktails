import SnapKit
import UIKit

final class TagsSectionView: UIView {
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    init() {
        super.init(frame: .zero)
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with tags: [String]) {
        for tag in tags {
            let label = UILabel()
            label.text = tag
            label.backgroundColor = .systemGray4
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
            stackView.addArrangedSubview(label)

            label.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
    }
}
