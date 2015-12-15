//
//  TableDriver.swift
//  OSSM
//
//  Created by Robert Johnson on 11/15/14.
//  Copyright (c) 2014 Unled, LLC. All rights reserved.
//

import UIKit

//// If the Section containing this Row has an object in it's `rows` property at the same index as this Row, it will be passed via the object parameter
//typedef CGFloat (^UNLEDTableDriverHeightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, id object);

//public typealias TableDriverConfigCellForRowAtIndexPath = (tableView: UITableView, indexPath: NSIndexPath, object: Any?) -> UITableViewCell
public typealias TableDriverCellForRowAtIndexPath = (tableView: UITableView, indexPath: NSIndexPath, object: Any?) -> UITableViewCell
public typealias TableDriverDidSelectRowAtIndexPath = (tableView: UITableView, indexPath: NSIndexPath, object: Any?) -> Void

// Inheriting from NSObject to get around implementing NSObjectProtocol
public class TableDriver: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    var scrollViewDelegate: UIScrollViewDelegate?
    
    public var sections = Array<Section>()
    
    public init(tableView: UITableView?) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    // MARK: UITableViewDataSource
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].title
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.sections[section].staticRowCount != 0) {
            return self.sections[section].staticRowCount
        } else {
            return self.sections[section].rows.count
        }
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.sections[indexPath.section].staticRowCount != 0) {
            let row: Any = self.sections[indexPath.section].rows[0]
            return (row as! Row).cellForRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: nil)
        } else {
            let row: Any = self.sections[indexPath.section].rows[indexPath.row]
            
            if let row = row as? Row {
                return row.cellForRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: nil)
            } else if let row = row as? RowNameable {
                let section = self.sections[indexPath.section]
                if let rowCandidate = section.rowTypeRegistry[row.rowName()] {
                    return rowCandidate.cellForRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: row)
                } else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "..."
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath)
                cell.textLabel?.text = "..."
                return cell
            }
        }
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView.rowHeight == UITableViewAutomaticDimension) {
            return UITableViewAutomaticDimension
        } else {
            let row: Any = {
                if (self.sections[indexPath.section].staticRowCount != 0) {
                    return self.sections[indexPath.section].rows[0]
                } else {
                    return self.sections[indexPath.section].rows[indexPath.row]
                }
            }()
            
            //let row: AnyObject = self.sections[indexPath.section].rows[indexPath.row]
            
            if let row = row as? Row {
                return row.height
            } else {
                return 44.0
            }
        }
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.sections[indexPath.section].staticRowCount != 0) {
            // check to make sure there are rows
            if let row = self.sections[indexPath.section].rows[0] as? Row where row.didSelectRowAtIndexPath != nil {
                row.didSelectRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: nil)
            }
        } else {
            let row: Any = self.sections[indexPath.section].rows[indexPath.row]
            
            if let row = row as? Row where row.didSelectRowAtIndexPath != nil {
                //            if ((row is Row) && ((row as! Row).didSelectRowAtIndexPath) != nil) {
                row.didSelectRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: nil)
            } else if let row = row as? RowNameable {
                let section = self.sections[indexPath.section]
                if let rowCandidate = section.rowTypeRegistry[row.rowName()] {
                    if (((rowCandidate as Row).didSelectRowAtIndexPath) != nil) {
                        (rowCandidate as Row).didSelectRowAtIndexPath!(tableView: tableView, indexPath: indexPath, object: row)
                    }
                }
            }
        }
        
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        self.scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
    
}

// MARK: - Section

public class Section {
    
    private var rowTypeRegistry = [String:Row]()
    public var title: String? = nil
    private var staticRowCount = 0
    public var rows = Array<Any>()
    
    public init() {
    }

    public func registerRow(row: Row, forClassName className: String) {
        self.rowTypeRegistry[className] = row
    }
    
}

// MARK: - Row

public class Row {
    
//    public var configCellForRowAtIndexPath: TableDriverConfigCellForRowAtIndexPath = { (tableView: UITableView, indexPath: NSIndexPath, object: Any?) -> UITableViewCell in
//        var tableViewCell = tableView.dequeueReusableCellWithIdentifier(UITableViewCell.defaultReuseIdentifier)
//        if (tableViewCell == nil) {
//            tableViewCell = UITableViewCell(style: .Default, reuseIdentifier: UITableViewCell.defaultReuseIdentifier)
//        }
//        
//        return tableViewCell!
//    }
    public var cellForRowAtIndexPath: TableDriverCellForRowAtIndexPath? = nil
    public var didSelectRowAtIndexPath: TableDriverDidSelectRowAtIndexPath? = nil
    
    var height: CGFloat = 44.0
    
    public init() {
    }
    
}

// MARK: - RowNameable

// TODO: See if there's a generics approach
public protocol RowNameable {
    
    func rowName() -> String
    
}

// MARK: - RowDescribable

public protocol RowDescription {
    
    func rowDescription() -> String
    
}

private extension UITableViewCell {
    
    class var defaultReuseIdentifier: String { get { return "UITableViewCell" }}
    
}

