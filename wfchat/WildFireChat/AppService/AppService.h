//
//  AppService.h
//  WildFireChat
//
//  Created by Heavyrain Lee on 2019/10/22.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFChatUIKit/WFChatUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppService : NSObject <WFCUAppServiceProvider>
+ (AppService *)sharedAppService;
- (void)login:(NSString *)user password:(NSString *)password company:(NSString *)company success:(void(^)(NSString *userId, NSString *token, BOOL newUser))successBlock error:(void(^)(int errCode, NSString *message))errorBlock;

- (void)regist:(NSString *)user password:(NSString *)password company:(NSString *)company success:(void(^)(NSString *userId, NSString *name))successBlock error:(void(^)(int errCode, NSString *message))errorBlock;

- (void)modifyPassword:(NSDictionary *)dic success:(void(^)(void))successBlock error:(void(^)(NSString *message))errorBlock;

- (void)updateRequest:(NSDictionary *)dic success:(void(^)(int type, NSString *upgradePrompt, NSString *downloadUrl, int versionId))successBlock error:(void(^)(NSString *message))errorBlock;

#pragma mark - 获取appId和pappURL
- (void)getAppIDWithChannelId:(NSString *)channeldId Success:(void(^)(NSString *appId,NSString *appUrl))successBlock error:(void(^)(NSString *message, int errorCode))errorBlock;

- (void)sendCode:(NSString *)phoneNumber success:(void(^)(void))successBlock error:(void(^)(NSString *message))errorBlock;

- (void)pcScaned:(NSString *)sessionId success:(void(^)(void))successBlock error:(void(^)(int errorCode, NSString *message))errorBlock;

- (void)pcConfirmLogin:(NSString *)sessionId success:(void(^)(void))successBlock error:(void(^)(int errorCode, NSString *message))errorBlock;
@end

NS_ASSUME_NONNULL_END
