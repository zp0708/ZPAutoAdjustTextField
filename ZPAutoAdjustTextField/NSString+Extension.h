//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)

/// 将字典转换成json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//MARK: 文件操作相关

/// 追加文档目录
- (NSString *)appendDocumentDir;

/// 追加缓存目录
- (NSString *)appendCacheDir;

/// 追加临时目录
- (NSString *)appendTempDir;

- (NSString *) md5;

- (NSString *)sha1String;

//MARK: 字符串验证
/// 邮箱验证
+ (BOOL) validateEmail:(NSString *)email;

/// 验证年化收益
+ (BOOL) validateAnnualIncome:(NSString *)income;

/// 验证投资期限
+ (BOOL) validateProjectDuration:(NSString *)duration;

/// 验证手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

/// 验证车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

/// 验证车型验证
+ (BOOL) validateCarType:(NSString *)CarType;

/// 验证用户名验证
+ (BOOL) validateUserName:(NSString *)name;

/// 验证密码
+ (BOOL) validatePassword:(NSString *)passWord;

/// 验证昵称
+ (BOOL) validateNickname:(NSString *)nickname;

/// 验证交易密码是否正确
+ (BOOL) validateTradePassword:(NSString *)passWord;
/// 是否符合交易密码的字符
+ (BOOL) validateSingleTradePassword:(NSString *)passWord;

/// 身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/// 验证验证码是否正确
+ (BOOL) validateAuthCode:(NSString *)authCode;

/// 验证银行卡号是否正确
+ (BOOL)validateBankCard:(NSString *)cardNo;

//return YES传入的字符串是空字符串
+ (BOOL)stringisEmptyString:(NSString *)string;

/**
 *  计算指定字体,宽度下字符串占据高度
 *
 *  @param font    字体大小
 *  @param width   限制宽度
 *
 *  @return 占据高度
 */
- (CGFloat)heightWithFont:(NSUInteger)font width:(CGFloat)width;

@end
