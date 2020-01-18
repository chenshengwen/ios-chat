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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultAppID]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultAppID];
    }
    
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];

    
    if ([bundleId containsString:kJINSHENG]) {
        return kJINSHENG;
    }else if ([bundleId containsString:kYINGRONG]) {
        return kYINGRONG;
    }else if ([bundleId containsString:kYINGCHENG]) {
        return kYINGCHENG;
    }else if ([bundleId containsString:kCHENGXIN]) {
        return kCHENGXIN;
    }else if ([bundleId containsString:kJIUZHOU]) {
        return kJIUZHOU;
    }else if ([bundleId containsString:kLIYING]) {
        return kLIYING;
    }else if ([bundleId containsString:k918]) {
        return k918;
    }else if ([bundleId containsString:kShenshi]) {
        return kShenshi;
    }else {
        return k518;
    }
    
    return @"";
}

+ (NSString *)getAppURL {
    
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];

    
    if ([bundleId containsString:kJINSHENG]) {
        return kJINSHENG_URL;
    }else if ([bundleId containsString:kYINGRONG]) {
        return kYINGRONG_URL;
    }else if ([bundleId containsString:kYINGCHENG]) {
        return kYINGCHENG_URL;
    }else if ([bundleId containsString:kCHENGXIN]) {
        return kCHENGXIN_URL;
    }else if ([bundleId containsString:kJIUZHOU]) {
        return kJIUZHOU_URL;
    }else if ([bundleId containsString:kLIYING]) {
        return kLIYING_URL;
    }else if ([bundleId containsString:k918]) {
        return k918_URL;
    }else if ([bundleId containsString:kShenshi]) {
        return kShenshi_URL;
    }else {
        return k518_URL;
    }
    
    
    return @"";

}


@end
