//
//  RTHXCustomTextField.m
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/11/2.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#import "ZPAutoAdjustTextField.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "NSString+Extension.h"
#import "CALayer+SLPopAddition.h"
#import "ZPProgressHUD.h"
#import "POP.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

NSString * const RTHXCustomTextFieldDidClickedPreviousBarButtonItem                   = @"RTHXCustomTextFieldDidClickedPreviousBarButtonItem";
NSString * const RTHXCustomTextFieldDidClickedNextBarButtonItem                       = @"RTHXCustomTextFieldDidClickedNextBarButtonItem";
NSString * const RTHXCustomTextFieldDidClickedCancelBarButtonItem                     = @"RTHXCustomTextFieldDidClickedCancelBarButtonItem";
NSString * const RTHXCustomTextFieldDidClickedEnsureBarButtonItem                     = @"RTHXCustomTextFieldDidClickedEnsureBarButtonItem";
NSString * const RTHXCustomTextFieldBarButtonItem                                     = @"rthx_custom_barbuttonitem";
NSString * const RTHXCustomTextFieldCustomTextField                                   = @"rthx_custom_textfield";

@interface ZPAutoAdjustTextField () <CustomTextFieldDelegate>
@property (strong, nonatomic) UILabel *placeLbl;
@property (weak,   nonatomic) UIView  *adjustView;
@property (assign, nonatomic) CGFloat adjustY;
@end

@implementation ZPAutoAdjustTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setToolbarWithTextType:CustomTextFieldToolbarTypePreviousNextCancelEnsure];
        _adjustHeight = 260 - [self textFieldAdjustHeightWhenKeyBoardShow];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setToolbarWithTextType:CustomTextFieldToolbarTypePreviousNextCancelEnsure];
        _adjustHeight = 260 - [self textFieldAdjustHeightWhenKeyBoardShow];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setToolbarWithTextType:CustomTextFieldToolbarTypePreviousNextCancelEnsure];
    self.adjustHeight = 260 - [self textFieldAdjustHeightWhenKeyBoardShow];
}

- (CGFloat)textFieldAdjustHeightWhenKeyBoardShow
{
    UIView *view = self.superview;
    return SCREENHEIGHT - self.height - self.y - view.y - 24;
}

