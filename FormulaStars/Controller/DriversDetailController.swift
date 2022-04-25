//
//  DriversDetailController.swift
//  FormulaStars
//
//  Created by MEWO on 25.04.2022.
//

import UIKit
import SDWebImage

class DriversDetailController: UIViewController {
    
    @IBOutlet weak var driversAge: UILabel!
    @IBOutlet weak var driversImage: UIImageView!
    @IBOutlet weak var driversTeam: UILabel!
    
    var driverDetails : DriverDetailModel?
    var selectedDrivers : Items?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        getDetails { [weak self] fetchedDriverDetail in
            self?.driverDetails = fetchedDriverDetail
            self?.driversAge.text = "\(fetchedDriverDetail.age)"
            self?.driversTeam.text = fetchedDriverDetail.team
            
            let id = fetchedDriverDetail.id
            let imageURL = "https://my-json-server.typicode.com/oguzayan/kuka/driverDetail/?id=\(id)"
            self?.driversImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: ""))
            
        }
    }
    
    func getDetails(completed: @escaping(DriverDetailModel) -> () ){
        let url = URL(string: "https://my-json-server.typicode.com/oguzayan/kuka/driverDetail/?id=1")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil {
                do{
                    let driverDetailData = try JSONDecoder().decode(DriverDetailModel.self, from: data!)
                    
                    completed(driverDetailData)
                    
                } catch{
                    print("JSON ERROR")
                }
            }
        }
        task.resume()
    }



}
