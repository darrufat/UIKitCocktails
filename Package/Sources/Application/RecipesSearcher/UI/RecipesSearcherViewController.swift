import UIKit

final class RecipesSearcherViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)

    var allRecipes: [String] = ["Margarita", "Martini", "Mojito", "Old Fashioned"]
    var filteredRecipes: [String] = []

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
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension RecipesSearcherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredRecipes.count : allRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        let recipe = searchController.isActive ? filteredRecipes[indexPath.row] : allRecipes[indexPath.row]

        cell.configure(with: RecipeModel(name: recipe, instructions: String(repeating: "Instructions example to prepare a \(recipe)\n", count: indexPath.row+2)))

        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension RecipesSearcherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredRecipes = allRecipes.filter { $0.lowercased().contains(searchText.lowercased()) }
        } else {
            filteredRecipes = allRecipes
        }
        tableView.reloadData()
    }
}

#Preview {
    UINavigationController(rootViewController: RecipesSearcherViewController())
}
