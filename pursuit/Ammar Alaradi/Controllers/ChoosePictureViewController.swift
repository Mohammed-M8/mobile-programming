//
//  ChoosePictureViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 19/12/2024.
//

import UIKit

class ChoosePictureViewController: UIViewController {

    @IBOutlet var imgButtons: [UIButton]!
    var isComingForBG: Bool = true
    var callBack: ((_ picture: String) -> Void)?
    private var selectedTag = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if isComingForBG {
            for index in imgButtons.indices {
                imgButtons[index].setImage(UIImage(named: "background\(index+1)"), for: .normal)
            }
        } else {
            for index in imgButtons.indices {
                    imgButtons[index].setImage(UIImage(named: "profile\(index+1)"), for: .normal)
                }
        }
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let callBack {
            callBack("\(isComingForBG ? ("background\(selectedTag)") : "profile\(selectedTag)")")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imgButtonTapped(_ sender: UIButton) {
        selectedTag = sender.tag
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
