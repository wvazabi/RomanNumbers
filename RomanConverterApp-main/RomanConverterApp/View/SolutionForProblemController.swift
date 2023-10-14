//
//  ViewController.swift
//  RomanConverterApp
//
//  Created by Kaan Yıldırım on 14.10.2023.
//

import UIKit

class SolutionForProblemController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var resultArray: [String] = []
    var isFavourite = false
    
    var convert = RomanToInt()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        answerLabel.layer.shadowOpacity = 0.5
        answerLabel.layer.shadowRadius = 2
        answerLabel.layer.shadowOffset = CGSize.zero
        answerLabel.layer.shadowColor = UIColor.systemGray.cgColor
        
        tableView.layer.cornerRadius = 10
        
    }
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        textField.text = ""
        answerLabel.text = ""
    }
    @IBAction func answerButtonClicked(_ sender: Any) {
        answerLabel.text = String(convert.convertRomanToInt(textField.text ?? "Empty"))
    }
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        resultArray.append("Roman Num: \(textField.text!.uppercased()) -> Result: \(answerLabel.text!)")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: TableView
extension SolutionForProblemController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let data = resultArray[indexPath.row]
        cell.titleLabel.text = data
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            resultArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

