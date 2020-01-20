//
//  GlobalTool.m
//  WildFireChat
//
//  Created by 陈圣文 on 2020/1/2.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import "GlobalTool.h"


@interface GlobalTool ()
@end

@implementation GlobalTool

+ (instancetype)shareInstance {
    static GlobalTool *helper;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[GlobalTool alloc] init];
    });
    return helper;
}

+ (NSString *)getAppID {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultAppID];
}

+ (NSString *)getAppURL {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultAppURL];

}

+ (NSString *)getAliasType {
    return @"youmeng";
}


@end
