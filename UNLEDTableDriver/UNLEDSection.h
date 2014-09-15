//
//  UNLEDSection.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

@class UNLEDRow;

@interface UNLEDSection : NSObject

@property (nonatomic, copy) NSString *title;          // The text to appear in headers
@property (nonatomic, strong) NSArray *rows;

- (void)addRow:(UNLEDRow *)row;

//// !!!:I wish this didn't have to be by class
- (void)registerRow:(UNLEDRow *)row forClass:(Class)class;
- (void)registerRow:(UNLEDRow *)row forClasses:(NSArray *)classes;
- (UNLEDRow *)rowForClass:(Class)class;

@end
