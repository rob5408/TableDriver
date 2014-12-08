//
//  UNLEDSection.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

typedef NSArray* (^UNLEDTableDriverSectionReloadRowsBlock)();

@class UNLEDRow;

@interface UNLEDSection : NSObject

@property (nonatomic, copy) NSString *title;          // The text to appear in headers
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIColor *headerBackgroundColor;
@property (nonatomic, strong) UIColor *headerFontColor;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong) UIColor *footerBackgroundColor;
@property (nonatomic, strong) UIColor *footerFontColor;
@property (nonatomic, strong) NSArray *rows;
@property (nonatomic, copy) UNLEDTableDriverSectionReloadRowsBlock reloadRows;

- (void)addRow:(UNLEDRow *)row;

//// !!!:I wish this didn't have to be by class
- (void)registerRow:(UNLEDRow *)row forClass:(Class)class;
- (void)registerRow:(UNLEDRow *)row forClasses:(NSArray *)classes;
- (UNLEDRow *)rowForClass:(Class)class;

@end
