import Common
import Factory
import SnapKit
import UIKit

protocol RecipesDetailView: AnyObject {
    func updateState(with state: ViewState<RecipeDetailModel>)
}

final class RecipeDetailViewController: UIViewController, RecipesDetailView {
    @Injected(\.recipeDetailPresenter) var presenter

    private let imageSection = ImageSectionButton()
    private let tagsSection = TagsSectionView()
    private let ingredientsSection = IngredientsSectionView()
    private var viewState: ViewState<RecipeDetailModel> = .loading
    private var recipeDetail: RecipeDetailModel?

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        return sv
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    private let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        instructionsLabel.textColor = .secondaryLabel
        instructionsLabel.numberOfLines = 0
        return instructionsLabel
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]

        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(imageSection)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        imageSection.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.left.right.equalToSuperview()
            make.width.equalTo(view)
            make.height.equalTo(300)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageSection.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(scrollView)
        }
    }

    func updateState(with state: ViewState<RecipeDetailModel>) {
        switch state {
        case .empty:
            print("empty")
        case .loading:
            print("loading")
        case .loaded(let recipe):
            self.recipeDetail = recipe
            configureViews()
        case .failed(let localizedError):
            print("failed \(localizedError.localizedDescription)")
        }
    }

    private func configureViews() {
        guard let recipeDetail = recipeDetail else { return }
        navigationItem.title = recipeDetail.name


        imageSection.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        imageSection.configure(with: recipeDetail)
        nameLabel.text = recipeDetail.name
        instructionsLabel.text = recipeDetail.instructions
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(instructionsLabel)

        if let tags = recipeDetail.tags, !tags.isEmpty {
            tagsSection.configure(with: tags)
            stackView.addArrangedSubview(tagsSection)
        }

        if let ingredients = recipeDetail.ingredients, !ingredients.isEmpty {
            ingredientsSection.configure(with: ingredients)
            stackView.addArrangedSubview(ingredientsSection)
        }
    }

    @objc private func imageTapped() {
        presenter.imageTapped()
    }
}

// TODO: Review preview errors
#Preview {
    let vc = RecipeDetailViewController()
    vc.updateState(with: .loaded(.init(name: "Mojito",
                                       instructions: "Muddle mint leaves with sugar and lime juice. Add a splash of soda water and fill the glass with cracked ice. Pour the rum and top with soda water. Garnish and serve with straw.",
                                       tags: ["IBA", "ContemporaryClassic", "Alcoholic", "USA", "Asia", "Vegan", "Citrus", "Brunch", "Hangover", "Mild"],
                                       thumbnailUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                                       imageUrl: "https://pixabay.com/photos/cocktail-mojito-cocktail-recipe-5096281/",
                                       videoUrl: nil,
                                       ingredients: ["Light rum", "Lime", "Sugar", "Mint", "Soda water"])))
    return UINavigationController(rootViewController: vc)
}
