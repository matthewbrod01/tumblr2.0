//
//  PhotosViewController.swift
//  tumblr2.0
//
//  Created by Matthew Rodriguez on 2/13/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [[String: Any]]()
    var isMoreDataLoading: Bool = false
    var loadingMoreView: InfiniteScrollActivityView?
    var postsOffset = 20 //initial number of posts to get
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250 // set to cell height since we are not using auto-layout
        
        setUpLoadingIndicator()
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                self.tableView.reloadData() // refreshes after our network data comes back in
            }
        }
        task.resume()
    }
    
    func setUpLoadingIndicator() {
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    func loadMoreData() {
        
        // ... Create the NSURLRequest (myRequest) ...
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?offset=\(self.postsOffset)&api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        self.postsOffset += 1
        let myRequest = URLRequest(url: url)
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate:nil,
                                 delegateQueue:OperationQueue.main
        )
        let task : URLSessionDataTask = session.dataTask(with: myRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if data != nil {
                // Update flag
                self.isMoreDataLoading = false
                
                // Stop the loading indicator
                self.loadingMoreView!.stopAnimating()
                
                // ... Use the new data to update the data source ...
                let dataDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                let newPosts = responseDictionary["posts"] as! [[String: Any]]
                self.posts.append(contentsOf: newPosts)
                
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // instead of returning rows, we are now returning sections
        // NOTE WE NOW NEED TO UPDATE numberOfRowsInSection and cellForRowAt indexPath
        // for this tumblr app, each section will just contain 1 row
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return posts.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // Set the avatar
        // Note JSON doesn't have individual profile images for each post
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        
        // Add a UILabel for the date here
        // Use the section number to get the right URL
        // let label = ...
        let label = UILabel(frame: CGRect(x: 50, y: 0, width: 300, height: 50))
        label.text = posts[section]["date"] as? String
        
        /*
        // add border just for visibility
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        */
        
        // Add subviews
        headerView.addSubview(label)
        headerView.addSubview(profileView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        //cell.textLabel!.text = "row: \(indexPath.row)"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        //let post = posts[indexPath.row] // possible to get a nil value
        let post = posts[indexPath.section] // when we are indexing the posts dictionary, we index thru section now
        if let unwrappedPhotos = post["photos"] as? [[String: Any]]{
            // Unwraps post. This code block only runs if value != nil
            let photo = unwrappedPhotos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.posterView.af_setImage(withURL: url!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get rid of the gray selection effect by deselecting the cell with animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // This function runs many times when user scrolls. We only want this code to run when no more data is loading, hence we set up a flag variable
        if (!isMoreDataLoading) { //load more results
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                loadMoreData()
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /***** ---------------- STEPS TO SEND DATA: -----------------*****/
        /***** Get the new view controller using segue.destination.  *****/
        /***** Pass some selected object to the new view controller. *****/
        
        // Note: we want to send a photo url string to our detail view controller
        
        // First get a reference to the receiving view controller
        let vc = segue.destination as! PhotoDetailsViewController
        
        // Get the cell that triggered the segue (I think both lines below work?)
        let cell = sender as! PhotoCell
        //let cell = sender as! UITableViewCell
       
        // Get the photo's url string through the JSON file
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.section] //since we are using section headers, we don't use row now
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            
            // Pass the selected object to the new view controller.
            vc.photoUrlString = urlString
        }
    }
}
