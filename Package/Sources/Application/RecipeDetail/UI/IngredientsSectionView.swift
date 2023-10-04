import SnapKit
import UIKit

final class IngredientsSectionView: UIView {
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Ingredients"
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()

    let ingredientsLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()

    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(ingredientsLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with ingredients: [String]) {
        let bulletList = ingredients.map { "• \($0)" }.joined(separator: "\n")
        ingredientsLabel.text = bulletList
    }
}
