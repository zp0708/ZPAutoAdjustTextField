//
//  RTHXProgressHUD.h
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/26.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import <Foundation/Foundation.h>

//UIKIT_EXTERN NSString *const ZPStatusBarStyleError;
//UIKIT_EXTERN NSString *const ZPStatusBarStyleWarning;
//UIKIT_EXTERN NSString *const ZPStatusBarStyleSuccess;
//UIKIT_EXTERN NSString *const ZPStatusBarStyleMatrix;
//UIKIT_EXTERN NSString *const ZPStatusBarStyleDefault;
//UIKIT_EXTERN NSString *const ZPStatusBarStyleDark;

@class JDStatusBarView;

@interface ZPProgressHUD : NSObject

+ (void)zp_showNoticeWithStatus:(NSString *)string;

//+ (void)zp_showInfoInView:(UIView *)view Info:(NSString *)info;

//+ (void)showMessageInView:(UIView *)inView belowView:(UIView *)below info:(NSString *)info;

+ (void)zp_show;

+ (void)zp_showInfoWithStatus:(NSString *)string;

+ (void)zp_showSuccessWithStatus:(NSString *)string;

//+ (void)zp_showMaskTypeNoneWithStatus:(NSString *)status;
//
//+ (void)zp_showMaskTypeClearWithStatus:(NSString *)status;

//+ (void)zp_showWithStatus:(NSString *)status;

+ (void)zp_showErrorWithStatus:(NSString *)string;

+ (void)zp_showNetWorkingError;

+ (void)zp_dismiss;

+ (void)zp_dismissWithDelay:(NSTimeInterval)delay;

+ (void)configCustomProgressHUB;

//// MARK: JDStatusBarNotification
//
//+ (void)showStatusBarQueryStr:(NSString *)tipStr;
//+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
//+ (void)showStatusBarErrorStr:(NSString *)errorStr;
//
//+ (JDStatusBarView*)zp_showBarWithStatus:(NSString *)status;
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                         styleName:(NSString*)styleName;
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                      dismissAfter:(NSTimeInterval)timeInterval;
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                      dismissAfter:(NSTimeInterval)timeInterval
//                         styleName:(NSString*)styleName;
//
//+ (void)zp_noticeDismiss;
//
//+ (void)zp_dismissAnimated:(BOOL)animated;
//
//+ (void)zp_dismissAfter:(NSTimeInterval)delay;
//
//+ (void)zp_showProgress:(CGFloat)progress;
//
//+ (void)zp_showActivityIndicator:(BOOL)show
//               indicatorStyle:(UIActivityIndicatorViewStyle)style;
//
//+ (BOOL)zp_isVisible;

@end
