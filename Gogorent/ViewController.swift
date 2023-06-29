//
//  ViewController.swift
//  Gogorent
//
//  Created by Henry Tseng on 2023/6/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var stepIndex = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    private var dataSource: [Step] {
        Array(Step.fullSteps.prefix(stepIndex))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        stepIndex = (stepIndex + 1) % (Step.fullSteps.count + 1)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stepData = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: stepData.cellIdentifier, for: indexPath)
        switch stepData.value {
        case .userInput(let str):
            let inputCell = cell as! UserInputCell
            inputCell.userInputLabel.text = str
            
        case .request(let str):
            let requestCell = cell as! RequestCell
            requestCell.requestLabel.text = str
            
        case .result(let str, let imageNames):
            let resultCell = cell as! ResultCell
            resultCell.resultLabel.text = str
            resultCell.imageNames = imageNames
            if indexPath.row == dataSource.count - 1 {
                resultCell.playLoadingAnimation()
            }
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stepData = dataSource[indexPath.row]
        switch stepData.value {
        case .result:
            present(ImageShuffleViewController(), animated: true)
        default:
            break
        }
    }
}

struct Step {
    enum ValueType {
        case userInput(String)
        case request(String)
        case result(String, [String])
    }
    
    let value: ValueType
    
    var cellIdentifier: String {
        switch value {
        case .userInput:
            return "UserInputCell"
        case .request:
            return "RequestCell"
        case .result:
            return "ResultCell"
        }
    }
    
    static var fullSteps: [Step] {
        [
            .init(value: .userInput("我想租離到 XX 地點，車程約 20min 內的房子")),
            .init(value: .request("您希望自行開車還是大眾交通工具？")),
            .init(value: .userInput("開車")),
            .init(value: .result("以下是推薦的房源", ["room1", "room2", "room3", "room4"])),
            .init(value: .userInput("我有養貓，幫我過濾可以養貓的房")),
            .init(value: .result("以下是可以養貓的房源", ["room1", "room3"])),
            .init(value: .userInput("我預算只有 20000")),
            .init(value: .result("以下是月租低於 20000 的房源", ["room3"])),
        ]
    }
}

