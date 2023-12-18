//
//  ViewController.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 04.07.2023.
//

import UIKit

enum CharacterListState {
    case data
    case error
    case fatalError
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let manager: NetworkManagerProtocol = NetworkManger()
    private var data: [CharacterResponseModel]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadCharacters()
    }
    
    private func loadCharacters() {
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                self.data = response
                self.updateCharactersListState(.data)
                self.reloadData()
            case .failure:
                self.updateCharactersListState(.error)
            }
        }
    }
    
    func updateCharactersListState(_ state: CharacterListState) {
        switch state {
        case .data:
            tableView.isHidden = false
        case .error:
            tableView.isHidden = false
        case .fatalError:
            tableView.isHidden = true
        }
    }

    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        detailViewController.delegate = self

        present(detailViewController, animated: true)

        detailViewController.data = data?[indexPath.row]
        
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { fatalError("Couldn't register cell") }
        
        if let cellData = data?[indexPath.row] {
            characterCell.setUpData(cellData)
        }
        return characterCell
    }
    
    // MARK: - DetailViewControllerDelegate
    
    func changeStatus(with id: Int, to status: String) {
        if let index = data?.firstIndex(where: { $0.id == id }) {
            data?[index].status = status
            tableView.reloadData()
        }

        dismiss(animated: true)
    }

    func changeLocation(with id: Int, to location: String) {
        if let index = data?.firstIndex(where: { $0.id == id }) {
            data?[index].location.name = location
            tableView.reloadData()
        }

        dismiss(animated: true)
    }

}
