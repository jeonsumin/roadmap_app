//
//  PlaceListView.swift
//  roadmap
//
//  Created by deepvisions on 2022/12/06.
//

import UIKit
import SnapKit

class PlaceListView: BaceView {
    
    private let tableView = UITableView()
    
    override func configureUIComponents() {
        [tableView].forEach{
            addSubview($0)
            
            $0.snp.makeConstraints{
                $0.top.leading.trailing.equalToSuperview()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PlaceListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = UITableViewCell()
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    
}
