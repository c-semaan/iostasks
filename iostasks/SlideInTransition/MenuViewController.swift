

import UIKit

enum MenuType: Int {
    case Briefing
    case Tasks
    case Stats
}

class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Assiging the table View delegate and data Source to this View Controller
        tableView.delegate = self // setting the delegate ("controller") of the tableview to be this view controller to be able to communicate well with it.
        tableView.dataSource = self

    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
