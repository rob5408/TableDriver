//
//  UNLEDTableDriver.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNLEDSection.h"
#import "UNLEDRow.h"

typedef NSArray * (^UNLEDTableDriverPrepareSectionsBlock)(void);

@interface UNLEDTableDriver : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) UNLEDTableDriverPrepareSectionsBlock prepareSections;

- (void)drive:(UITableView *)tableView;

- (void)update;

- (UNLEDSection *)sectionAtIndex:(NSUInteger)index;
- (void)reloadSection:(UNLEDSection *)section;

@end
