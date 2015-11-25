//
//  TableDriver.swift
//  OSSM
//
//  Created by Robert Johnson on 11/15/14.
//  Copyright (c) 2014 Unled, LLC. All rights reserved.
//

import UIKit

//// If the Section containing this Row has an object in it's `rows` property at the same index as this Row, it will be passed via the object parameter
//typedef id (^UNLEDTableDriverCellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);
//typedef void (^UNLEDTableDriverConfigCellForRowAtIndexPathBlock)(UITableViewCell *tableViewCell, NSIndexPath *indexPath, id object);
//typedef void (^UNLEDTableDriverDidSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);
//typedef CGFloat (^UNLEDTableDriverHeightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, id object);

typealias TableDriverCellForRowAtIndexPath = (tableView: UITableView, indexPath: NSIndexPath, object: AnyObject?) -> UITableViewCell
typealias TableDriverDidSelectRowAtIndexPath = (tableView: UITableView, indexPath: NSIndexPath, object: AnyObject?) -> Void

// Inheriting from NSObject to get around implementing NSObjectProtocol
class TableDriver: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView?
    
    var sections = Array<Section>()
    
    init(tableView: UITableView?) {
        self.tableView = tableView
        
        super.init()
        
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.sections[section].staticRowCount != 0) {
            return self.sections[section].staticRowCount
        } else {
            return self.sections[section].rows.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.sections[indexPath.section].staticRowCount != 0) {
            if let row = self.sections[indexPath.section].rows[0] as? Row {
                return row.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            } else {
                return Row().cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            }
        } else {
            let row = self.sections[indexPath.section].rows[0]
            if let row = row as? Row {
                return row.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            } else if let row = row as? ClassNameable {
                let section = self.sections[indexPath.section]
                if let rowCandidate = section.rowTypeRegistry[row.className()] {
                    return rowCandidate.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: row)
                } else {
                    return Row().cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: row)
                }
            } else {
                return Row().cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            }
        }
    }

        
        
