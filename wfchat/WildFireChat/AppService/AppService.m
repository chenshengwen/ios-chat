//
//  AppService.m
//  WildFireChat
//
//  Created by Heavyrain Lee on 2019/10/22.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import "AppService.h"
#import <WFChatClient/WFCChatClient.h>
#import "AFNetworking.h"
#import "WFCConfig.h"

static AppService *sharedSingleton = nil;

@implementation AppService 
+ (AppService *)sharedAppService {
    if (sharedSingleton == nil) {
        @synchronized (self) {
            if (sharedSingleton == nil) {
                sharedSingleton = [[AppService alloc] init];
            }
        }
    }

    return sharedSingleton;
}

- (void)login:(NSString *)user password:(NSString *)password company:(NSString *)company success:(void(^)(NSString *userId, NSString *token, BOOL newUser))successBlock error:(void(^)(int errCode, NSString *message))errorBlock {
    
    [self post:@"/login" data:@{@"mobile":user, @"password":password, @"clientId":[[WFCCNetworkService sharedInstance] getClientId], @"platform":@(Platform_iOS),@"company":company} success:^(NSDictionary *dict) {
        if([dict[@"status"] intValue] == 200 && dict != nil) {
            NSString *userId = dict[@"data"][@"userId"];
            NSString *token = dict[@"data"][@"token"];
            BOOL newUser = [dict[@"data"][@"register"] boolValue];
            successBlock(userId, token, newUser);
        } else {
            errorBlock([dict[@"code"] intValue], dict[@"message"]);
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(-1, @"网络错误");
    }];
}

- (void)regist:(NSString *)user password:(NSString *)password company:(NSString *)company success:(void(^)(NSString *userId, NSString *name))successBlock error:(void(^)(int errCode, NSString *message))errorBlock {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    /*   获取   */
    dispatch_async(queue, ^{
        __block BOOL isExist = NO;
        __block NSString *message = @"";
        NSString *url = [NSString stringWithFormat:@"/user/%@",user];
        [self post:url data:nil success:^(NSDictionary *dict) {
            if([dict[@"data"] boolValue] == NO && dict != nil && [dict[@"status"] intValue] == 200) {
                isExist = NO;
            } else {
                isExist = YES;
                message = @"用户已存在";
            }
            
            dispatch_semaphore_signal(semaphore);

        } error:^(NSError * _Nonnull error) {
            isExist = NO;
            message = @"网络错误";
            dispatch_semaphore_signal(semaphore);

        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        if (isExist) {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorBlock(-1, message);
            });
            return ;
        }
        [self post:@"/register" data:@{@"mobile":user, @"password":password, @"company":company} success:^(NSDictionary *dict) {
               if([dict[@"status"] intValue] == 200 && dict != nil) {
                   NSString *userId = dict[@"data"][@"userId"];
                   NSString *name = dict[@"data"][@"name"];
                   successBlock(userId, name);
               } else {
                   errorBlock([dict[@"code"] intValue], dict[@"message"]);
               }
           } error:^(NSError * _Nonnull error) {
               errorBlock(-1, @"网络错误");
           }];
        
    });
    
   
}

- (void)modifyPassword:(NSDictionary *)dic success:(void(^)(void))successBlock error:(void(^)(NSString *message))errorBlock {
    
    [self post:@"/restPassword" data:dic success:^(NSDictionary *dict) {
           if([dict[@"status"] intValue] == 200 && dict != nil) {
               successBlock();
           } else {
               errorBlock(@"error");
           }
       } error:^(NSError * _Nonnull error) {
           errorBlock(error.localizedDescription);
       }];
}

- (void)updateRequest:(NSDictionary *)dic success:(void(^)(int type, NSString *upgradePrompt, NSString *downloadUrl, int versionId))successBlock error:(void(^)(NSString *message))errorBlock {
    
    [self post:@"/app/version" data:dic success:^(NSDictionary *dict) {
           if([dict[@"status"] intValue] == 200 && dict != nil) {
               
               int myType = [dict[@"data"][@"type"] intValue];
               NSString *myUpgradePrompt = dict[@"data"][@"upgradePrompt"];
               NSString *url = dict[@"data"][@"apkUrl"];
               int version = [dict[@"data"][@"versionId"] intValue];
               
               successBlock(myType, myUpgradePrompt,url, version);
           } else {
               errorBlock(@"error");
           }
       } error:^(NSError * _Nonnull error) {
           errorBlock(@"网络错误");
       }];
}

#pragma mark - 获取群限制成员数量
- (void)getSystemSettingSuccess:(void(^)(int type))successBlock error:(void(^)(NSString *message))errorBlock {
        
    [self post:@"/admin/system/setting/1" data:nil success:^(NSDictionary *dict) {
              if([dict[@"status"] intValue] == 200 && dict != nil) {
                  
                  int myType = [dict[@"data"][@"value"] intValue];

                  successBlock(myType);
              } else {
                  errorBlock(dict[@"message"]);
              }
          } error:^(NSError * _Nonnull error) {
              errorBlock(@"网络错误");
          }];
}

#pragma mark - 获取转发数量限制
- (void)getForwardSettingSuccess:(void(^)(int type))successBlock error:(void(^)(NSString *message))errorBlock {
        
    [self post:@"/admin/system/setting/2" data:nil success:^(NSDictionary *dict) {
              if([dict[@"status"] intValue] == 200 && dict != nil) {
                  
                  int myType = [dict[@"data"][@"value"] intValue];

                  successBlock(myType);
              } else {
                  errorBlock(dict[@"message"]);
              }
          } error:^(NSError * _Nonnull error) {
              errorBlock(@"网络错误");
          }];
}

#pragma mark - 获取appId和pappURL
- (void)getAppIDWithChannelId:(NSString *)channeldId Success:(void(^)(NSString *appId,NSString *appUrl))successBlock error:(void(^)(NSString *message, int errorCode))errorBlock {
    
    NSString *url = [NSString stringWithFormat:@"/app/setting/%@",channeldId];
    
    [self post:url data:nil success:^(NSDictionary *dict) {
        if([dict[@"status"] intValue] == 200 && dict != nil) {
            
            NSString *myUrl = dict[@"data"][@"value"];
            NSString *myId = dict[@"data"][@"desc"];

            successBlock(myId,myUrl);
        } else {
            errorBlock(dict[@"message"],[dict[@"status"] intValue]);
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(@"网络错误",-1);
    }];
    
}

- (void)sendCode:(NSString *)phoneNumber success:(void(^)(void))successBlock error:(void(^)(NSString *message))errorBlock {
    
    [self post:@"/send_code" data:@{@"mobile":phoneNumber} success:^(NSDictionary *dict) {
        if([dict[@"code"] intValue] == 0) {
            successBlock();
        } else {
            errorBlock(@"error");
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(error.localizedDescription);
    }];
}


- (void)pcScaned:(NSString *)sessionId success:(void(^)(void))successBlock error:(void(^)(int errorCode, NSString *message))errorBlock {
    NSString *path = [NSString stringWithFormat:@"/scan_pc/%@", sessionId];
    [self post:path data:nil success:^(NSDictionary *dict) {
        if([dict[@"code"] intValue] == 0) {
            successBlock();
        } else {
            errorBlock([dict[@"code"] intValue], @"Network error");
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(-1, error.localizedDescription);
    }];
}

- (void)pcConfirmLogin:(NSString *)sessionId success:(void(^)(void))successBlock error:(void(^)(int errorCode, NSString *message))errorBlock {
    NSString *path = @"/confirm_pc";
    NSDictionary *param = @{@"im_token":@"", @"token":sessionId, @"user_id":[WFCCNetworkService sharedInstance].userId};
    [self post:path data:param success:^(NSDictionary *dict) {
        if([dict[@"code"] intValue] == 0) {
            successBlock();
        } else {
            errorBlock([dict[@"code"] intValue], @"Network error");
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(-1, error.localizedDescription);
    }];
}

- (void)getGroupAnnouncement:(NSString *)groupId
                     success:(void(^)(WFCUGroupAnnouncement *))successBlock
                      error:(void(^)(int error_code))errorBlock {
    if (successBlock) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"wfc_group_an_%@", groupId]];
    
        WFCUGroupAnnouncement *an = [[WFCUGroupAnnouncement alloc] init];
        an.data = data;
        an.groupId = groupId;
        
        successBlock(an);
    }
    
    NSString *path = @"/get_group_announcement";
    NSDictionary *param = @{@"groupId":groupId};
    [self post:path data:param success:^(NSDictionary *dict) {
        if([dict[@"code"] intValue] == 0 || [dict[@"code"] intValue] == 12) {
            WFCUGroupAnnouncement *an = [[WFCUGroupAnnouncement alloc] init];
            an.groupId = groupId;
            if ([dict[@"code"] intValue] == 0) {
                an.author = dict[@"result"][@"author"];
                an.text = dict[@"result"][@"text"];
                an.timestamp = [dict[@"result"][@"timestamp"] longValue];
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:an.data forKey:[NSString stringWithFormat:@"wfc_group_an_%@", groupId]];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            successBlock(an);
        } else {
            errorBlock([dict[@"code"] intValue]);
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(-1);
    }];
}

- (void)updateGroup:(NSString *)groupId
       announcement:(NSString *)announcement
            success:(void(^)(long timestamp))successBlock
              error:(void(^)(int error_code))errorBlock {
    
    NSString *path = @"/put_group_announcement";
    NSDictionary *param = @{@"groupId":groupId, @"author":[WFCCNetworkService sharedInstance].userId, @"text":announcement};
    [self post:path data:param success:^(NSDictionary *dict) {
        if([dict[@"code"] intValue] == 0) {
            WFCUGroupAnnouncement *an = [[WFCUGroupAnnouncement alloc] init];
            an.groupId = groupId;
            an.author = [WFCCNetworkService sharedInstance].userId;
            an.text = announcement;
            an.timestamp = [dict[@"result"][@"timestamp"] longValue];
            
            
            [[NSUserDefaults standardUserDefaults] setValue:an.data forKey:[NSString stringWithFormat:@"wfc_group_an_%@", groupId]];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            successBlock(an.timestamp);
        } else {
            errorBlock([dict[@"code"] intValue]);
        }
    } error:^(NSError * _Nonnull error) {
        errorBlock(-1);
    }];
    
    
}

- (void)post:(NSString *)path data:(id)data success:(void(^)(NSDictionary *dict))successBlock error:(void(^)(NSError * _Nonnull error))errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedToken"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:[APP_SERVER_ADDRESS stringByAppendingPathComponent:path]
       parameters:data
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSDictionary *dict = responseObject;
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  successBlock(dict);
              });
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorBlock(error);
            });
          }];
}
@end
