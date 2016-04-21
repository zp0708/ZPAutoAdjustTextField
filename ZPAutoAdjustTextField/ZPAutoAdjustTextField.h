//
//  RTHXCustomTextField.h
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/11/2.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPAutoAdjustTextField;
@protocol CustomTextFieldDelegate;

UIKIT_EXTERN NSString * const RTHXCustomTextFieldDidClickedPreviousBarButtonItem;
UIKIT_EXTERN NSString * const RTHXCustomTextFieldDidClickedNextBarButtonItem;
UIKIT_EXTERN NSString * const RTHXCustomTextFieldDidClickedCancelBarButtonItem;
UIKIT_EXTERN NSString * const RTHXCustomTextFieldDidClickedEnsureBarButtonItem;
UIKIT_EXTERN NSString * const RTHXCustomTextFieldBarButtonItem;
UIKIT_EXTERN NSString * const RTHXCustomTextFieldCustomTextField;

typedef NS_ENUM(NSInteger, CustomTextFieldToolbarType) {
    CustomTextFieldToolbarTypePreviousNextCancelEnsure,  // default
    CustomTextFieldToolbarTypePreviousNextEnsure,
    CustomTextFieldToolbarTypeCancelEnsure,
};

typedef NS_ENUM(NSInteger, CustomTextFieldTextForm) {
    CustomTextFieldTextFormNone, // default
    CustomTextFieldTextFormMobile,
    CustomTextFieldTextFormBankCard,
    CustomTextFieldTextFormIdentity
};

typedef NS_ENUM(NSInteger, CustomTextFieldVerifyType) {
    CustomTextFieldVerifyTypeNone,        // default
    CustomTextFieldVerifyTypeMobile,
    CustomTextFieldVerifyTypeUserName,
    CustomTextFieldVerifyTypePassword,
    CustomTextFieldVerifyTypeNickName,
    CustomTextFieldVerifyTypeTradePassword,
    CustomTextFieldVerifyTypeIdentityCard,
    CustomTextFieldVerifyTypeVerifyCode,
    CustomTextFieldVerifyTypeBankArea,
    CustomTextFieldVerifyTypeBank,
    CustomTextFieldVerifyTypeCardNumber,
    CustomTextFieldVerifyTypeRepayMethod,
    CustomTextFieldVerifyTypeAnnualIncome,
    CustomTextFieldVerifyTypeCardProjectDuration,
    CustomTextFieldVerifyTypeInvestMoney
};

typedef void(^TextFieldCallBack)(UIBarButtonItem * , ZPAutoAdjustTextField *);

@interface ZPAutoAdjustTextField : UITextField
@property (copy,   nonatomic) TextFieldCallBack previousBlock;
@property (copy,   nonatomic) TextFieldCallBack nextBlock;
@property (copy,   nonatomic) TextFieldCallBack cancelBlock;
@property (copy,   nonatomic) TextFieldCallBack ensureBlock;
@property (assign, nonatomic) CustomTextFieldToolbarType textType;
@property (assign, nonatomic) CustomTextFieldVerifyType verifyType;
@property (assign, nonatomic) CGFloat adjustHeight;
@property (weak,   nonatomic) id<CustomTextFieldDelegate> customDelegate;
//@property (weak,   nonatomic) id<CustomTextFieldDelegate> delegate;

@property (assign, nonatomic,readonly) BOOL isPassed;
@property (assign, nonatomic) CustomTextFieldTextForm formStyle;

- (void)adjustTextFieldFrameWhenBeginEdtingWithView:(UIView *)view;
- (void)hiddenPlaceLabel;

@property (assign, nonatomic) CGFloat floatingLabelYPadding;
@end

@protocol CustomTextFieldDelegate <UITextFieldDelegate>

@optional
- (NSArray *)allTextFieldsWithCustomTextField:(ZPAutoAdjustTextField *)textField;
- (void)customTextField:(ZPAutoAdjustTextField *)textField previousBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField nextBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField cancelBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField ensureBarButtonItemDidClicked:(UIBarButtonItem *)item;

@end