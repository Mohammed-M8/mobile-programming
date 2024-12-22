//
//  FilterPageViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 22/12/2024.
//
import UIKit

class FilterPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var jobRoles = ["Designer", "JavaScript Developer", "Project Manager", "QA Engineer"]
    
    // Collection View
    var collectionView: UICollectionView!
    
    // Page Control
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        setupPageControl()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobRoles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterApplicantCollectionViewCell.identifier, for: indexPath) as? FilterApplicantCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let role = jobRoles[indexPath.item]
        cell.button.setTitle(role, for: .normal)
        
        // Optional: Add target for button action
        cell.button.tag = indexPath.item
        cell.button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        let role = jobRoles[sender.tag]
        print("Filter selected: \(role)")
        // Handle filter selection
    }
    
    // Dynamic sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate size based on text
        let role = jobRoles[indexPath.item]
        let padding: CGFloat = 20 // Padding inside the button
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let textWidth = role.size(withAttributes: [NSAttributedString.Key.font: font]).width
        return CGSize(width: textWidth + padding, height: 40)
    }
    
    // Update page control on scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + (0.5 * pageWidth)) / pageWidth)
        pageControl.currentPage = currentPage
    }
    
    func setupCollectionView() {
        // Initialize flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // Initialize collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterApplicantCollectionViewCell.self, forCellWithReuseIdentifier: FilterApplicantCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        
        // Constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.numberOfPages = calculateNumberOfPages()
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        view.addSubview(pageControl)
        
        // Constraints
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func calculateNumberOfPages() -> Int {
        // Calculate based on total width and content
        // For simplicity, assume a fixed width per page
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerPage = floor(screenWidth / 100) // Approximate number
        return Int(ceil(Double(jobRoles.count) / Double(itemsPerPage)))
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let xOffset = CGFloat(page) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    // Cell configuration
    
}