//        UITableViewCell *cellForRowAtIndexPath = nil;
//        
//        UNLEDSection *section = self.sections[indexPath.section];
//        id objectForRow = section.rows[indexPath.row];
//        UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]]) ? objectForRow : ([section rowForClass:[objectForRow class]]) ?: nil;
//        
//        if (row)
//        {
//            if (row.cellForRowAtIndexPathBlock)
//            {
//                cellForRowAtIndexPath = row.cellForRowAtIndexPathBlock(tableView, indexPath, objectForRow);
//            }
//            else
//            {
//                if (row.style)
//                {
//                    if (row.reuseIdentifier)
//                    {
//                        cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style reuseIdentifier:row.reuseIdentifier forTableView:tableView];
//                    }
//                    else
//                    {
//                        cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style forTableView:tableView];
//                    }
//                }
//                else
//                {
//                    if (row.reuseIdentifier)
//                    {
//                        cellForRowAtIndexPath = [UITableViewCell cellWithReuseIdentifier:row.reuseIdentifier forTableView:tableView];
//                    }
//                    else
//                    {
//                        cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
//                    }
//                }
//                
//                if (row.configCellForRowAtIndexPathBlock)
//                {
//                    row.configCellForRowAtIndexPathBlock(cellForRowAtIndexPath, indexPath, objectForRow);
//                }
//                else
//                {
//                    cellForRowAtIndexPath.imageView.image = [UIImage imageNamed:row.imageViewImagePath];
//                    cellForRowAtIndexPath.textLabel.text = row.textLabelText;
//                    cellForRowAtIndexPath.detailTextLabel.text = row.detailTextLabelText;
//                    // !!!:These should be configurable
//                    cellForRowAtIndexPath.accessoryType = UITableViewCellAccessoryNone;
//                    cellForRowAtIndexPath.selectionStyle = UITableViewCellSelectionStyleBlue;
//                }
//            }
//        }
//        else
//        {
//            cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
//        }
//        
//        return cellForRowAtIndexPath;
        
    
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if (section == 0) {
//            return nil
//        } else {
//            var header = tableView.dequeueReusableCellWithIdentifier("PlayerStatsHeader") as UIView
//            return header
//        }
//    }
    
    //    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
    //    {
    //    UNLEDSection *s = self.sections[section];
    //    return s.title;
    //    }

    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if (section == 0) {
//            return 0.0
//        } else {
//            return 44.0
//        }
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let player = self.person as Player
//        
//        let cell: UITableViewCell = {
//            
//            switch indexPath.section {
//            case 0:
//                var cell = tableView.dequeueReusableCellWithIdentifier("PersonBioTableViewCell", forIndexPath: indexPath) as PersonBioTableViewCell
//                
//                if let face = player.face {
//                    cell.faceImageView?.image = FaceMaker.imageWithFace(face)
//                }
//                
//                cell.nameLabel?.text = player.firstlast()
//                
//                if let country = player.country {
//                    let countryName = country.name ?? ""
//                    let nationalityAttributed = NSMutableAttributedString(string: " \(countryName)")
//                    let textAttachment = NSTextAttachment()
//                    textAttachment.image = UIImage(named: (country.code ?? "") + ".png")
//                    let flag = NSAttributedString(attachment: textAttachment)
//                    nationalityAttributed.replaceCharactersInRange(NSMakeRange(0, 0), withAttributedString: flag)
//                    cell.nationalityLabel?.attributedText = nationalityAttributed
//                } else {
//                    cell.nationalityLabel?.text = "Unknown nationality"
//                }
//                
//                if let birthdate = player.birthdate {
//                    var birthdateDateFormatter = NSDateFormatter()
//                    birthdateDateFormatter.dateFormat = "d MMMM YYYY"
//                    let birthdateAttributed = NSMutableAttributedString(string: " \(birthdateDateFormatter.stringFromDate(birthdate)) (\(player.age()))")
//                    
//                    let textAttachment = NSTextAttachment()
//                    textAttachment.image = UIImage(named: "cake.png")
//                    let cake = NSAttributedString(attachment: textAttachment)
//                    birthdateAttributed.replaceCharactersInRange(NSMakeRange(0, 0), withAttributedString: cake)
//                    
//                    cell.birthdateLabel?.attributedText = birthdateAttributed
//                } else {
//                    cell.birthdateLabel?.text = "Unknown birthdate"
//                }
//                return cell
//                
//            case 1:
//                
//                let stat = (player.stat.allObjects as Array<Stat>)[indexPath.row]
//                
//                var cell = tableView.dequeueReusableCellWithIdentifier("PlayerStatsTableViewCell", forIndexPath: indexPath) as PlayerStatsTableViewCell
//                cell.seasonLabel?.text = stat.season.name
//                cell.gamesStartedLabel?.text = stat.gs.stringValue
//                cell.gamesSubbedLabel?.text = stat.sb.stringValue
//                cell.goalsLabel?.text = stat.g.stringValue
//                cell.assistsLabel?.text = stat.a.stringValue
//                cell.yellowCardsLabel?.text = stat.yc.stringValue
//                cell.redCardsLabel?.text = stat.rc.stringValue
//                
//                return cell
//            default:
//                var cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath) as UITableViewCell
//                cell.textLabel?.text = "..."
//                return cell
//            }
//            }()
//        
//        return cell
//    }
    
    
    
    
//    #pragma mark - UITableViewDataSource
//    
//
//
//
//    - (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//    {
//    UNLEDSection *s = self.sections[section];
//    
//    if (s.headerBackgroundColor) {
//    view.tintColor = s.headerBackgroundColor;
//    }
//    
//    if (s.headerFontColor) {
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    [header.textLabel setTextColor:s.headerFontColor];
//    }
//    }
//    
//    - (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
//    {
//    UNLEDSection *s = self.sections[section];
//    
//    if (s.footerBackgroundColor) {
//    view.tintColor = s.footerBackgroundColor;
//    }
//    
//    if (s.footerFontColor) {
//    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//    [footer.textLabel setTextColor:s.footerFontColor];
//    }
//    }
//    
//    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    UITableViewCell *cellForRowAtIndexPath = nil;
//    
//    UNLEDSection *section = self.sections[indexPath.section];
//    id objectForRow = section.rows[indexPath.row];
//    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]]) ? objectForRow : ([section rowForClass:[objectForRow class]]) ?: nil;
//    
//    if (row)
//    {
//    if (row.cellForRowAtIndexPathBlock)
//    {
//    cellForRowAtIndexPath = row.cellForRowAtIndexPathBlock(tableView, indexPath, objectForRow);
//    }
//    else
//    {
//    if (row.style)
//    {
//    if (row.reuseIdentifier)
//    {
//    cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style reuseIdentifier:row.reuseIdentifier forTableView:tableView];
//    }
//    else
//    {
//    cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style forTableView:tableView];
//    }
//    }
//    else
//    {
//    if (row.reuseIdentifier)
//    {
//    cellForRowAtIndexPath = [UITableViewCell cellWithReuseIdentifier:row.reuseIdentifier forTableView:tableView];
//    }
//    else
//    {
//    cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
//    }
//    }
//    
//    if (row.configCellForRowAtIndexPathBlock)
//    {
//    row.configCellForRowAtIndexPathBlock(cellForRowAtIndexPath, indexPath, objectForRow);
//    }
//    else
//    {
//    cellForRowAtIndexPath.imageView.image = [UIImage imageNamed:row.imageViewImagePath];
//    cellForRowAtIndexPath.textLabel.text = row.textLabelText;
//    cellForRowAtIndexPath.detailTextLabel.text = row.detailTextLabelText;
//    // !!!:These should be configurable
//    cellForRowAtIndexPath.accessoryType = UITableViewCellAccessoryNone;
//    cellForRowAtIndexPath.selectionStyle = UITableViewCellSelectionStyleBlue;
//    }
//    }
//    }
//    else
//    {
//    cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
//    }
//    
//    return cellForRowAtIndexPath;
//    }
//    
    
    // MARK: UITableViewDelegate

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row: AnyObject = {
            if (self.sections[indexPath.section].staticRowCount != 0) {
                return self.sections[indexPath.section].rows[0]
            } else {
                return self.sections[indexPath.section].rows[indexPath.row]
            }
            }()
        
        if let row = row as? Row {
            return row.height
        } else {
            return 44.0
        }
    }

//    #pragma mark -
//    
//    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    CGFloat heightForRowAtIndexPath = 44.0;
//    
//    UNLEDSection *section = self.sections[indexPath.section];
//    id objectForRow = section.rows[indexPath.row];
//    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]])? objectForRow: ([section rowForClass:[objectForRow class]])?: nil;
//    if (row)
//    {
//    if (row.heightForRowAtIndexPath)
//    {
//    heightForRowAtIndexPath = row.heightForRowAtIndexPath(tableView, indexPath, objectForRow);
//    }
//    else
//    {
//    heightForRowAtIndexPath = row.height;
//    }
//    }
//    
//    return heightForRowAtIndexPath;
//    }
//    
//    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//    {
//    UNLEDSection *s = self.sections[section];
//    return s.headerHeight;
//    }
//    
//    - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//    {
//    UNLEDSection *s = self.sections[section];
//    return s.footerHeight;
//    }
//    
    
    
    
//    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//    UNLEDSection *section = self.sections[indexPath.section];
//    id objectForRow = section.rows[indexPath.row];
//    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]]) ? objectForRow : ([section rowForClass:[objectForRow class]]) ?: nil;
//    
//    if (row.didSelectRowAtIndexPathBlock)
//    {
//    row.didSelectRowAtIndexPathBlock(tableView, indexPath, objectForRow);
//    }
//    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.sections[indexPath.section].staticRowCount != 0) {
            // check to make sure there are rows
            let row = self.sections[indexPath.section].rows[0]
            if let row = row as? Row {
                row.didSelectRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            }
        } else {
            let row = self.sections[indexPath.section].rows[indexPath.row]
            
            if let row = row as? Row {
                row.didSelectRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: nil)
            } else if let row = row as? ClassNameable {
                let section = self.sections[indexPath.section]
                if let row = section.rowTypeRegistry[row.className()] {
                    row.didSelectRowAtIndexPath(tableView: tableView, indexPath: indexPath, object: row)
                }

            }
        }
    }

}

