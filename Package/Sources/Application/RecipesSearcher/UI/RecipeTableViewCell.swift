import SnapKit
import UIKit

struct RecipeModel {
    var name: String
    var instructions: String
}

final class RecipeTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(nameLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    func configure(with recipe: RecipeModel) {
        nameLabel.text = recipe.name
        descriptionLabel.text = recipe.instructions
    }
}

#Preview {
    let cell = RecipeTableViewCell(frame: .init(x: 0, y: 0, width: 320, height: 70))
    cell.configure(with: RecipeModel(name: "Margarita", instructions: "Mueve la fresa y dale"))
    cell.backgroundColor = .red
    return cell
}
