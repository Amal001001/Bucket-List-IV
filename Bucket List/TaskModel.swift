//  TaskModel.swift
//  Bucket List

import Foundation

class TaskModel {
    //This function will allow the ViewController that calls this method to dictate what runs upon completion
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
       // let url = URL(string: "http://localhost:8000/tasks")
        // Specify the url that we will be sending the GET Request to
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which 'll request some data from a URL & then run the completion handler that we're passing into the getAllTasks func
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // This is the line that makes the request that we set up above
        task.resume()
    }
    
}
