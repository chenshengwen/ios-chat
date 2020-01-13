//
//  WFCCCreateGroupNotificationContent.m
//  WFChatClient
//
//  Created by heavyrain on 2017/9/19.
//  Copyright © 2017年 WildFireChat. All rights reserved.
//

#import "WFCCGroupPrivateChatNotificationContent.h"
#import "WFCCIMService.h"
#import "WFCCNetworkService.h"
#import "Common.h"

#define kAccountUserDefault(key) [NSString stringWithFormat:@"%@_%@_%@",key,[WFCCNetworkService sharedInstance].userId,self.groupId]

#define kUserDefault [NSUserDefaults standardUserDefaults]

static NSString *const kcreatorY = @"kcreatorY";
static NSString *const kcreatorN = @"kcreatorN";

static NSString *const kfriendAliasY = @"kfriendAliasY";
static NSString *const kfriendAliasN = @"kfriendAliasN";

static NSString *const kgroupAliasY = @"kgroupAliasY";
static NSString *const kgroupAliasN = @"kgroupAliasN";

static NSString *const kdisplayNameY = @"kdisplayNameY";
static NSString *const kdisplayNameN = @"kdisplayNameN";

static NSString *const kotherY = @"kotherY";
static NSString *const kotherN = @"kotherN";


@implementation WFCCGroupPrivateChatNotificationContent
- (WFCCMessagePayload *)encode {
    WFCCMessagePayload *payload = [super encode];
    payload.contentType = [self.class getContentType];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    if (self.creator) {
        [dataDict setObject:self.creator forKey:@"o"];
    }
    if (self.type) {
        [dataDict setObject:self.type forKey:@"n"];
    }
    
    if (self.groupId) {
        [dataDict setObject:self.groupId forKey:@"g"];
    }
    
    payload.binaryContent = [NSJSONSerialization dataWithJSONObject:dataDict
                                                                           options:kNilOptions
                                                                             error:nil];
    
    return payload;
}

- (void)decode:(WFCCMessagePayload *)payload {
    [super decode:payload];
    NSError *__error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:payload.binaryContent
                                                               options:kNilOptions
                                                                 error:&__error];
    if (!__error) {
        self.creator = dictionary[@"o"];
        self.type = dictionary[@"n"];
        self.groupId = dictionary[@"g"];
    }
}

+ (int)getContentType {
    return MESSAGE_CONTENT_TYPE_CHANGE_PRIVATECHAT;
}

+ (int)getContentFlags {
    return WFCCPersistFlag_PERSIST;
}



+ (void)load {
    [[WFCCIMService sharedWFCIMService] registerMessageContent:self];
}

- (NSString *)digest:(WFCCMessage *)message {
    return [self formatNotification:message];
}

- (NSString *)formatNotification:(WFCCMessage *)message {
    if ([[WFCCNetworkService sharedInstance].userId isEqualToString:self.creator]) {
        
        if ([self.type isEqualToString:@"0"]) {
            if (![kUserDefault boolForKey:kAccountUserDefault(kcreatorY)]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kcreatorY)];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kcreatorN)];
                return @"你开启了成员私聊";
            }
        }else {
            if (![kUserDefault boolForKey:kAccountUserDefault(kcreatorN)]) {
                 [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kcreatorY)];
                 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kcreatorN)];
                return @"你关闭了成员私聊";
            }
        }
        return [self.type isEqualToString:@"0"] ? @"你开启了成员私聊" : @"你关闭了成员私聊";
    } else {
        WFCCUserInfo *userInfo = [[WFCCIMService sharedWFCIMService] getUserInfo:self.creator inGroup:self.groupId refresh:NO];
        if (userInfo.friendAlias.length > 0) {
            if ([self.type isEqualToString:@"0"]) {
               if (![kUserDefault boolForKey:kAccountUserDefault(kfriendAliasY)]) {
                   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kfriendAliasY)];
                   [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kfriendAliasN)];
                   return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.friendAlias];
               }
           }else {
               if (![kUserDefault boolForKey:kAccountUserDefault(kfriendAliasN)]) {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kfriendAliasY)];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kfriendAliasN)];
                   return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.friendAlias];
               }
           }
            return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.friendAlias];
        } else if(userInfo.groupAlias.length > 0) {
             if ([self.type isEqualToString:@"0"]) {
                if (![kUserDefault boolForKey:kAccountUserDefault(kgroupAliasY)]) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kgroupAliasY)];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kgroupAliasN)];
                    return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.groupAlias];
                }
            }else {
                if (![kUserDefault boolForKey:kAccountUserDefault(kgroupAliasN)]) {
                     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kgroupAliasY)];
                     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kgroupAliasN)];
                    return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.groupAlias];
                }
            }
            return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.groupAlias];
        } else if (userInfo.displayName.length > 0) {
            if ([self.type isEqualToString:@"0"]) {
                if (![kUserDefault boolForKey:kAccountUserDefault(kdisplayNameY)]) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kdisplayNameY)];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kdisplayNameN)];
                    return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.displayName];
                }
            }else {
                if (![kUserDefault boolForKey:kAccountUserDefault(kdisplayNameN)]) {
                     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kdisplayNameY)];
                     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kdisplayNameN)];
                    return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.displayName];
                }
            }
            return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"%@开启了成员私聊" : @"%@关闭了成员私聊", userInfo.displayName];
        } else {
            if ([self.type isEqualToString:@"0"]) {
               if (![kUserDefault boolForKey:kAccountUserDefault(kotherY)]) {
                   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kotherY)];
                   [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kotherN)];
                   return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"用户<%@>开启了成员私聊" : @"用户<%@>关闭了成员私聊", self.creator];
               }
           }else {
               if (![kUserDefault boolForKey:kAccountUserDefault(kotherN)]) {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAccountUserDefault(kotherY)];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAccountUserDefault(kotherN)];
                   return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"用户<%@>开启了成员私聊" : @"用户<%@>关闭了成员私聊", self.creator];
               }
           }
            return [NSString stringWithFormat:[self.type isEqualToString:@"0"] ? @"用户<%@>开启了成员私聊" : @"用户<%@>关闭了成员私聊", self.creator];
        }
    }
}
@end
