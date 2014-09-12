//
//  UNLEDTableDriver.m
//  TableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

//typedef void (^VoidBlock)();

#import "UNLEDTableDriver.h"

@interface UNLEDTableDriver ()

//@property (nonatomic) BOOL selected;
//
//// TODO: Try these out
//@property (nonatomic, strong) NSDictionary *properties;
//
//@property (nonatomic) float height;
//@property (nonatomic) SEL callback;
//@property (nonatomic, assign) NSUInteger type;


@end

@implementation UNLEDTableDriver

//- (instancetype)init
//{
//    if(self = [super init])
//    {
//        self.height = 44.0f;
//    }
//    
//    return self;
//}


//
//  SectionTableViewController.m
//  OSSM
//
//  Created by Robert Johnson on 7/2/10.
//  Copyright 2010 Robert Johnson. All rights reserved.
//

// We'll divert all inits through initWithStyle so we don't have to litter the code throughout with these esoteric calls (ie inistWithStyle)
//- (id)init
//{
//	if(self = [super initWithStyle:UITableViewStyleGrouped])
//	{
//        self.sections = [NSMutableArray array];
//	}
//    
//	return self;
//}

#pragma mark - SectionTableViewController

- (void)prepareSections
{
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareSections];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Section *s = self.sections[section];
    return s.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Section *s = self.sections[section];
    return s.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellForRowAtIndexPath = nil;
    
    Section *section = self.sections[indexPath.section];
    id objectForRow = section.rows[indexPath.row];
    Row *row = ([objectForRow isKindOfClass:[Row class]])? objectForRow: ([section rowForClass:[objectForRow class]])?: nil;
    
    if(row)
    {
        if(row.cellForRowAtIndexPathBlock)
        {
            cellForRowAtIndexPath = row.cellForRowAtIndexPathBlock(tableView, indexPath, objectForRow);
        }
        else
        {
            if(row.style)
            {
                cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style forTableView:tableView];
            }
            else
            {
                cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
            }
            
            if(row.configCellForRowAtIndexPathBlock) row.configCellForRowAtIndexPathBlock(cellForRowAtIndexPath, indexPath, objectForRow);
            else
            {
                cellForRowAtIndexPath.imageView.image = [UIImage imageNamed:row.imageViewImagePath];
                cellForRowAtIndexPath.textLabel.text = row.textLabelText;
                cellForRowAtIndexPath.detailTextLabel.text = row.detailTextLabelText;
                // !!!:These should be configurable
                cellForRowAtIndexPath.accessoryType = UITableViewCellAccessoryNone;
                cellForRowAtIndexPath.selectionStyle = UITableViewCellSelectionStyleBlue;
            }
        }
    }
    else
    {
        cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
    }
    
	return cellForRowAtIndexPath;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat heightForRowAtIndexPath = 44.0;
//
//    Section *section = self.sections[indexPath.section];
//    id objectForRow = section.rows[indexPath.row];
//    Row *row = ([objectForRow isKindOfClass:[Row class]])? objectForRow: ([section rowForClass:[objectForRow class]])?: nil;
//    if(row) heightForRowAtIndexPath = row.height;
//
//    return heightForRowAtIndexPath;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Section *section = self.sections[indexPath.section];
    id objectForRow = section.rows[indexPath.row];
    Row *row = ([objectForRow isKindOfClass:[Row class]])? objectForRow: ([section rowForClass:[objectForRow class]])?: nil;
    
    if(row.didSelectRowAtIndexPathBlock) row.didSelectRowAtIndexPathBlock(tableView, indexPath, objectForRow);
}

@end
