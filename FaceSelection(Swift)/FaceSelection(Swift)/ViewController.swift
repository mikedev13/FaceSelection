//
//  ViewController.swift
//  FaceSelection(Swift)
//
//  Created by Mike Forster on 5/18/18.
//

import UIKit

class ViewController: UIViewController {
    let fileManager = FileManager.default
    var jsonStorage = [PhotoData]()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Asynchronous image retrival and load to image view
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/precious-interview/ios-face-selection/family.jpg")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
                self.saveDataToDirectory(fileName: "image", fileExtension: "jpeg", data: data!)
            }
        }
        
        //Retrive JSON Data
        let jsonUrlString: String = "https://s3-us-west-2.amazonaws.com/precious-interview/ios-face-selection/family_faces.json"
        guard let jsonUrl = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: jsonUrl) { (data, response, err) in
            guard let data = data else { return }
            do {
                print("Sucess!")
                let decodedData = try JSONDecoder().decode(Array<PhotoData>.self, from: data)
                self.jsonStorage = decodedData
                print(self.jsonStorage)
                self.saveDataToDirectory(fileName: "face_metadata", fileExtension: "json", data: data)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
        
    }
    
    func saveDataToDirectory(fileName: String, fileExtension: String, data: Data) {
        let fileName = fileName
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        fileManager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
    }
    
 
}

