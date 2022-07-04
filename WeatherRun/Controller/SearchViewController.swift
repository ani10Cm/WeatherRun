//
//  SearchViewController.swift
//  WeatherRun
//
//  Created by Aniket Kumar on 01/07/22.
//

import UIKit

protocol SearchViewDelegate {
    func getTheCityName(city : String)
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var delegate : SearchViewDelegate?
    var weatherManager = WeatherManager()
    
    let cityArray = ["Delhi", "Gurugram", "Mumbai", "Bangalore", "Hyderabad", "Ahmedabad", "Chennai", "Kolkata", "Surat", "Pune", "Jaipur", "Lucknow", "Kanpur", "Nagpur", "Indore", "Thane", "Bhopal", "Patna", "Agra", "Ranchi", "Meerut", "Varanasi", "Srinagar", "Amritsar", "Allahabad", "Jodhpur", "Chandigarh", "Aligarh", "Bhubaneswar", "Gorakhpur", "Agra" ,"Ajmer", "Ujjain"]
    
    var filteredCity : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredCity = cityArray
        searchBar.delegate = self
    }
    
}

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getTheCityName(city: filteredCity[indexPath.row])
        dismiss(animated: true)
    }
}

extension SearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityRow", for: indexPath)
        
        let item = filteredCity[indexPath.row]
        
        cell.textLabel?.text = item
        
        return cell
    }
    
}

extension SearchViewController :  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCity = []
        
        if searchText == "" {
            filteredCity = cityArray
        }
        
        for word in cityArray {
            if word.uppercased().contains(searchText.uppercased()){
                filteredCity.append(word)
            }
        }
        
        self.tableView.reloadData()
    }
}
