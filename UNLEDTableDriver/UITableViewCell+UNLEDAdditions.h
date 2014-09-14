//
//  UITableViewCell+UNLEDAdditions.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

@interface UITableViewCell (UNLEDAdditions)

+ (UITableViewCell *)cellForTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style forTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView newCell:(BOOL *)newCell;

+ (UITableViewCell *)cellFromNibForTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellFromNib:(NSString *)nib forTableView:(UITableView *)tableView;
+ (UITableViewCell *)cellFromNib:(NSString *)nib reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView;

@end
