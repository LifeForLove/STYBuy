//
//  NSString+Rule.m
//  qwer
//
//  Created by 杜顺 on 16/11/10.
//  Copyright © 2016年 杜顺. All rights reserved.
//

#import "NSString+Rule.h"
#import <CommonCrypto/CommonDigest.h>

#define Rule_zw                  @"[\u4E00-\u9FA5]"                                 //中文
#define Rule_yw                  @"[a-zA-Z]"                                        //英文
#define Rule_sz                  @"[\\u0030-\\u0039]"                               //数字
#define Rule_zw_yw               @"[a-zA-Z\u4E00-\u9FA5]"                           //中文英文
#define Rule_zw_sz               @"[\u4E00-\u9FA5\\u0030-\\u0039]"                  //中文数字
#define Rule_yw_sz               @"[a-zA-Z\\u0030-\\u0039]"                         //英文数字
#define Rule_zw_yw_sz            @"[a-zA-Z\u4E00-\u9FA5\\u0030-\\u0039]"            //中文英文数字

@implementation NSString (Rule)

//进行MD5加密
- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < 16; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


/**
 限制字符串的类型

 @param type 所要限制的类型
 @return 是否满足自己设定的类型
 */
- (BOOL)isOnlyContainRule:(OnlyContainType)type
{
    NSArray *array = @[Rule_zw , Rule_yw , Rule_sz , Rule_zw_yw , Rule_zw_sz , Rule_yw_sz , Rule_zw_yw_sz];
    for (int  i = 0; i < self.length; i ++) {
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        NSString *pattern = array[type-1];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL result = [predicate evaluateWithObject:str];
        if (!result) {
            return NO;
        }
    }
    return YES;
    
}


/**
 判断是否是邮箱格式的字符串
 @return 是否满足又想格式
 */
- (BOOL)isEmailFormatString
{
    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isNameText
{
    NSString *emailRegex = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:self];
}



/**
 判断是否是手机号码格式的字符串
 @return 是否满足规则
 */
- (BOOL)isPhoneNumFormatString
{
    //移动号段正则表达式
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(168)|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    //联通号段正则表达式
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    //电信号段正则表达式
    NSString *CT_NUM = @"^((133)|(153)|(17[3,7])|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}



/**
 判断是否是微信格式的字符串
 @return 是否满足规则
 */
- (BOOL)isWeiXinFormatString
{
    NSString * regx = @"^[a-zA-Z\\d_]{5,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    return [predicate evaluateWithObject:self];
}





/**
 数字字符串转换为金钱格式
 
 @return 转换后的字符串
 */
- (NSString *)tranToMoneyFormatterString
{
    NSMutableString *mString = [NSMutableString string];
    NSString *string  =   [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSInteger count = string.length / 3;
    if (count == 0) {
        return string;
    }
    
    NSInteger num   = string.length % 3;
    if (num != 0) {
        [mString appendString:[string substringToIndex:num]];
        [mString appendString:@","];
    }
    string = [string substringFromIndex:num];
    for (int i = 0; i < count; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(3 * i, 3)];
        [mString appendFormat:@"%@,",str];
    }
    [mString deleteCharactersInRange:NSMakeRange(mString.length - 1, 1)]; 
    return [mString copy];
}

- (NSString *)getMoneyStringWithMoneyNumber{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    return formattedNumberString;
}

/*************** 返回当前的版本号 ***************/
+ (NSString *)uniqueVersion
{
    NSDictionary *dictionary = [NSBundle mainBundle].infoDictionary;
    NSString *version = dictionary[@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"v%@",version];
}
/*
+ (NSString *)onlycode
{
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    if (keychainStore[@"onlycode"].length == 0) {
        NSString *adId = [[UIDevice currentDevice].identifierForVendor UUIDString];
        if (adId.length == 0) {
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;
            double i=time;
            NSString * uniqueString = [NSString stringWithFormat:@"%.f",i];
            keychainStore[@"onlycode"] = uniqueString;
        }else
        {
            keychainStore[@"onlycode"] = adId;
        }
    }
    return keychainStore[@"onlycode"];
}
*/
    
// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/**
 *  计算文字尺寸
 *  @param font    文字的字体
 *  @param maxW 文字的最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


- (CGSize)boundReactWithMaxW:(CGFloat)maxW LineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace titleFont:(UIFont *)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [self length])];
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [self length])];
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGRect attrRect =  [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((attrRect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            attrRect = CGRectMake(attrRect.origin.x, attrRect.origin.y, attrRect.size.width, attrRect.size.height-paragraphStyle.lineSpacing);
        }
    }
    
    return attrRect.size;
   
}

- (CGSize)boundReactWithMaxLines:(NSInteger)maxLines MaxW:(CGFloat)maxW LineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace titleFont:(UIFont *)font 
{
    if (maxLines <= 0) {
        return CGSizeMake(0, 0);
    }
    
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpace * (maxLines - 1);
    
    CGSize orginalSize = [self boundReactWithMaxW:maxW LineSpace:lineSpace WordSpace:wordSpace titleFont:font];

    return orginalSize.height >= maxHeight ? CGSizeMake(maxW, maxHeight) : CGSizeMake(maxW, orginalSize.height);
}


//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}


/**
 转换时间戳

 @param format @"yyyy-MM-dd-HH-mm-ss" 格式
 @return 转换后的时间
 */
- (NSString *)changeTimewithFormat:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    return  [formatter stringFromDate:confromTimesp];
}






@end







