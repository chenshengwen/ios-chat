//
//  BWDealNullTool.h
//  Betway
//
//  Created by mac on 2019/4/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWDealNullTool : NSObject

/**
 处理服务器返回的空字符数据(服务器返回数据先处理空字符)
 */
+ (id)dealNullData:(id)json;

/**
 *  处理字典
 */
+ (id)dealNullWithDictionary:(NSMutableDictionary *)dic;

/**
 *  处理数组
 */
+ (id)dealNullWithArray:(NSMutableArray *)arr;

/**
 *   处理空字符串
 *
 *  @param string 需要处理的对象
 *
 *  @return 空字符串
 */
+ (NSString *)dealNullValue:(id)string;

/**
 *   处理空字符串
 *
 *  @param string 需要处理的对象
 *
 *  @return 空字符串
 */
+ (BOOL)isNullValue:(id)string;
@end

NS_ASSUME_NONNULL_END
