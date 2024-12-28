//
//  ContentPersonalizationViewController.swift
//  pursuit
//
//  Created by Hasan Zaman on 28/12/2024.
//

import UIKit

class ContentPersonalizationViewController: UIViewController {
    
    @IBOutlet var Intrested: [UIButton]!
    
    @IBOutlet var location: [UIButton]!
    
    
        var skipButton: UIBarButtonItem!
        var filterButton: UIBarButtonItem!
    
    private let customColor = UIColor(
            red: 24/255.0,
            green: 116/255.0,
            blue: 148/255.0,
            alpha: 1.0
        )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Create your two bar button items
        skipButton = UIBarButtonItem(
            title: "Skip",
            style: .plain,
            target: self,
            action: #selector(skipTapped)
        )
        filterButton = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterTapped)
        )
        
        // 2. Show only the "Skip" button by default
        navigationItem.rightBarButtonItem = skipButton

               for button in Intrested {
                   button.addTarget(self, action: #selector(anyInterestOrLocationButtonTapped(_:)), for: .touchUpInside)
               }

               for button in location {
                   button.addTarget(self, action: #selector(anyInterestOrLocationButtonTapped(_:)), for: .touchUpInside)
               }
    }
    
    @objc func anyInterestOrLocationButtonTapped(_ sender: UIButton) {

            if let currentItems = navigationItem.rightBarButtonItems {
                // If filterButton is not in the current array, add it
                if !currentItems.contains(filterButton) {
                    navigationItem.rightBarButtonItems = [skipButton, filterButton]
                }
            } else {
                // If there are no items, add them fresh
                navigationItem.rightBarButtonItems = [skipButton, filterButton]
            }
            
            // 2) Change the tapped button’s appearance to indicate selection
        sender.backgroundColor = customColor         // pick any color you like
        sender.setTitleColor(.white, for: .normal) // text color
        }
    
    @objc func skipTapped() {
            
        
        }

        @objc func filterTapped() {
            // Handle filter action...
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
