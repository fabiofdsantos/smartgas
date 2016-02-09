//
// This file is part of SmartGas, an iOS app to find the best gas station nearby.
//
// (c) Fábio Santos <ffsantos92@gmail.com>
// (c) Mateus Silva <mateusgsilva_@hotmail.com>
// (c) Fábio Marques <fabio1956.epo@gmail.com>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
//

import UIKit

protocol FilterDetailedTableViewControllerDelegate
{
    func sendFilter(filter: [String:Bool])
}

class FilterDetailedTableViewController: UITableViewController {

    var filter: [String:Bool]!

    var delegate:FilterTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filter.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for (index, entry) in filter.enumerate() {
            if index == indexPath.row {
                filter[entry.0] = !entry.1
            }
        }
        tableView.reloadData();
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterTypeCell", forIndexPath: indexPath) as! FilterTableViewCell
        for (index, entry) in filter.enumerate() {
            if index == indexPath.row {
                cell.setFilter(entry.0)
                if entry.1 {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
        }

        return cell
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if (self.isMovingFromParentViewController()){
            self.delegate?.sendFilter(filter)
        }
    }
}
