//
//  EditProfileJobSeekerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 04/12/2024.
//

import UIKit

class EditProfileJobSeekerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate{
    @IBOutlet weak var AddSkills: UIButton!
    @IBOutlet weak var SkillsStackView: UIStackView!
    @IBOutlet weak var mainstackview: UIStackView!
    @IBOutlet weak var SkillName: UITextField!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var Percentage: UILabel!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet var editProfileView: UIView!
    @IBOutlet var viewProfileView: UIView!
    @IBOutlet weak var showFirstname: UILabel!
    @IBOutlet weak var InputName: UITextField!
    
    //variable to hold name
    var savedName: String?
    // Array to store skills
        private var skills: [(name: String, percentage: Int)] = []
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    let options = ["The Capital", "Northern", "Southern", "Muharraq"]
        var isDropdownVisible = false
    

    @IBAction func action(_ sender: UIBarButtonItem) {
//        sender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                optionsTableView.delegate = self
                optionsTableView.dataSource = self
                optionsTableView.isHidden = true // Initially hide the dropdown options
        if let checkname = savedName {
               showFirstname.text = checkname
            viewProfileView.isHidden = true
        }
        
            
    }
    
    @IBAction func dropdownTapped(_ sender: Any) {
        isDropdownVisible.toggle()
                optionsTableView.isHidden = !isDropdownVisible
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return options.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = options[indexPath.row]
            return cell
        }

        // MARK: - UITableView Delegate Method

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedOption = options[indexPath.row]
            dropdownButton.setTitle(selectedOption, for: .normal) // Set the button title to the selected option
            isDropdownVisible = false
            optionsTableView.isHidden = true // Hide the dropdown options
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
   

        @IBAction func AddSkill(_ sender: UIButton) {
            addSkillInput()
        }

    private func addSkillInput() {
            if skills.count < 3 {
                // Create a new skill view and add it to the main stack view
                let skillInputView = createSkillInputView()
                mainstackview.addArrangedSubview(skillInputView)
            } else {
                let alert = UIAlertController(title: "Limit Reached", message: "You can only add up to 3 skills.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }

        private func createSkillInputView() -> UIView {
            let skillView = UIView()
            skillView.translatesAutoresizingMaskIntoConstraints = false

            // Create outlets for the skill input view
            let skillName = UITextField()
            skillName.placeholder = "Skill Name"
            skillName.borderStyle = .roundedRect
            skillName.translatesAutoresizingMaskIntoConstraints = false

            let deleteButton = UIButton(type: .system)
            deleteButton.setTitle("-", for: .normal)
            deleteButton.tintColor = .red
            deleteButton.addTarget(self, action: #selector(deleteSkill(_:)), for: .touchUpInside)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true // Fixed width for delete button

            let percentageLabel = UILabel()
            percentageLabel.text = "0%"
            percentageLabel.translatesAutoresizingMaskIntoConstraints = false

            let slider = UISlider()
            slider.minimumValue = 0
            slider.maximumValue = 100
            slider.value = 0
            slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
            slider.translatesAutoresizingMaskIntoConstraints = false

            // Add subviews
            skillView.addSubview(skillName)
            skillView.addSubview(slider)
            skillView.addSubview(percentageLabel)
            skillView.addSubview(deleteButton)

            // Set up constraints
            NSLayoutConstraint.activate([
                skillName.leadingAnchor.constraint(equalTo: skillView.leadingAnchor),
                skillName.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -8),
                skillName.centerYAnchor.constraint(equalTo: skillView.centerYAnchor),

                slider.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
                slider.centerYAnchor.constraint(equalTo: skillView.centerYAnchor),
                slider.widthAnchor.constraint(equalToConstant: 100),

                percentageLabel.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -8),
                percentageLabel.centerYAnchor.constraint(equalTo: skillView.centerYAnchor),

                deleteButton.trailingAnchor.constraint(equalTo: skillView.trailingAnchor),
                deleteButton.centerYAnchor.constraint(equalTo: skillView.centerYAnchor)
            ])

            return skillView
        }

        @objc private func sliderValueChanged(_ sender: UISlider) {
            let percentage = Int(sender.value)
            if let skillView = sender.superview {
                // Find the corresponding percentage label
                for subview in skillView.subviews {
                    if let label = subview as? UILabel {
                        label.text = "\(percentage)%"
                    }
                }
            }
        }

        @objc private func deleteSkill(_ sender: UIButton) {
            if let skillView = sender.superview {
                mainstackview.removeArrangedSubview(skillView)
                skillView.removeFromSuperview()
            }
        }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // Check if the input name is valid
               if let name = InputName.text, !name.isEmpty {
                   // Update the label with the new name
                   showFirstname.text = name
                   
               } else {
                   // Handle empty name case
                   let alert = UIAlertController(title: "Error", message: "Please enter a name.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default))
                   present(alert, animated: true)
               }
           }
    
    
    }

   
   
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


