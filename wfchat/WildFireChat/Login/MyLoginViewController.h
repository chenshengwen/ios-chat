//
//  MyLoginViewController.h
//  WildFireChat
//
//  Created by 陈圣文 on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet BWTextField *phoneTF;
@property (weak, nonatomic) IBOutlet BWTextField *passwordTF;

@end

NS_ASSUME_NONNULL_END
