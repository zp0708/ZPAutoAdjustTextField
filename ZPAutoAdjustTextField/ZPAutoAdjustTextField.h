//
//  RTHXCustomTextField.h
//  RTHXiOSApp
//
//  Created by ZP on 15/11/2.
//  Copyright © 2015年 ZP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPAutoAdjustTextField;
@protocol CustomTextFieldDelegate;

static NSString * const RTHXCustomTextFieldDidClickedPreviousBarButtonItem                   = @"RTHXCustomTextFieldDidClickedPreviousBarButtonItem";
static NSString * const RTHXCustomTextFieldDidClickedNextBarButtonItem                       = @"RTHXCustomTextFieldDidClickedNextBarButtonItem";
static NSString * const RTHXCustomTextFieldDidClickedCancelBarButtonItem                     = @"RTHXCustomTextFieldDidClickedCancelBarButtonItem";
static NSString * const RTHXCustomTextFieldDidClickedEnsureBarButtonItem                     = @"RTHXCustomTextFieldDidClickedEnsureBarButtonItem";
static NSString * const RTHXCustomTextFieldBarButtonItem                                     = @"rthx_custom_barbuttonitem";
static NSString * const RTHXCustomTextFieldCustomTextField                                   = @"rthx_custom_textfield";

typedef NS_ENUM(NSInteger, CustomTextFieldType) {
    CustomTextFieldTypePreviousNextCancelEnsure,  // default
    CustomTextFieldTypePreviousNextEnsure,
    CustomTextFieldTypeCancelEnsure,
};

typedef void(^TextFieldCallBack)(UIBarButtonItem * , ZPAutoAdjustTextField *);

@interface ZPAutoAdjustTextField : UITextField
@property (copy, nonatomic) TextFieldCallBack previousBlock;
@property (copy, nonatomic) TextFieldCallBack nextBlock;
@property (copy, nonatomic) TextFieldCallBack cancelBlock;
@property (copy, nonatomic) TextFieldCallBack ensureBlock;
@property (assign, nonatomic) CustomTextFieldType textType;
@property (assign, nonatomic) CGFloat adjustHeight;
@property (weak, nonatomic) id<CustomTextFieldDelegate> customDelegate;

- (void)adjustTextFieldFrameWhenBeginEdtingWithView:(UIView *)view;

@end

@protocol CustomTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)customTextField:(ZPAutoAdjustTextField *)textField previousBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField nextBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField cancelBarButtonItemDidClicked:(UIBarButtonItem *)item;
- (void)customTextField:(ZPAutoAdjustTextField *)textField ensureBarButtonItemDidClicked:(UIBarButtonItem *)item;

- (BOOL)customTextFieldShouldBeginEditing:(ZPAutoAdjustTextField *)textField;
- (void)customTextFieldDidBeginEditing:(ZPAutoAdjustTextField *)textField;
- (BOOL)customTextFieldShouldEndEditing:(ZPAutoAdjustTextField *)textField;
- (void)customTextFieldDidEndEditing:(ZPAutoAdjustTextField *)textField;
- (BOOL)customTextField:(ZPAutoAdjustTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)customTextFieldShouldClear:(ZPAutoAdjustTextField *)textField;
- (BOOL)customTextFieldShouldReturn:(ZPAutoAdjustTextField *)textField;

@end
