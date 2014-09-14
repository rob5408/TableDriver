//
//  UIViewController+UNLEDAdditions.h
//  UNLEDTableDriver
//
//  Created by Robert Johnson on 9/12/14.
//  Copyright 2014 Unled, LLC. All rights reserved.
//

@interface UIViewController (UNLEDAdditions)

+ (UIView *)viewfromNIB:(NSString *)classAndNIBName;
+ (UIView *)view:(NSString *)class fromNIB:(NSString *)nibName;
+ (UIView *)viewWithTag:(NSUInteger)tag fromNIB:(NSString *)nibName;

@end
