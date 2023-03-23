//
//  ViewController.swift
//  iOSPokedex
//
//  Created by VegaPunk on 23/03/2023.
//

import UIKit

protocol PokedexManagerDelegate {
  func didWeFetchPokemonList(_ pokedexManager: PokedexManager, pokemonList: [PokemonModel])
  func didWeFailFetchPokemonList(error: Error)
}

class ViewController: UIViewController {
  
  var pokedexManager = PokedexManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokedexManager.delegate = self
    pokedexManager.fetchPokemonList(of: 5)
  }
}

extension ViewController: PokedexManagerDelegate {
  func didWeFetchPokemonList(_ pokedexManager: PokedexManager, pokemonList: [PokemonModel]) {
    DispatchQueue.main.async {
      for pokemon in pokemonList {
        print("\(pokemon.id) - \(pokemon.name)")
      }
    }
  }
  
  func didWeFailFetchPokemonList(error: Error) {
    print(error)
  }
}
