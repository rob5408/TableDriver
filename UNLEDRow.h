//
//  UNLEDRow.h
//  TableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

typedef id (^UNLEDCellForRowAtIndexPathBlock)(UITableView*, NSIndexPath*, id);
typedef void (^UNLEDConfigCellForRowAtIndexPathBlock)(UITableViewCell*, NSIndexPath*, id);
typedef void (^UNLEDDidSelectRowAtIndexPathBlock)(UITableView*, NSIndexPath*, id);

@interface UNLEDRow : NSObject

//@property (nonatomic, assign) UITableViewCellStyle style;
//@property (nonatomic, assign) CGFloat height;
//
//@property (nonatomic, copy) NSString* textLabelText;            // The text to appear in textLabel
//@property (nonatomic, copy) NSString* detailTextLabelText;      // The text to appear in detailTextLabel
//@property (nonatomic, copy) NSString* imageViewImagePath;       // The title of the image to appear in imageView
//@property (nonatomic, copy) CellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
//@property (nonatomic, copy) ConfigCellForRowAtIndexPathBlock configCellForRowAtIndexPathBlock;
//@property (nonatomic, copy) DidSelectRowAtIndexPathBlock didSelectRowAtIndexPathBlock;

@end
