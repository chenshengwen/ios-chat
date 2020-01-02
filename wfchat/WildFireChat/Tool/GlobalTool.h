//
//  GlobalTool.h
//  WildFireChat
//
//  Created by 陈圣文 on 2020/1/2.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *myAPPID = k518;

@interface GlobalTool : NSObject


+ (NSString *)getAppID;

+ (NSString *)getAppURL;

@end

NS_ASSUME_NONNULL_END
