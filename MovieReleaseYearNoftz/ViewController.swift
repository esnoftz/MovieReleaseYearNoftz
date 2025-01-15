//
//  ViewController.swift
//  MovieReleaseYearNoftz
//
//  Created by EVANGELINE NOFTZ on 1/14/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var releaseDateOutlet: UILabel!
    
    @IBOutlet weak var movieChoiceTextField: UITextField!
    
    var movieName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getMovie()
    }
    
    func getMovie() {
        //var movieName = "Ghost"
        let session = URLSession.shared

        let movieURL = URL(string: "http://www.omdbapi.com/?t=\(movieName)&apikey=bf06009d")!
        
        // must allow arbitrary load
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            if let e = error {
                print("Error \(e)")
            } else {
                if let d = data {
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as! NSDictionary {
                        //print("working.")
                        print(jsonObj)
                        
                        if let theTitle = jsonObj.value(forKey: "Title") {
                            if let theYear = jsonObj.value(forKey: "Year") {
                                // happens on the main thread
                                DispatchQueue.main.async {
                                    self.releaseDateOutlet.text = "\(self.movieName) was released in \(theYear)"
                                }
                            }
                            
                        } else {
                            DispatchQueue.main.async {
                                self.releaseDateOutlet.text = "That movie does not exist!"
                            }
                            
                        }
                        
                    } else {
                        print("Error converting to json")
                    }
                    
                } else {
                    print("Error fetching data")
                }
                
            }
            
        }
        
        dataTask.resume()
        
        
    }
    
    
    @IBAction func chooseMovieAction(_ sender: UIButton) {
        self.movieName = movieChoiceTextField.text!
        getMovie()
    }
    
    
}

