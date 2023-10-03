import Kingfisher
import SnapKit
import UIKit

final class ImageSectionView: UIView {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let playButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        btn.tintColor = .white
        return btn
    }()

    init() {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(playButton)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        playButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: RecipeDetailModel) {
        if let url = URL(string: model.thumbnailUrl ?? "") {
            imageView.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(0.2))],
                                  completionHandler: nil)
        }

        playButton.isHidden = model.videoUrl == nil
    }
}