- (void)customTextFieldKeyboardDidChange:(NSNotification *)note
{
    if ([note.name isEqualToString:UIKeyboardWillShowNotification]) {

    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.adjustView.y = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)adjustTextFieldFrameWhenBeginEdtingWithView:(UIView *)view
{
    self.adjustView = view;
    if (_adjustHeight > -44) {
        [UIView animateWithDuration:0.25 animations:^{
            view.y = - _adjustHeight - 20;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            view.y = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)showLabel
{
    [_placeLbl.layer pop_removeAllAnimations];
    self.placeLbl.layer.opacity = 1.0;
    POPSpringAnimation *layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(.5f, .5f)];
    [self.placeLbl.layer pop_addAnimation:layerScaleAnimation forKey:@"labelScaleAnimation"];
    
    POPBasicAnimation *layerAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    layerAnimation.toValue = @(30);
    [self.placeLbl.layer pop_addAnimation:layerAnimation forKey:@"layerAnimation"];
    
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(-20);
    layerPositionAnimation.springBounciness = 12;
    [self.placeLbl.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)hideLabel
{
    [_placeLbl.layer pop_removeAllAnimations];
    POPBasicAnimation *layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.placeLbl.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(5);
    [self.placeLbl.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
    layerScaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if(finished) [self.placeLbl removeFromSuperview];
    };
}

- (void)customTextFieldTextDidChange:(ZPAutoAdjustTextField *)sender
{
    self.placeLbl.text = [NSString stringWithFormat:@"%@(%ld)",self.placeholder,(long)sender.text.length];
    [self showOrHiddenTopPlaceholderWithText:sender.text];
}

- (void)customTextFieldTextDidBegin:(ZPAutoAdjustTextField *)sender
{
    [self showOrHiddenTopPlaceholderWithText:sender.text];
}

- (void)customTextFieldTextDidEnd:(ZPAutoAdjustTextField *)sender
{
    [self showOrHiddenTopPlaceholderWithText:@""];
}

- (void)hiddenPlaceLabel
{
    [self showOrHiddenTopPlaceholderWithText:@""];
}

- (void)customTextFieldTextDidEndOnExit:(ZPAutoAdjustTextField *)sender
{
    
}

- (void)showOrHiddenTopPlaceholderWithText:(NSString *)text
{
    /*
    if (text.length  >= 1) {
        if (self.placeLbl.y != -20){
            [self addSubview:self.placeLbl];
            [UIView animateWithDuration:0.25 animations:^{
                _placeLbl.y = -20;
                _placeLbl.alpha = 1;
            }];
        }
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _placeLbl.y = 0;
            _placeLbl.alpha = 0.01;
        }completion:^(BOOL finished) {
            [_placeLbl removeFromSuperview];
        }];
    }
     */
//    if (text.length  >= 1 && _placeLbl.superview == nil) {
//        [self addSubview:_placeLbl];
//        [self showLabel];
//    }else{
//    
//        [self hideLabel];
//    }
}

- (void)setToolbarWithTextType:(CustomTextFieldToolbarType)type
{
    self.delegate = self;
    
    [self addTarget:self action:@selector(customTextFieldTextDidBegin:)     forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(customTextFieldTextDidEnd:)       forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(customTextFieldTextDidChange:)    forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(customTextFieldTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.clipsToBounds = NO;
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *previousBarButton = [UIBarButtonItem itemWithTarget:self type:buttonBackType action:@selector(previousButtonClicked:)];
    UIBarButtonItem *nextBarButton     = [UIBarButtonItem itemWithTarget:self type:buttonForwardType action:@selector(nextButtonClicked:)];
    UIBarButtonItem *flexBarButton     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelBarButton   = [[UIBarButtonItem alloc] initWithTitle:@"取消" target:self action:@selector(cancelButtonClicked:)];
    UIBarButtonItem *doneBarButton     = [[UIBarButtonItem alloc] initWithTitle:@"确定" target:self action:@selector(ensureButtonClicked:)];
    NSArray *barButtonItems;
    switch (_textType) {
        case CustomTextFieldToolbarTypeCancelEnsure:
        {
            barButtonItems = @[cancelBarButton,flexBarButton, doneBarButton];
        }
            break;
        case CustomTextFieldToolbarTypePreviousNextEnsure:
        {
            barButtonItems = @[previousBarButton, nextBarButton, flexBarButton, doneBarButton];
        }
            break;
        case CustomTextFieldToolbarTypePreviousNextCancelEnsure:
        {
            barButtonItems = @[previousBarButton, nextBarButton, flexBarButton,cancelBarButton, doneBarButton];
        }
            break;
            
        default:
            break;
    }
    toolbar.items = barButtonItems;
    self.inputAccessoryView = toolbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customTextFieldKeyboardDidChange:) name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)customTextFieldVerifyWithType:(CustomTextFieldVerifyType)type verifyEmpty:(BOOL)verify
{
    switch (type) {
        case CustomTextFieldVerifyTypeNone:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"请填写所有信息"];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeMobile:
        {
            NSString *string = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (verify && [NSString stringisEmptyString:string]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"手机号不能为空"];
                return NO;
            }else if (![NSString validateMobile:string] && ![NSString stringisEmptyString:string]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"手机号格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeUserName:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"用户名不能为空"];
                return NO;
            }else if (![NSString validateUserName:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"用户名格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypePassword:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"密码不能为空"];
                return NO;
            }else if (![NSString validatePassword:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"密码格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeNickName:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"昵称不能为空"];
                return NO;
            }else if (![NSString validateNickname:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"昵称格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeTradePassword:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"交易密码不能为空"];
                return NO;
            }else if (![NSString validateTradePassword:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"交易密码格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeIdentityCard:
        {
            NSString *string = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (verify && [NSString stringisEmptyString:string]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"身份证号不能为空"];
                return NO;
            }else if (![NSString validateIdentityCard:string] && ![NSString stringisEmptyString:string]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"身份证号格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeVerifyCode:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"验证码不能为空"];
                return NO;
            }else if (![NSString validateAuthCode:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"验证码格式错误"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeBankArea:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"请选择开户行地区"];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeBank:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"请选择开户行"];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeCardNumber:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"请输入银行卡号"];
                return NO;
            }else{
                return YES;
            }
        }
            break;
            
        case CustomTextFieldVerifyTypeRepayMethod:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"还款方式不能为空"];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeAnnualIncome:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"年化收益不能为空"];
                return NO;
            }else if (![NSString validateAnnualIncome:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"年化收益输入超限"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeCardProjectDuration:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"项目期限不能为空"];
                return NO;
            }else if (![NSString validateProjectDuration:self.text] && ![NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"项目期限超限"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
        case CustomTextFieldVerifyTypeInvestMoney:
        {
            if (verify && [NSString stringisEmptyString:self.text]) {
                [ZPProgressHUD zp_showErrorWithStatus:@"投资金额不能为空"];
                self.textColor = [UIColor redColor];
                [self.layer shake];
                return NO;
            }else{
                return YES;
            }
        }
            break;
            
        default:
            return NO;
            break;
    }
}

#pragma mark - delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldShouldBeginEditing:)]) {
        return [self.customDelegate customTextFieldShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldDidBeginEditing:)]) {
        [self.customDelegate customTextFieldDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldShouldEndEditing:)]) {
        return [self.customDelegate customTextFieldShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self customTextFieldVerifyWithType:_verifyType verifyEmpty:NO];
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldDidEndEditing:)]) {
        [self.customDelegate customTextFieldDidEndEditing:self];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    switch (_formStyle) {
        case CustomTextFieldTextFormMobile:
            return [self moblieTextField:textField shouldChangeCharactersInRange:range replacementString:string];
            break;
        case CustomTextFieldTextFormBankCard:
            return [self bankCardTextField:textField shouldChangeCharactersInRange:range replacementString:string];
        break;
        
        case CustomTextFieldTextFormIdentity:
            return [self identityTextField:textField shouldChangeCharactersInRange:range replacementString:string];
        break;

        default:
        {
            if ([self.customDelegate respondsToSelector:@selector(customTextField:shouldChangeCharactersInRange:replacementString:)]) {
                return [self.customDelegate customTextField:self shouldChangeCharactersInRange:range replacementString:string];
            }
            if ([string isEqualToString:@""]) return YES;
            if(self.verifyType == CustomTextFieldVerifyTypeInvestMoney) return textField.text.length <= 7;
        }
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldShouldClear:)]) {
        return [self.customDelegate customTextFieldShouldClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self nextCustomTextFieldBecomeFirstResponder];
    if ([self.customDelegate respondsToSelector:@selector(customTextFieldShouldReturn:)]) {
        return [self.customDelegate customTextFieldShouldReturn:self];
    }
    return YES;
}

