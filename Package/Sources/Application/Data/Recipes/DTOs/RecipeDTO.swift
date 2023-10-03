struct DrinksDTO: Codable {
    let drinks: [RecipeDTO]
}

struct RecipeDTO: Codable {
    // TODO: review #jsonModel macro if worth it
    let strDrink: String
    let strInstructions: String
}
