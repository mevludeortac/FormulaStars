//
//  HomeController.swift
//  FormulaStars
//
//  Created by MEWO on 25.04.2022.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var driversTableView: UITableView!
    var drivers = [Items]()
    var choosenDriver : Items?

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON{
            print(self.drivers)
            self.driversTableView.reloadData()
        }
        driversTableView.delegate = self
        driversTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = drivers[indexPath.row].name.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            choosenDriver = drivers[indexPath.row]
            self.performSegue(withIdentifier: "toDetails", sender: nil)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetails"
           {
               let destinationVC = segue.destination as! DriversDetailController
            //destinationVC.selectedDrivers = choosenDriver
           }
       }
    
    func getJSON(completed: @escaping() -> () ){
        let url = URL(string: "https://my-json-server.typicode.com/oguzayan/kuka/drivers")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil {
                do{
                    let driverData = try JSONDecoder().decode(DriverModel.self, from: data!)
                    self.drivers = driverData.items
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch{
                    print("JSON ERROR")
                }
            }
        }
        task.resume()
    }
}