#pragma mark - setter && block && notice


- (void)setTextType:(CustomTextFieldToolbarType)textType
{
    _textType = textType;
    [self setToolbarWithTextType:textType];
}

- (BOOL)isPassed
{
    return [self customTextFieldVerifyWithType:_verifyType verifyEmpty:YES];
}

- (void)previousButtonClicked:(UIBarButtonItem *)btn
{
    if (self.previousBlock != nil) {
        self.previousBlock(btn,self);
    }
    if ([self.customDelegate respondsToSelector:@selector(customTextField:previousBarButtonItemDidClicked:)]) {
        [self.customDelegate customTextField:self previousBarButtonItemDidClicked:btn];
    }
    NSDictionary *dict = @{RTHXCustomTextFieldBarButtonItem : btn, RTHXCustomTextFieldCustomTextField : self};
    NSNotification *notice = [NSNotification notificationWithName:RTHXCustomTextFieldDidClickedPreviousBarButtonItem object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    NSArray *fields;
    if ([self.customDelegate respondsToSelector:@selector(allTextFieldsWithCustomTextField:)]) {
        fields = [self.customDelegate allTextFieldsWithCustomTextField:self];
    }
    if(fields.count == 0) return;
    NSInteger index = [fields indexOfObject:self];
    if(index == 0){
        [fields.lastObject becomeFirstResponder];
        return;
    }
    [fields[index - 1] becomeFirstResponder];
}

- (void)nextButtonClicked:(UIBarButtonItem *)btn
{
    if (self.nextBlock != nil) {
        self.nextBlock(btn,self);
    }
    if ([self.customDelegate respondsToSelector:@selector(customTextField:nextBarButtonItemDidClicked:)]) {
        [self.customDelegate customTextField:self nextBarButtonItemDidClicked:btn];
    }
    NSDictionary *dict = @{RTHXCustomTextFieldBarButtonItem : btn, RTHXCustomTextFieldCustomTextField : self};
    NSNotification *notice = [NSNotification notificationWithName:RTHXCustomTextFieldDidClickedNextBarButtonItem object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    [self nextCustomTextFieldBecomeFirstResponder];
}

- (void)nextCustomTextFieldBecomeFirstResponder
{
    NSArray *fields;
    if ([self.customDelegate respondsToSelector:@selector(allTextFieldsWithCustomTextField:)]) {
        fields = [self.customDelegate allTextFieldsWithCustomTextField:self];
    }
    if(fields.count == 0) return;
    NSInteger index = [fields indexOfObject:self];
    if(index == fields.count - 1){
        [fields.firstObject becomeFirstResponder];
        return;
    }
    [fields[index + 1] becomeFirstResponder];
}

- (void)cancelButtonClicked:(UIBarButtonItem *)btn
{
    self.text = nil;
    [self resignFirstResponder];
    if (self.cancelBlock != nil) {
        self.cancelBlock(btn,self);
    }
    if ([self.customDelegate respondsToSelector:@selector(customTextField:cancelBarButtonItemDidClicked:)]) {
        [self.customDelegate customTextField:self cancelBarButtonItemDidClicked:btn];
    }
    NSDictionary *dict = @{RTHXCustomTextFieldBarButtonItem : btn, RTHXCustomTextFieldCustomTextField : self};
    NSNotification *notice = [NSNotification notificationWithName:RTHXCustomTextFieldDidClickedCancelBarButtonItem object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

- (void)ensureButtonClicked:(UIBarButtonItem *)btn
{
    NSArray *fields;
    if ([self.customDelegate respondsToSelector:@selector(allTextFieldsWithCustomTextField:)]) {
        fields = [self.customDelegate allTextFieldsWithCustomTextField:self];
    }
    BOOL  isAllTextFieldTextNotEmpty = NO;
    for (ZPAutoAdjustTextField *textField in fields) {
        isAllTextFieldTextNotEmpty = ![NSString stringisEmptyString:textField.text];
        
        if (!isAllTextFieldTextNotEmpty) {
            [textField becomeFirstResponder];
            isAllTextFieldTextNotEmpty = NO;
            break;
        }
    }
    
    if (isAllTextFieldTextNotEmpty || fields.count == 0) {
        [self resignFirstResponder];
        if (self.ensureBlock != nil) {
            self.ensureBlock(btn,self);
        }
        if ([self.customDelegate respondsToSelector:@selector(customTextField:ensureBarButtonItemDidClicked:)]) {
            [self.customDelegate customTextField:self ensureBarButtonItemDidClicked:btn];
        }
        NSDictionary *dict = @{RTHXCustomTextFieldBarButtonItem : btn, RTHXCustomTextFieldCustomTextField : self};
        NSNotification *notice = [NSNotification notificationWithName:RTHXCustomTextFieldDidClickedEnsureBarButtonItem object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
    }
}

#pragma mark - 格式化代码待优化

 - (BOOL)moblieTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
     NSString *text = [textField text];
     
     NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"Xx0123456789\b"];
     string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
     if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
     return NO;
     }
     
     text = [text stringByReplacingCharactersInRange:range withString:string];
     text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
     
     if (text.length > 11) {
     return NO;
     }
     
     NSString *newString = @"";
     NSString *firstString = @"";
     NSString *secondString = @"";
     
     if (text.length <= 3) {
     firstString = text;
     }else{
     firstString = [text substringToIndex:3];
     secondString = [text substringFromIndex:3];
     }
     
     while (firstString.length > 0) {
     NSString *subString = [firstString substringToIndex:MIN(firstString.length, 3)];
     newString = [newString stringByAppendingString:subString];
     if (subString.length == 3) {
     newString = [newString stringByAppendingString:@" "];
     }
     firstString = [firstString substringFromIndex:MIN(firstString.length, 3)];
     }
     
     newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
     if (secondString.length != 0) newString = [newString stringByAppendingString:@" "];
     textField.text = newString;
     newString = @"";
     
     while (secondString.length > 0) {
     NSString *subString = [secondString substringToIndex:MIN(secondString.length, 4)];
     newString = [newString stringByAppendingString:subString];
     if (subString.length == 4) {
     newString = [newString stringByAppendingString:@" "];
     }
     secondString = [secondString substringFromIndex:MIN(secondString.length, 4)];
     }
     newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
     [textField setText:[NSString stringWithFormat:@"%@%@",textField.text,newString]];
     [self showOrHiddenTopPlaceholderWithText:textField.text];
     return NO;
 }

- (BOOL)bankCardTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (text.length > 20) {
        return NO;
    }
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    [textField setText:newString];
    [self showOrHiddenTopPlaceholderWithText:textField.text];
    return NO;
}

- (BOOL)identityTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"Xx0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (text.length > 18) {
        return NO;
    }
    
    NSString *newString = @"";
    NSString *firstString = @"";
    NSString *secondString = @"";
    
    if (text.length <= 6) {
        firstString = text;
    }else{
        firstString = [text substringToIndex:6];
        secondString = [text substringFromIndex:6];
    }
    
    while (firstString.length > 0) {
        NSString *subString = [firstString substringToIndex:MIN(firstString.length, 6)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 6) {
            newString = [newString stringByAppendingString:@" "];
        }
        firstString = [firstString substringFromIndex:MIN(firstString.length, 6)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    if (secondString.length != 0) newString = [newString stringByAppendingString:@" "];
    textField.text = newString;
    newString = @"";
    
    while (secondString.length > 0) {
        NSString *subString = [secondString substringToIndex:MIN(secondString.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        secondString = [secondString substringFromIndex:MIN(secondString.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    [textField setText:[NSString stringWithFormat:@"%@%@",textField.text,newString]];
    [self showOrHiddenTopPlaceholderWithText:textField.text];
    return NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
