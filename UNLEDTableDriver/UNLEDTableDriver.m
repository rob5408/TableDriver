//
//  UNLEDTableDriver.m
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import "UNLEDTableDriver.h"
#import "UITableViewCell+UNLEDAdditions.h"

@interface UNLEDTableDriver () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic) BOOL selected;
//
//// TODO: Try these out
//@property (nonatomic, strong) NSDictionary *properties;
//
//@property (nonatomic) float height;
//@property (nonatomic) SEL callback;
//@property (nonatomic, assign) NSUInteger type;

@property (nonatomic, strong) NSArray *sections;

@end

@implementation UNLEDTableDriver

- (instancetype)init
{
    if (self = [super init])
    {
        //self.height = 44.0f;
        
        self.sections = [NSArray array];
    }
    
    return self;
}

#pragma mark - UNLEDTableDriver

- (void)drive:(UITableView *)tableView
{
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
}

- (void)update
{
    if (self.prepareSections)
    {
        self.sections = self.prepareSections();
    }
    
    [self.tableView reloadData];
}

- (void)reloadSection:(UNLEDSection *)section
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self.sections indexOfObject:section]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];
    return s.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];
    return s.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellForRowAtIndexPath = nil;
    
    UNLEDSection *section = self.sections[indexPath.section];
    id objectForRow = section.rows[indexPath.row];
    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]]) ? objectForRow : ([section rowForClass:[objectForRow class]]) ?: nil;
    
    if (row)
    {
        if (row.cellForRowAtIndexPathBlock)
        {
            cellForRowAtIndexPath = row.cellForRowAtIndexPathBlock(tableView, indexPath, objectForRow);
        }
        else
        {
            if (row.style)
            {
                if (row.reuseIdentifier)
                {
                    cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style reuseIdentifier:row.reuseIdentifier forTableView:tableView];
                }
                else
                {
                    cellForRowAtIndexPath = [UITableViewCell cellWithStyle:row.style forTableView:tableView];
                }
            }
            else
            {
                if (row.reuseIdentifier)
                {
                    cellForRowAtIndexPath = [UITableViewCell cellWithReuseIdentifier:row.reuseIdentifier forTableView:tableView];
                }
                else
                {
                    cellForRowAtIndexPath = [UITableViewCell cellForTableView:tableView];
                }
            }
            
            if (row.configCellForRowAtIndexPathBlock)
            {
                row.configCellForRowAtIndexPathBlock(cellForRowAtIndexPath, indexPath, objectForRow);
            }
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
    UNLEDSection *section = self.sections[indexPath.section];
    id objectForRow = section.rows[indexPath.row];
    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]]) ? objectForRow : ([section rowForClass:[objectForRow class]]) ?: nil;
    
    if (row.didSelectRowAtIndexPathBlock)
    {
        row.didSelectRowAtIndexPathBlock(tableView, indexPath, objectForRow);
    }
}

@end
