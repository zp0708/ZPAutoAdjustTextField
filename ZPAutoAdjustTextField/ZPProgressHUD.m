//
//  RTHXProgressHUD.m
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/26.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "ZPProgressHUD.h"
#import "SVProgressHUD.h"
//#import "JDStatusBarNotification.h"
//#import <AFNetworkReachabilityManager.h>

//NSString *const ZPStatusBarStyleError   = @"JDStatusBarStyleError";
//NSString *const ZPStatusBarStyleWarning = @"JDStatusBarStyleWarning";
//NSString *const ZPStatusBarStyleSuccess = @"JDStatusBarStyleSuccess";
//NSString *const ZPStatusBarStyleMatrix  = @"JDStatusBarStyleMatrix";
//NSString *const ZPStatusBarStyleDefault = @"JDStatusBarStyleDefault";
//NSString *const ZPStatusBarStyleDark    = @"JDStatusBarStyleDark";

@implementation ZPProgressHUD

//#pragma mark - JDStatusBarNotification
//
//+ (JDStatusBarView*)zp_showBarWithStatus:(NSString *)status{
//    return [JDStatusBarNotification showWithStatus:status];
//}
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                         styleName:(NSString*)styleName{
//    return [JDStatusBarNotification showWithStatus:status styleName:styleName];
//}
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                      dismissAfter:(NSTimeInterval)timeInterval{
//    return [JDStatusBarNotification showWithStatus:status dismissAfter:timeInterval];
//}
//
//+ (JDStatusBarView*)zp_showWithStatus:(NSString *)status
//                      dismissAfter:(NSTimeInterval)timeInterval
//                         styleName:(NSString*)styleName{
//    return [JDStatusBarNotification showWithStatus:status dismissAfter:timeInterval styleName:styleName];
//}
//
//+ (void)zp_noticeDismiss{
//    [JDStatusBarNotification dismiss];
//}
//
//+ (void)zp_dismissAnimated:(BOOL)animated{
//    [JDStatusBarNotification dismissAnimated:animated];
//}
//
//+ (void)zp_dismissAfter:(NSTimeInterval)delay{
//    [JDStatusBarNotification dismissAfter:delay];
//}
//
//+ (void)zp_showProgress:(CGFloat)progress{
//    [JDStatusBarNotification showProgress:progress];
//}
//
//+ (void)zp_showActivityIndicator:(BOOL)show
//               indicatorStyle:(UIActivityIndicatorViewStyle)style{
//    [JDStatusBarNotification showActivityIndicator:show indicatorStyle:style];
//}
//
//+ (BOOL)zp_isVisible{
//    return [JDStatusBarNotification isVisible];
//}
//
//+ (void)showStatusBarQueryStr:(NSString *)tipStr{
//    [JDStatusBarNotification showWithStatus:tipStr];
//    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
//}
//
//+ (void)showStatusBarSuccessStr:(NSString *)tipStr{
//    if ([JDStatusBarNotification isVisible]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:kStatusBarNoticeShowDuration];
//        });
//    }else{
//        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0];
//    }
//}
//+ (void)showStatusBarErrorStr:(NSString *)errorStr{
//    if ([JDStatusBarNotification isVisible]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:kStatusBarNoticeShowDuration styleName:JDStatusBarStyleError];
//        });
//    }else{
//        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
//    }
//}
//
//+ (void)zp_showInfoIn:(UIView *)view Info:(NSString *)info
//{
//    UILabel *infoLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, -44, view.width, 44)];
//    infoLbl.text = info;
//    infoLbl.textColor = [UIColor whiteColor];
//    infoLbl.textAlignment = NSTextAlignmentCenter;
//    infoLbl.backgroundColor = [UIColor orangeColor];
//    [view addSubview:infoLbl];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        infoLbl.transform = CGAffineTransformMakeTranslation(0, infoLbl.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 delay:1 options:0 animations:^{
//            infoLbl.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [infoLbl removeFromSuperview];
//        }];
//    }];
//}
//
//+ (void)showMessageInView:(UIView *)inView belowView:(UIView *)below info:(NSString *)info
//{
//    UILabel *infoLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, below.height - 24,inView.width, 44)];
//    infoLbl.text = info;
//    infoLbl.textColor = [UIColor whiteColor];
//    infoLbl.textAlignment = NSTextAlignmentCenter;
//    infoLbl.backgroundColor = [UIColor orangeColor];
//    [inView insertSubview:infoLbl belowSubview:below];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        infoLbl.transform = CGAffineTransformMakeTranslation(0, infoLbl.height);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 delay:1 options:0 animations:^{
//            infoLbl.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [infoLbl removeFromSuperview];
//        }];
//    }];
//}

#pragma mark - SVProgressHUD

+ (void)zp_showInfoInView:(UIView *)view Info:(NSString *)info
{
    [SVProgressHUD showErrorWithStatus:info];
}

+ (void)zp_show
{
    [SVProgressHUD show];
}

//+ (void)zp_showWithStatus:(NSString *)status{
//    if([AFNetworkReachabilityManager sharedManager].isReachable){
//        [SVProgressHUD showWithStatus:status];
//    }
//}
//
//+ (void)zp_showMaskTypeNoneWithStatus:(NSString *)status{
//    if([AFNetworkReachabilityManager sharedManager].isReachable){
//        [SVProgressHUD showWithStatus:status];
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    }
//}
//
//+ (void)zp_showMaskTypeClearWithStatus:(NSString *)status{
//    if([AFNetworkReachabilityManager sharedManager].isReachable){
//        [SVProgressHUD showWithStatus:status];
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    }
//}

+(void)zp_showSuccessWithStatus:(NSString *)string
{
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)zp_showErrorWithStatus:(NSString *)string
{
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)zp_showNetWorkingError
{
    [SVProgressHUD showErrorWithStatus:@"YOYO!,似乎与网络失去了联系!"];
}

+ (void)zp_showInfoWithStatus:(NSString *)string
{
    [SVProgressHUD showInfoWithStatus:string];
}

+ (void)zp_showNoticeWithStatus:(NSString *)string
{
    [SVProgressHUD showInfoWithStatus:string];
}

+ (void)configCustomProgressHUB
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setRingThickness:2];
    [SVProgressHUD setCornerRadius:8];
    [SVProgressHUD setErrorImage:nil];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setMinimumDismissTimeInterval:15];
    
//    [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle *style) {
//        style.barColor = [UIColor colorWithRed:80/255.0 green:205/255.0 blue:121/255.0 alpha:1.0];
//        style.textColor = [UIColor whiteColor];
//        style.font = [UIFont systemFontOfSize:12];
//        style.animationType = JDStatusBarAnimationTypeMove;
//        style.progressBarColor = [UIColor orangeColor];
//        return style;
//    }];
    
//    [JDStatusBarNotification addStyleNamed:@"" prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
//
//    }];
}

+ (void)zp_dismissWithDelay:(NSTimeInterval)delay
{
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)zp_dismiss
{
    [SVProgressHUD dismiss];
}
@end
