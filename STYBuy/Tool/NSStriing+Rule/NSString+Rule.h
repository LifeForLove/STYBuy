//
//  NSString+Rule.h
//  qwer
//
//  Created by 杜顺 on 16/11/10.
//  Copyright © 2016年 杜顺. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  判断是否是空字符串 空字符串 = yes
 *
 *  @param string
 *
 *  @return
 */
#define  IsEmptyStr(string) string == nil || string == NULL || [string isEqualToString:@""] ||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO

//判断是否是空字符串
#define  NOEmptyStr(string)  string == nil ||[string isEqualToString: @""] || string == NULL ||[string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? NO : YES

typedef enum : NSUInteger {
    OnlyContainDefault,                     //默认
    OnlyContainChinese,                     // 仅仅包含中文
    OnlyContainEnglish,                     // 仅仅包含英文
    OnlyContainNum,                         // 仅仅包含数字
    OnlyContainChineseEnglish,              // 仅仅包含中文和英文
    OnlyContainChineseAndNum,               // 仅仅包含中文和数字
    OnlyContainEnglishAndNum,               // 仅仅包含英文和数字
    OnlyContainChineseEnglistNum,           // 仅仅包含中文、英文、数字。
} OnlyContainType;



@interface NSString (Rule)

//进行MD5加密
- (id)MD5;

/**
 判断字符串是否符合规则
 @param type 设置规则
 @return 是否符合规则
 */
- (BOOL)isOnlyContainRule:(OnlyContainType)type;


/**
 判断字符串是否是邮箱格式的字符串
 @return 是否符合规则
 */
- (BOOL)isEmailFormatString;



/**
 判断是否是手机号码格式的字符串
 @return 是否满足规则
 */
- (BOOL)isPhoneNumFormatString;



/**
 判断是否是微信格式的字符串
 @return 是否满足规则
 */
- (BOOL)isWeiXinFormatString;



/**
 转换为金钱格式的字符串
 就是每3个数字时间添加逗号
 
 @return 转化后的字符串
 */
- (NSString *)tranToMoneyFormatterString;



- (NSString *)getMoneyStringWithMoneyNumber;


/**
 判断是不是昵称
 */
- (BOOL)isNameText;


/**
 获取版本号
 */
+ (NSString *)uniqueVersion;


/**
 获取设备的唯一标识
 */
//+ (NSString *)onlycode;


/**
 计算label的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;



/**
 富文本计算文字宽高

 @param maxW 最大宽度
 @param lineSpace 行间距
 @param wordSpace 字间距
 @param font 文字大小
 @return 文字的宽高
 */
- (CGSize)boundReactWithMaxW:(CGFloat)maxW LineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace titleFont:(UIFont *)font;

/**
 富文本计算文字宽高,设置最大行数

 @param maxLines 最大行数
 @param maxW 最大宽度
 @param lineSpace 行间距
 @param wordSpace 字间距
 @param font 文字大小
 @return 文字的宽高
 */
- (CGSize)boundReactWithMaxLines:(NSInteger)maxLines MaxW:(CGFloat)maxW LineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace titleFont:(UIFont *)font;

/**
 是否包含中文

 @param str 字符串
 @return 包含返回yes
 */
- (BOOL)containChinese:(NSString *)str ;

/**
 转换时间戳
 @param format @"yyyy-MM-dd-HH-mm-ss" 格式
 @return 转换后的时间
 */
- (NSString *)changeTimewithFormat:(NSString *)format;





@end



























