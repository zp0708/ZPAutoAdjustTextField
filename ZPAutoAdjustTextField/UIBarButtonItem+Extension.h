//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBFPopFlatButton.h"

@interface UIBarButtonItem (Extension)
- (UIBarButtonItem *)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

- (UIBarButtonItem *)initWithTarget:(id)target type:(FlatButtonType)type action:(SEL)action;

+ (UIBarButtonItem *)itemWithTarget:(id)target type:(FlatButtonType)type action:(SEL)action;

- (UIBarButtonItem *)initWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action;
@end
