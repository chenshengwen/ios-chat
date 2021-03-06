//
//  GlobalTool.h
//  WildFireChat
//
//  Created by 陈圣文 on 2020/1/2.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTool : NSObject

+ (instancetype)shareInstance;

+ (NSString *)getAppID;

+ (NSString *)getAppURL;

+ (NSString *)getAliasType;

@end

NS_ASSUME_NONNULL_END
