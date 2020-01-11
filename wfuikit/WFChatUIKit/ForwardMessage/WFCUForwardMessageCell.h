//
//  ForwardMessageCell.h
//  WildFireChat
//
//  Created by heavyrain lee on 2018/9/27.
//  Copyright © 2018 WildFireChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WFChatClient/WFCChatClient.h>
NS_ASSUME_NONNULL_BEGIN

@interface WFCUForwardMessageCell : UITableViewCell
@property (strong, nonatomic) WFCCConversation *conversation;
@property(nonatomic, assign)BOOL checked;
@end

NS_ASSUME_NONNULL_END
