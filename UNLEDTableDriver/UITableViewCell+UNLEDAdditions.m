//
//  UITableViewCell+UNLEDAdditions.m
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import "UITableViewCell+UNLEDAdditions.h"
#import "UIViewController+UNLEDAdditions.h"

@implementation UITableViewCell (UNLEDAdditions)

// Maybe all of these methods should alter a &BOOL specifying whether it's a new cell or not
// That way initilization back in the UITableViewDataSource can happen just once

+ (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    return [self cellWithStyle:UITableViewCellStyleDefault forTableView:tableView];
}

+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style forTableView:(UITableView *)tableView
{
    return [self cellWithStyle:style reuseIdentifier:[NSString stringWithFormat:@"%@%d", NSStringFromClass([self class]), style] forTableView:tableView];
}

+ (UITableViewCell *)cellWithReuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView
{
    return [self cellWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier forTableView:tableView];
}

+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView
{
    return [self cellWithStyle:style reuseIdentifier:reuseIdentifier forTableView:tableView newCell:NULL];
}

+ (UITableViewCell *)cellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView newCell:(BOOL *)newCell
{
    if(newCell) *newCell = NO;
    
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        if(newCell) *newCell = YES;
        cell = [(UITableViewCell *)[[self class] alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
}

+ (UITableViewCell *)cellFromNibForTableView:(UITableView *)tableView
{
    return [self cellFromNib:NSStringFromClass([self class]) forTableView:tableView];
}

+ (UITableViewCell *)cellFromNib:(NSString *)nib forTableView:(UITableView *)tableView
{
    return [self cellFromNib:nib reuseIdentifier:NSStringFromClass([self class]) forTableView:tableView];
}

+ (UITableViewCell *)cellFromNib:(NSString *)nib reuseIdentifier:(NSString *)reuseIdentifier forTableView:(UITableView *)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        cell = [UIViewController viewfromNIB:nib];
    }
    
    return cell;
}

@end