// `class` qualifier from "Checking for Protocol Conformance" in Swift book
@objc protocol ClassNameable: class {
    func className() -> String
}

class Section {
    var title: String? = nil
    var staticRowCount = 0
    var rows = Array<AnyObject>()
    var rowTypeRegistry = [String:Row]()
    
//    - (void)registerRow:(UNLEDRow *)row forClass:(Class)class;
//    - (void)registerRow:(UNLEDRow *)row forClasses:(NSArray *)classes;
//    - (UNLEDRow *)rowForClass:(Class)class;
    
//    @property (nonatomic, strong) NSMutableDictionary *rowTypeRegistry;

    func registerRow(row: Row, forClassName className: String) {
        self.rowTypeRegistry[className] = row
    }
    
//    - (void)registerRow:(UNLEDRow *)row forClass:(Class)class
//    {
//    self.rowTypeRegistry[NSStringFromClass(class)] = row;
//    }
//    
//    - (void)registerRow:(UNLEDRow *)row forClasses:(NSArray *)classes
//    {
//    for (Class class in classes)
//    {
//    [self registerRow:row forClass:class];
//    }
//    }
//    
//    // ???:Unregister
//    
//    - (UNLEDRow *)rowForClass:(Class)class
//    {
//    return self.rowTypeRegistry[NSStringFromClass(class)];
//    }


}

class Row {
    
    var cellForRowAtIndexPath: TableDriverCellForRowAtIndexPath = { (tableView: UITableView, indexPath: NSIndexPath, object: AnyObject?) -> UITableViewCell in
        return UITableViewCell(style: .Default, reuseIdentifier: "UITableViewCell")
    }
    var didSelectRowAtIndexPath: TableDriverDidSelectRowAtIndexPath = { (tableView: UITableView, indexPath: NSIndexPath, object: AnyObject?) -> Void in
    }
    
    var height: CGFloat = 44.0
}
