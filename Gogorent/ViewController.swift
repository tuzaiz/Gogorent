//
//  ViewController.swift
//  Gogorent
//
//  Created by Henry Tseng on 2023/6/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    
    private var stepIndex = 0 {
        didSet {
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: dataSource.count - 1, section: 0), at: .bottom, animated: true)
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
        let step = Step.fullSteps[stepIndex]
        if case .userInput(let text) = step.value {
            let text = text as String
            DispatchQueue.global().async {
                for i in 0..<text.count {
                    let semaphor = DispatchSemaphore(value: 0)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i)) {
                        self.inputField.text = String(text.prefix(i))
                        semaphor.signal()
                    }
                    semaphor.wait()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
                    inputField.text = nil
                    stepIndex = (stepIndex + 1) % (Step.fullSteps.count + 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.nextBtnTapped(sender)
                    }
                }
            }
            
        } else {
            stepIndex = (stepIndex + 1) % (Step.fullSteps.count + 1)
        }
        
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
            .init(value: .userInput("我想找台北市或新北市的租屋處，請問有哪些選擇？")),
            .init(value: .request("好的，請問您想要找怎樣的房子？")),
            .init(value: .userInput("離工作地點通勤約 20 分鐘以內的電梯大樓")),
            .init(value: .request("您希望自行開車還是大眾交通工具？")),
            .init(value: .userInput("開車")),
            .init(value: .request("您的工作地點大概在哪個地方？")),
            .init(value: .userInput("捷運古亭站附近")),
            .init(value: .result("以下是推薦的房源", ["room1", "room2", "room3", "room4"])),
            .init(value: .userInput("我有養貓，幫我過濾可以養貓的房")),
            .init(value: .result("以下是可以養貓的房源", ["room1", "room3"])),
            .init(value: .userInput("我預算只有 20000")),
            .init(value: .result("以下是月租低於 20000 的房源", ["room3"])),
        ]
    }
}

