//
//  UNLEDSection.m
//  TableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import "UNLEDSection.h"
#import "UNLEDRow.h"

@interface UNLEDSection ()

@property (nonatomic, strong) NSMutableDictionary *rowTypeRegistry;

@end

@implementation Section

//@property (nonatomic, strong) NSMutableArray *options;      // Holds Non-Row objects
//@property (nonatomic, strong) Row *row;                     // Example Row if options are homogenous
//@property (nonatomic, copy) NSString *indexTitle;     // The text to appear in indexes
//@property (nonatomic, copy) NSString *footer;         // The text that appears in the Section footer
//
//// TODO: These two are only used for special sections, see if theres a slicker way
//@property (nonatomic) BOOL names;
//@property (nonatomic) BOOL additionalFields;
//@property (nonatomic) BOOL pickOne;
//@property (nonatomic) BOOL twoColumn;
//@property (nonatomic) BOOL multiRow;
//@property (nonatomic) BOOL imageSection;

//- (id)init
//{
//    if((self = [super init]))
//	{
//		self.rows = [NSMutableArray new];
//        self.rowTypeRegistry = [NSMutableDictionary new];
//    }
//    return self;
//}
//
//- (void)registerRow:(Row *)row forClass:(Class)class
//{
//    self.rowTypeRegistry[NSStringFromClass(class)] = row;
//}
//
//- (void)registerRow:(Row *)row forClasses:(NSArray *)classes
//{
//    for (Class class in classes)
//    {
//        [self registerRow:row forClass:class];
//    }
//}
//
//// ???:Unregister
//
//- (Row *)rowForClass:(Class)class
//{
//    return self.rowTypeRegistry[NSStringFromClass(class)];
//}

@end
