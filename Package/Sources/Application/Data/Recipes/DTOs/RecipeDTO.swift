struct DrinksDTO: Decodable {
    let drinks: [RecipeDTO]
}

struct RecipeDTO: Decodable {
    let idDrink: String
    let strDrink: String
    let strInstructions: String
    let strTags: String?
    let strDrinkThumb: String?
    let strImageSource: String?
    let strVideo: String?
    var ingredients: [String]?

    enum CodingKeys: String, CodingKey {
        case idDrink, strDrink, strDrinkThumb, strInstructions, strTags, strImageSource, strVideo
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idDrink = try container.decode(String.self, forKey: .idDrink)
        strDrink = try container.decode(String.self, forKey: .strDrink)
        strDrinkThumb = try container.decode(String.self, forKey: .strDrinkThumb)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        strVideo = try container.decodeIfPresent(String.self, forKey: .strVideo)

        var ingredientsList = [String]()
        for i in 1...15 {
            guard 
                let key = CodingKeys(rawValue: "strIngredient\(i)"),
                let ingredient = try container.decodeIfPresent(String.self, forKey: key)
            else {
                break
            }
            ingredientsList.append(ingredient)
        }
        ingredients = ingredientsList
    }
}
