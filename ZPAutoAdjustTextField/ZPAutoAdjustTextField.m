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

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.adjustView = self.superview;
}

- (void)adjustTextFieldFrameWhenBeginEdtingWithView:(UIView *)view
{

}

- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _placeLbl.alpha = 1.0f;
        _placeLbl.frame = CGRectMake(0, -_placeLbl.font.lineHeight, self.frame.size.width, _placeLbl.font.lineHeight);
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        _placeLbl.alpha = 0.0f;
        _placeLbl.frame = CGRectMake(0, (self.frame.size.height - _placeLbl.font.lineHeight) * 0.5, self.frame.size.width, _placeLbl.font.lineHeight);
        
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)hiddenPlaceLabel
{
    [self hideFloatingLabel:self.isFirstResponder];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _placeLbl.text = self.placeholder;
    BOOL firstResponder = self.isFirstResponder;
//    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ?
//                                self.labelActiveColor : self.floatingLabelTextColor);
    if ((!self.text || 0 == [self.text length])) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
}

- (void)customTextFieldTextDidBegin:(UITextField *)field {
    field.textColor = [UIColor blackColor];
    if (_adjustHeight > -44) {
        [UIView animateWithDuration:0.25 animations:^{
            self.superview.y = - _adjustHeight - 50;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.superview.y = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)customTextFieldTextDidEnd:(UITextField *)field {
    [self customTextFieldVerifyWithType:_verifyType verifyEmpty:NO];
}

- (void)setToolbarWithTextType:(CustomTextFieldToolbarType)type
{
    _placeLbl = [[UILabel alloc]init];
    _placeLbl.alpha = 0.0;
    _placeLbl.font = self.font;
    _placeLbl.frame = CGRectMake(0, (self.frame.size.height - _placeLbl.font.lineHeight) * 0.5, self.frame.size.width, _placeLbl.font.lineHeight);
    
    [self addTarget:self action:@selector(customTextFieldTextDidBegin:)     forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(customTextFieldTextDidEnd:)       forControlEvents:UIControlEventEditingDidEnd];
//    [self addTarget:self action:@selector(customTextFieldTextDidChange:)    forControlEvents:UIControlEventEditingChanged];
//    [self addTarget:self action:@selector(customTextFieldTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    [self addSubview:_placeLbl];
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

- (UIFont *)defaultFloatingLabelFont
{
    UIFont *textFieldFont = nil;
    
    if (!textFieldFont && self.attributedPlaceholder && self.attributedPlaceholder.length > 0) {
        textFieldFont = [self.attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont && self.attributedText && self.attributedText.length > 0) {
        textFieldFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont) {
        textFieldFont = self.font;
    }
    
    return [UIFont fontWithName:textFieldFont.fontName size:roundf(textFieldFont.pointSize * 0.7f)];
}

- (void)updateDefaultFloatingLabelFont
{
//    UIFont *derivedFont = [self defaultFloatingLabelFont];
    
//    if (_isFloatingLabelFontDefault) {
//        self.floatingLabelFont = derivedFont;
//    }
//    else {
//        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
//        _floatingLabelFont = derivedFont;
//    }
}
#pragma mark - UITextField

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self updateDefaultFloatingLabelFont];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updateDefaultFloatingLabelFont];
}

- (CGSize)intrinsicContentSize
{
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_placeLbl sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _floatingLabelYPadding + _placeLbl.bounds.size.height);
}

- (void)setFloatingLabelText:(NSString *)text
{
    _placeLbl.text = text;
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:placeholder];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:attributedPlaceholder.string];
    [self updateDefaultFloatingLabelFont];
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle
{
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:floatingTitle];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
