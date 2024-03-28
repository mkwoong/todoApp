//
//  ViewController.swift
//  myTodo
//
//  Created by 문기웅 on 3/28/24.
//

import UIKit

struct todo {
    let title: String
    let done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}

class ViewController: UIViewController {
    var todoList:[todo] = []
    @IBOutlet weak var viewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func tappedAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "새 할일 추가", message: "할 일을 입력해주세요", preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in guard let title = alert.textFields?[0].text else {return}
            let addtodo = todo(title: title, done: false)
            self?.todoList.append(addtodo)
            self?.viewTable.reloadData()
        })

        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "할 일을 입력해주세요." })
        self.present(alert, animated: true, completion: nil)
    }
        

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as? todoCell else {
            return UITableViewCell()
        }
        cell.todoLabel.text = todoList[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            viewTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            viewTable.reloadData()
        }
    }
    
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension String {
  func removeStrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0 , range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

class todoCell: UITableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var todoLabel: UILabel!
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected.toggle()
        if checkButton.isSelected {
            checkButton.isSelected = true
            todoLabel.attributedText = todoLabel.text?.strikeThrough()
        } else {
            checkButton.isSelected = false
            todoLabel.attributedText = todoLabel.text?.removeStrikeThrough()
        }
    }
}



