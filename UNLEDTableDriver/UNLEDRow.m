//
//  UNLEDRow.m
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import "UNLEDRow.h"
#import "UNLEDSection.h"

@interface UNLEDRow ()

@end

@implementation UNLEDRow

- (instancetype)init
{
    if (self = [super init])
    {
        self.height = 44.0;
    }
    
    return self;
}


//+ (void)createRowForSection:(UNLEDSection *)section 
//
//row = [UNLEDRow new];
//row.style = UITableViewCellStyleDefault;
//row.configCellForRowAtIndexPathBlock = ^(UITableViewCell *tableViewCell, NSIndexPath *indexPath, id object) {
//    [tableViewCell.imageView setImageWithURL:self.listing.user.avatarUrl placeholderImage:[UIImage imageNamed:@"choose-photo"]];
//    
//    tableViewCell.textLabel.font = [[SSThemeManager sharedTheme] boldFontWithSize:16.0];
//    tableViewCell.textLabel.textColor = [UIColor darkGrayColor];
//    tableViewCell.textLabel.text = self.listing.user.username;
//};
//row.height = 44.0;
//
//
////        row.cellForRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id object) {
////            SSUserCell *userCell = [SSUserCell cellWithTableView:tableView];
////            userCell.user = self.listing.user;
////            return userCell;
////        };
//row.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath, SSSortOrder *sortOrder) {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    SSProfileCollectionViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SSListingsCollectionViewController"];
//    controller.user = self.listing.user;
//    
//    [self.navigationController pushViewController:controller animated:YES];
//};
////        row.height = 54.0;
//[section addRow:row];


@end
