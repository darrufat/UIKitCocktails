import Common
import SnapKit
import UIKit

protocol RecipesDetailView: AnyObject {
    func updateState(with state: ViewState<RecipeDetailModel>)
}

final class RecipeDetailViewController: UIViewController, RecipesDetailView {

    private let imageSection = ImageSectionButton()
    private let tagsSection = TagsSectionView()
    private let ingredientsSection = IngredientsSectionView()
    private var viewState: ViewState<RecipeDetailModel> = .loading
    private var recipeDetail: RecipeDetailModel?

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    private let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        instructionsLabel.textColor = .darkGray
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageSection)
        scrollView.addSubview(stackView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        imageSection.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageSection.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalToSuperview()
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
//
//        if let ingredients = recipeDetail.ingredients, !ingredients.isEmpty {
//            ingredientsSection.configure(with: ingredients)
//            stackView.addArrangedSubview(ingredientsSection)
//        }
    }

    @objc private func imageTapped() {
        if let videoURL = URL(string: recipeDetail?.videoUrl ?? "") {
            UIApplication.shared.open(videoURL)
        } else if let imageURL = URL(string: recipeDetail?.imageUrl ?? "") {
            UIApplication.shared.open(imageURL)
        }
    }
}

#Preview {
    let vc = RecipeDetailViewController()
    vc.updateState(with: .loaded(.init(name: "Margarita",
                            instructions: "How to do a Margarita",
                            tags: ["Sweet", "Exotic", "Mexican", "Cold", "Lemon"],
                            thumbnailUrl: nil,
                            imageUrl: nil,
                            videoUrl: nil,
                            ingredients: nil)))
    return UINavigationController(rootViewController: vc)
}
