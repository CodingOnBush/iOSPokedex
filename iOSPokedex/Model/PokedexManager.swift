//
//  PokedexManager.swift
//  iOSPokedex
//
//  Created by VegaPunk on 23/03/2023.
//

import Foundation

struct PokedexManager {
  let baseUrl = "https://pokebuildapi.fr/api/v1/pokemon/limit/"
  
  var delegate: PokedexManagerDelegate?
  
  func fetchPokemonList(of pokemonNumber: Int) {
    let url = "\(baseUrl)\(pokemonNumber)"
    performURL(with: url)
  }
  
  func performURL(with urlString: String) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      
      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          print(error!)
        }
        
        if let safeData = data {
          parsePokemonListJSON(with: safeData)
        }
      }
      
      task.resume()
    }
  }
  
  func parsePokemonListJSON(with pokemonData: Data) {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode([PokemonResponse].self, from: pokemonData)
      var pokemonList: [PokemonModel] = []
      for data in decodedData {
        let name = data.name
        let id = data.id
        let imgUrl = data.image
        pokemonList.append(PokemonModel(name: name, id: id, imgUrl: imgUrl))
      }
      self.delegate?.didWeFetchPokemonList(self, pokemonList: pokemonList)
    } catch {
      self.delegate?.didWeFailFetchPokemonList(error: error)
    }
  }
}
