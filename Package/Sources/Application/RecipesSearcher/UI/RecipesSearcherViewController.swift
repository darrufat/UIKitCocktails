import Factory
import UIKit

// TODO: Move it to CommonUI
public enum ViewState<T> {
    case empty
    case loading
    case loaded(T)
    case failed(LocalizedError)
}

protocol RecipesSearcherView: AnyObject {
    func updateState(with state: ViewState<[RecipeCellModel]> )
}

final class RecipesSearcherViewController: UIViewController, RecipesSearcherView {
    @Injected(\.recipesSearcherPresenter) var presenter

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewState: ViewState<[RecipeCellModel]> = .empty
    private var recipes: [RecipeCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeCell")

        view.addSubview(tableView)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cocktails" // TODO: Add localization solution (L10n?)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Cocktail Recipes"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }

    func updateState(with state: ViewState<[RecipeCellModel]>) {
        switch state {
        case .empty:
            print("empty")
        case .loading:
            print("loading")
        case .loaded(let recipes):
            self.recipes = recipes
            tableView.reloadData()
        case .failed(let localizedError):
            print("failed \(localizedError.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension RecipesSearcherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension RecipesSearcherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        presenter.searchRecipes(for: searchText)
    }
}

#Preview {
    let vc = RecipesSearcherViewController()
    vc.updateState(with: .loaded([
        .init(name: "Margarita", instructions: "Instructions to do a Margarita", thumbnailUrl: nil),
        .init(name: "Mojito", instructions: "Instructions to do a Mojito", thumbnailUrl: nil),
        .init(name: "Sex on the beach", instructions: "Instructions to do a Sex on the beach", thumbnailUrl: nil),
    ]))
    return UINavigationController(rootViewController: vc)
}
