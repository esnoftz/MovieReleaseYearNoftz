//
//  ViewController.swift
//  MovieReleaseYearNoftz
//
//  Created by EVANGELINE NOFTZ on 1/14/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovie()
    }
    
    func getMovie() {
        let session = URLSession.shared

        let movieURL = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=bf06009d")!
        
        // must allow arbitrary load
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            if let e = error {
                print("Error \(e)")
            } else {
                if let d = data {
                    
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as! NSDictionary {
                        //print("working.")
                        print(jsonObj)
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
    
    
}

