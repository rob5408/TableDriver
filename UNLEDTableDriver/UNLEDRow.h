//
//  UNLEDRow.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

// If the Section containing this Row has an object in it's `rows` property at the same index as this Row, it will be passed via the object parameter
typedef id (^UNLEDTableDriverCellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);
typedef void (^UNLEDTableDriverConfigCellForRowAtIndexPathBlock)(UITableViewCell *tableViewCell, NSIndexPath *indexPath, id object);
typedef void (^UNLEDTableDriverDidSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);
typedef CGFloat (^UNLEDTableDriverHeightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, id object);

@interface UNLEDRow : NSObject

@property (nonatomic, assign) UITableViewCellStyle style;
@property (nonatomic, copy) NSString *reuseIdentifier;          // Set this if you want use a prototype cell or to prevent rows from reusing each other
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) UNLEDTableDriverHeightForRowAtIndexPath heightForRowAtIndexPath;

@property (nonatomic, copy) NSString* textLabelText;            // The text to appear in textLabel
@property (nonatomic, copy) NSString* detailTextLabelText;      // The text to appear in detailTextLabel
@property (nonatomic, copy) NSString* imageViewImagePath;       // The title of the image to appear in imageView

// DO THIS...
@property (nonatomic, copy) UNLEDTableDriverCellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
// OR THIS...
// Note: Set this Row's `style` to be passed a UITableViewCell of that style (Default: UITableViewCellStyleDefault)
@property (nonatomic, copy) UNLEDTableDriverConfigCellForRowAtIndexPathBlock configCellForRowAtIndexPathBlock;

@property (nonatomic, copy) UNLEDTableDriverDidSelectRowAtIndexPathBlock didSelectRowAtIndexPathBlock;

@end
