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
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

    
    if ([appName isEqualToString:@"【盛世】"]) {
        return kShenshi;
    }else if ([appName isEqualToString:@"金盛"]) {
        return kJINSHENG;
    }else if ([appName isEqualToString:@"盈融"]) {
        return kYINGRONG;
    }else if ([appName isEqualToString:@"赢城"]) {
        return kYINGCHENG;
    }else if ([appName isEqualToString:@"诚信"]) {
        return kCHENGXIN;
    }else if ([appName isEqualToString:@"九州"]) {
        return kJIUZHOU;
    }else if ([appName isEqualToString:@"利赢"]) {
        return kLIYING;
    }else if ([appName isEqualToString:@"918"]) {
        return k918;
    }else if ([appName isEqualToString:@"518"]) {
        return k518;
    }
    
    return @"";
}

+ (NSString *)getAppURL {
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];

    
    if ([appName isEqualToString:@"【盛世】"]) {
        return kShenshi_URL;
    }else if ([appName isEqualToString:@"金盛"]) {
        return kJINSHENG_URL;
    }else if ([appName isEqualToString:@"盈融"]) {
        return kYINGRONG_URL;
    }else if ([appName isEqualToString:@"赢城"]) {
        return kYINGCHENG_URL;
    }else if ([appName isEqualToString:@"诚信"]) {
        return kCHENGXIN_URL;
    }else if ([appName isEqualToString:@"九州"]) {
        return kJIUZHOU_URL;
    }else if ([appName isEqualToString:@"利赢"]) {
        return kLIYING_URL;
    }else if ([appName isEqualToString:@"918"]) {
        return k918_URL;
    }else if ([appName isEqualToString:@"518"]) {
        return k518_URL;
    }
    
    
    return @"";

}

@end
