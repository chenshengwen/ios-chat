//
//  BWValidatorTool.m
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BWValidatorTool.h"
#import "BWInputValidator.h"

@implementation BWValidatorTool

/**
 *  验证是否由字母数字汉字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorConHanCharacters:(NSString *)string
            containOtherCharacter:(NSString *)containOtherCharacter{
//    BOOL isCan = [string isValidProvinceWithMinLenth:1 maxLenth:100 containChinese:YES firstCannotBeDigtal:NO];
    BOOL isCan = [string isChineseAndLetterAndNumberWithMinLenth:1 maxLenth:100 containOtherCharacter:containOtherCharacter];
    return isCan;
}
/**
 *  验证是否由字母数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由字母组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorOnlyCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorNumbers:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由字母、数字、_@.+- 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorEmailCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@.+-"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否由字母、数字、^#$@ 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorPasswordCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789^#$@"]invertedSet];
//    NSCharacterSet* charSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

/**
 *  验证是否包含特殊字符
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorSpecialCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [NSCharacterSet characterSetWithCharactersInString:@"!@#$%^&*()（）“”"];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return ![string isEqualToString:filtered];

}

/**
 *  验证是否包含特殊字符
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorRemarkCharacters:(NSString *)string
{
    NSCharacterSet* charSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 /-#:：?？!！.。&()（），,"];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    return ![string isEqualToString:filtered];
    
}


+(void)showMessage:(NSString *)message{
    [[BWInputValidator shareBWInputValidator] showErrorMessage:message];
}
@end
