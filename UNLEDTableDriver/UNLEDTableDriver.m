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
        
        // ???:Loop through new sections and invoke reloadRows?
    }
    
    [self.tableView reloadData];
}

- (UNLEDSection *)sectionAtIndex:(NSUInteger)index
{
    return [self.sections objectAtIndex:index];
}

- (void)reloadSection:(UNLEDSection *)section
{
    if (section.reloadRows) {
        section.rows = section.reloadRows();
    }
    
    NSUInteger indexOfSection = [self.sections indexOfObject:section];
    if (indexOfSection != NSNotFound) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexOfSection] withRowAnimation:UITableViewRowAnimationNone];
    }
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];

    if (s.headerBackgroundColor) {
        view.tintColor = s.headerBackgroundColor;
    }

    if (s.headerFontColor) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:s.headerFontColor];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];
    
    if (s.footerBackgroundColor) {
        view.tintColor = s.footerBackgroundColor;
    }
    
    if (s.footerFontColor) {
        UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
        [footer.textLabel setTextColor:s.footerFontColor];
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightForRowAtIndexPath = 44.0;

    UNLEDSection *section = self.sections[indexPath.section];
    id objectForRow = section.rows[indexPath.row];
    UNLEDRow *row = ([objectForRow isKindOfClass:[UNLEDRow class]])? objectForRow: ([section rowForClass:[objectForRow class]])?: nil;
    if (row)
    {
        if (row.heightForRowAtIndexPath)
        {
            heightForRowAtIndexPath = row.heightForRowAtIndexPath(tableView, indexPath, objectForRow);
        }
        else
        {
            heightForRowAtIndexPath = row.height;
        }
    }

    return heightForRowAtIndexPath;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];
    return s.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UNLEDSection *s = self.sections[section];
    return s.footerHeight;
}

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
