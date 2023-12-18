//
//  DetailViewController.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 04.07.2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func changeStatus(with id: Int, to status: String)
    func changeLocation(with id: Int, to location: String)
}

class DetailViewController:
    UIViewController {

    var data: CharacterResponseModel? {
        didSet {
            guard let data else { return }
            setUpData(data)
        }
    }

    var delegate: DetailViewControllerDelegate?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    func setUpData(_ data: CharacterResponseModel) {
        imageView.download(from: data.image)
        nameLabel.text = "Name: " + data.name
        idLabel.text = "ID: " + String(data.id)
        statusLabel.text = "Status: " + data.status
        speciesLabel.text = "Species: " + data.species
        genderLabel.text =  "Gender: " + data.gender
        locationLabel.text = "Location: " + data.location.name
    }

    @IBAction func statusButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Select a new status", message: nil, preferredStyle: .actionSheet)
        let alive = UIAlertAction(title: "Alive", style: .default) { (action) in
                self.data?.status = "Alive"

                guard let data = self.data else { return }
                guard let newStatus = self.data?.status else { return }
                self.delegate?.changeStatus(with: data.id, to: newStatus)
            }
            let dead = UIAlertAction(title: "Dead", style: .default) { (action) in
                self.data?.status = "Dead"

                guard let data = self.data else { return }
                guard let newStatus = self.data?.status else { return }
                self.delegate?.changeStatus(with: data.id, to: newStatus)
            }
        let unknown = UIAlertAction(title: "Unknown", style: .default) { (action) in
                self.data?.status = "Unknown"

                guard let data = self.data else { return }
                guard let newStatus = self.data?.status else { return }
                self.delegate?.changeStatus(with: data.id, to: newStatus)
        }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(alive)
            alertController.addAction(dead)
            alertController.addAction(unknown)
            alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func locationButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter a new location", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "New location"
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                if let newValue = alertController.textFields?[0].text {
                    self.data?.location.name = newValue

                    guard let data = self.data else { return }
                    guard let newLocation = self.data?.location.name else { return }
                    self.delegate?.changeLocation(with: data.id, to: newLocation)

                }
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}
