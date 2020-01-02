//
//  GlobalTool.m
//  WildFireChat
//
//  Created by 陈圣文 on 2020/1/2.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import "GlobalTool.h"

@implementation GlobalTool

+ (NSString *)getAppID {
    if ([myAPPID isEqualToString:kShenshi]) {
        return kShenshi;
    }else if ([myAPPID isEqualToString:kJINSHENG]) {
        return kJINSHENG;
    }else if ([myAPPID isEqualToString:kYINGRONG]) {
        return kYINGRONG;
    }else if ([myAPPID isEqualToString:kYINGCHENG]) {
        return kYINGCHENG;
    }else if ([myAPPID isEqualToString:kCHENGXIN]) {
        return kCHENGXIN;
    }else if ([myAPPID isEqualToString:kJIUZHOU]) {
        return kJIUZHOU;
    }else if ([myAPPID isEqualToString:kLIYING]) {
        return kLIYING;
    }else if ([myAPPID isEqualToString:k918]) {
        return k918;
    }else if ([myAPPID isEqualToString:k518]) {
        return k518;
    }
    
    return @"";
}

+ (NSString *)getAppURL {
    if ([myAPPID isEqualToString:kShenshi]) {
        return kShenshi_URL;
    }else if ([myAPPID isEqualToString:kJINSHENG]) {
        return kJINSHENG_URL;
    }else if ([myAPPID isEqualToString:kYINGRONG]) {
        return kYINGRONG_URL;
    }else if ([myAPPID isEqualToString:kYINGCHENG]) {
        return kYINGCHENG_URL;
    }else if ([myAPPID isEqualToString:kCHENGXIN]) {
        return kCHENGXIN_URL;
    }else if ([myAPPID isEqualToString:kJIUZHOU]) {
        return kJIUZHOU_URL;
    }else if ([myAPPID isEqualToString:kLIYING]) {
        return kLIYING_URL;
    }else if ([myAPPID isEqualToString:k918]) {
        return k918_URL;
    }else if ([myAPPID isEqualToString:k518]) {
        return k518_URL;
    }
    
    return @"";

}

@end
