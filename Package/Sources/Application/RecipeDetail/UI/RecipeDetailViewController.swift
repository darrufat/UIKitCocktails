import SnapKit
import UIKit

final class RecipeDetailViewController: UIViewController {

    private let imageSection = ImageSectionView()
    private let tagsSection = TagsSectionView()
    private let ingredientsSection = IngredientsSectionView()

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    // TODO: update state
    var recipeDetail: RecipeDetailModel? {
        didSet {
            configureViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.width.equalTo(view)
        }
    }

    private func configureViews() {
        guard let recipeDetail = recipeDetail else { return }

        imageSection.configure(with: recipeDetail)
        stackView.addArrangedSubview(imageSection)

        if let tags = recipeDetail.tags, !tags.isEmpty {
            tagsSection.configure(with: tags)
            stackView.addArrangedSubview(tagsSection)
        }

        if let ingredients = recipeDetail.ingredients, !ingredients.isEmpty {
            ingredientsSection.configure(with: ingredients)
            stackView.addArrangedSubview(ingredientsSection)
        }
    }
}
