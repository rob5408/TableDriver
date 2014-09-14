//
//  UIViewController+UNLEDAdditions.m
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

#import "UIViewController+UNLEDAdditions.h"

@implementation UIViewController (UNLEDAdditions)

+ (UIView *)viewfromNIB:(NSString *)classAndNIBName
{
//    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:classAndNIBName owner:nil options:nil];
//    for(id currentObject in topLevelObjects)
//    {
//        if([currentObject isKindOfClass:[NSClassFromString(classAndNIBName) class]])
//        {
//            return currentObject;
//            break;
//        }
//    }
//    return nil;
    
    return [self view:classAndNIBName fromNIB:classAndNIBName];
}

+ (UIView *)view:(NSString *)class fromNIB:(NSString *)nibName
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[NSClassFromString(class) class]])
        {
            return currentObject;
            break;
        }
    }
    
    return nil;
}

+ (UIView *)viewWithTag:(NSUInteger)tag fromNIB:(NSString *)nibName
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    for(UIView *currentObject in topLevelObjects)
    {
        if(currentObject.tag == tag)
        {
            return currentObject;
            break;
        }
    }
    
    return nil;
}

@end
