import Kingfisher
import SnapKit
import UIKit

final class RecipeTableViewCell: UITableViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()

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
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        thumbnailImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(with recipe: RecipeCellModel) {
        nameLabel.text = recipe.name
        descriptionLabel.text = recipe.instructions
        let placeholder = UIImage(systemName: "wineglass")
        if let imageUrl = recipe.thumbnailUrl, let url = URL(string: imageUrl) {
            thumbnailImageView.kf.setImage(with: url, placeholder: placeholder)
        } else {
            thumbnailImageView.image = placeholder
        }
    }
}

#Preview {
    let cell = RecipeTableViewCell(frame: .init(x: 0, y: 0, width: 320, height: 70))
    cell.configure(with: RecipeCellModel(name: "Margarita", instructions: "Instructions to do a Margarita \nInstructions to do a Margarita \nInstructions to do a Margarita \nInstructions to do a Margarita \n", thumbnailUrl: nil))
    cell.snp.makeConstraints { make in
        make.height.equalTo(120)
    }
    return cell
}
