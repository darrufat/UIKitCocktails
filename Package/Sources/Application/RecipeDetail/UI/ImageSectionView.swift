import Kingfisher
import SnapKit
import UIKit

final class ImageSectionButton: UIButton {

    private let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let playIcon: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "play.circle.fill")
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit
            imageView.isHidden = true
            return imageView
        }()

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 300)
    }

    var didTapImage: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(thumbnailView)
        addSubview(playIcon)

        thumbnailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(300).priority(.high)
        }

        playIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }

    func configure(with model: RecipeDetailModel) {
        if let url = URL(string: model.thumbnailUrl ?? "") {
            thumbnailView.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }

        playIcon.isHidden = model.videoUrl == nil
    }
}
