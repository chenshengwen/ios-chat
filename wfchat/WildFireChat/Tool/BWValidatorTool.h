//
//  BWValidatorTool.h
//  Betway
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWValidatorTool : NSObject

/**
 *  验证是否由字母数字汉字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorConHanCharacters:(NSString *)string containOtherCharacter:(NSString *)containOtherCharacter;
/**
 *  验证是否由字母数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorCharacters:(NSString *)string;

/**
 *  验证是否由字母组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorOnlyCharacters:(NSString *)string;

/**
 *  验证是否由数字组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorNumbers:(NSString *)string;

/**
 *  验证是否由字母、数字、_、@ 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorEmailCharacters:(NSString *)string;

/**
 *  验证是否由字母、数字、^#$@ 组成
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorPasswordCharacters:(NSString *)string;

/**
 *  验证是否包含特殊字符
 *
 *  @param string 需要验证的字符串
 *
 *  @return 验证合法返回YES
 */
+ (BOOL)validatorSpecialCharacters:(NSString *)string;

+ (BOOL)validatorRemarkCharacters:(NSString *)string;

+(void)showMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
