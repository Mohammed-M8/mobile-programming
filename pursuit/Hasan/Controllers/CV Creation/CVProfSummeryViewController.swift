//
//  CVProfSummeryViewController.swift
//  pursuit
//
//  Created by BP-36-201-09 on 19/12/2024.
//

import UIKit

class CVProfSummeryViewController: UIViewController, UITextViewDelegate{
    
   
       
    @IBOutlet weak var ProfSumTxtView: UITextView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            ProfSumTxtView.delegate = self
        }
        
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        private func validateWordCount() -> Bool {
            let text = ProfSumTxtView.text ?? ""
            let words = text.components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
            
            if words.count > 150 {
                showAlert(message: "Word limit exceeded!")
                return false
            }
            return true
        }
        
        // Override prepare for segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if !validateWordCount() {
                // Cancel the segue
                segue.destination.dismiss(animated: true)
                // Show alert
                showAlert(message: "Word limit exceeded!")
            }
        }
        
        // Optional: Real-time validation as user types
        func textViewDidChange(_ textView: UITextView) {
            let words = textView.text.components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
            
            if words.count > 150 {
                showAlert(message: "Word limit exceeded!")
                // Remove words until we're back under the limit
                let validWords = Array(words.prefix(150))
                textView.text = validWords.joined(separator: " ")
            }
        }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


