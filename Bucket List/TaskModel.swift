//  TaskModel.swift
//  Bucket List

import Foundation

class TaskModel {
    //This function will allow the ViewController that calls this method to dictate what runs upon completion
    // get data from api
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
       // let url = URL(string: "http://localhost:8000/tasks")
        // Specify the url that we will be sending the GET Request to
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/?format=json")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which 'll request some data from a URL & then
        // run the completion handler that we're passing into the getAllTasks func
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // This is the line that makes the request that we set up above
        task.resume()
    }
    
    // post (add) data in api
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     // Create the url to request
            if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/?format=json") {
                // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                var request = URLRequest(url: urlToReq)
                // Set the method to POST
                request.httpMethod = "POST"
                // Create some bodyData and attach it to the HTTPBody
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
                // Create the session
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }

    // update an item in the api
    static func updateTask(id: Int,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
         // Create the url to request
                if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                    // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                    var request = URLRequest(url: urlToReq)
                    // Set the method to PUT
                    request.httpMethod = "PUT"
                    // Create some bodyData and attach it to the HTTPBody
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                    request.setValue("application/json", forHTTPHeaderField: "Accept")
                    // Create some bodyData and attach it to the HTTPBody
                    let bodyData = "{\"objective\":\"\(objective)\"}"
                    request.httpBody = bodyData.data(using: .utf8)
                    // Create the session
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
    }
    
    // delete an item in the api
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
         // Create the url to request
                if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)/") {
                    // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                    var request = URLRequest(url: urlToReq)
                    // Set the method to DELETE
                    request.httpMethod = "DELETE"
                    // Create some bodyData and attach it to the HTTPBody
                    let bodyData = "id=\(id)"
                    request.httpBody = bodyData.data(using: .utf8)
                    // Create the session
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
    }
    
}
