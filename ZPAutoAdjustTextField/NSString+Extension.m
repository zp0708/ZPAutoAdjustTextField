//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (CGFloat)heightWithFont:(NSUInteger)font width:(CGFloat)width
{
    CGSize size =CGSizeMake(width,MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName,nil];
    CGSize  actualsize =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    return actualsize.height;
}

- (NSString *)sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

#pragma mark - 助手方法

- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}

- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}

+ (BOOL)validateAnnualIncome:(NSString *)income
{
    return [income floatValue] <= 20;
}

+ (BOOL)validateProjectDuration:(NSString *)duration
{
    return [duration floatValue] <= 36;
}

+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";//@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

+ (BOOL) validateSingleTradePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{1,1}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL) validateTradePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{8,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL) validateNickname:(NSString *)nickname
{
//    NSString *nicknameRegex = @"^[A-Za-z0-9-\u4e00-\u9fa5]{4,20}$";
    NSString *nicknameRegex = @"^.{1,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)stringisEmptyString:(NSString *)string
{
    return (string == nil || [string isEqualToString:@""]);
}

+ (BOOL)validateAuthCode:(NSString *)authCode
{
    NSString *passWordRegex = @"^[0-9]{6,6}";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:authCode];
}

+ (BOOL)validateBankCard:(NSString *)cardNo{
    if (cardNo.length == 0) {
        return NO;
    }
    int oddsum  = 0;
    int evensum = 0;
    int allsum  = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

@end
