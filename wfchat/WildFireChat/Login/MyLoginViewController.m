//
//  MyLoginViewController.m
//  WildFireChat
//
//  Created by 陈圣文 on 2019/12/8.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import "MyLoginViewController.h"
#import <WFChatClient/WFCChatClient.h>
#import <WFChatUIKit/WFChatUIKit.h>
#import "AppDelegate.h"
#import "WFCBaseTabBarController.h"
#import "MBProgressHUD.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "WFCPrivacyViewController.h"
#import "AppService.h"
//#import "BWPasswordValidator.h"
#import "BWPhoneNumberValidator.h"

typedef NS_ENUM(NSInteger,LoginType) {
    myLoginType,
    myRegistType
};

@interface MyLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *regihterBtn;

@property (nonatomic, assign) LoginType type;
@end

@implementation MyLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
    self.phoneTF.layer.borderWidth = 1;
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.phoneTF.validator = [BWPhoneNumberValidator new];
    [self.phoneTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.passwordTF.layer.borderWidth = 1;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
//    self.passwordTF.validator = [BWPasswordValidator new];
    [self.passwordTF addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];

    self.loginBtn.backgroundColor = GrayBlogColor;
    self.loginBtn.enabled = NO;
}
- (IBAction)loginClick:(UIButton *)sender {
    
    
    NSString *user = self.phoneTF.text;
    NSString *password = self.passwordTF.text;

    if (!user.length || !password.length) {
      return;
    }

    [self resetKeyboard:nil];
    
    if (self.type == myLoginType) {
        [self logintAction];
    }else {
        [self registerAction];
    }
     
}

- (void)logintAction {
    
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       hud.label.text = @"登陆中...";
       [hud showAnimated:YES];
       
         [[AppService sharedAppService] login:self.phoneTF.text password:self.passwordTF.text success:^(NSString *userId, NSString *token, BOOL newUser) {
             [[NSUserDefaults standardUserDefaults] setObject:self.phoneTF.text forKey:@"savedName"];
             [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"savedToken"];
             [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"savedUserId"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             
         //需要注意token跟clientId是强依赖的，一定要调用getClientId获取到clientId，然后用这个clientId获取token，这样connect才能成功，如果随便使用一个clientId获取到的token将无法链接成功。
             [[WFCCNetworkService sharedInstance] connect:userId token:token];
             
             dispatch_async(dispatch_get_main_queue(), ^{
               [hud hideAnimated:YES];
                 WFCBaseTabBarController *tabBarVC = [WFCBaseTabBarController new];
                 tabBarVC.newUser = newUser;
                 [UIApplication sharedApplication].delegate.window.rootViewController =  tabBarVC;
             });
         } error:^(int errCode, NSString *message) {
             NSLog(@"login error with code %d, message %@", errCode, message);
           dispatch_async(dispatch_get_main_queue(), ^{
             [hud hideAnimated:YES];
             
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             hud.mode = MBProgressHUDModeText;
             hud.label.text = @"登陆失败";
             hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
             [hud hideAnimated:YES afterDelay:1.f];
           });
         }];
}

- (void)registerAction {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"注册中...";
    [hud showAnimated:YES];
    
    [[AppService sharedAppService] regist:self.phoneTF.text password:self.passwordTF.text success:^(NSString * _Nonnull userId, NSString * _Nonnull name) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [hud hideAnimated:YES];
            [MBProgressHUD showMessage:@"注册成功，请点击登录"];
            NSLog(@"userId:%@,name:%@",userId,name);
            [self registClick:self.regihterBtn];
        });
    } error:^(int errCode, NSString * _Nonnull message) {
        NSLog(@"login error with code %d, message %@", errCode, message);
        dispatch_async(dispatch_get_main_queue(), ^{
          [hud hideAnimated:YES];
          
          MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          hud.mode = MBProgressHUDModeText;
          hud.label.text = @"注册失败";
          hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
          [hud hideAnimated:YES afterDelay:1.f];
        });
    }];
}

- (IBAction)registClick:(UIButton *)sender {
    if (self.type == myLoginType) {
        self.type = myRegistType;
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [sender setTitle:@"登录" forState:UIControlStateNormal];
    }else {
        self.type = myLoginType;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [sender setTitle:@"新用户" forState:UIControlStateNormal];
    }
    
}


- (void)resetKeyboard:(id)sender {
    [self.phoneTF resignFirstResponder];
    
    [self.passwordTF resignFirstResponder];
    
    self.loginBtn.backgroundColor = HexCOLOR(0x318311);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.phoneTF ) {
        self.phoneTF.layer.borderColor = selectColor.CGColor;
        self.phoneTF.layer.borderWidth = 1;
        self.passwordTF.layer.borderColor = GrayBlogColor.CGColor;
        self.passwordTF.layer.borderWidth = 1;
        
    }else {
        self.phoneTF.layer.borderColor = GrayBlogColor.CGColor;
        self.phoneTF.layer.borderWidth = 1;
        self.passwordTF.layer.borderColor = selectColor.CGColor;
        self.passwordTF.layer.borderWidth = 1;

    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
        BWTextField *customField = (BWTextField *)textField;
        return [customField validateCharacter:string range:range];

    }
    
    return YES;
}

- (void)textDidChange:(id<UITextInput>)textInput {
    if (textInput == self.phoneTF) {
        if ([self.phoneTF validate]) {
            if (self.passwordTF.text.length > 5) {
                self.loginBtn.backgroundColor = HexCOLOR(0x318311);
                self.loginBtn.enabled = YES;
            }else {
                self.loginBtn.backgroundColor = GrayBlogColor;
                self.loginBtn.enabled = NO;
            }
        }else {
            self.loginBtn.backgroundColor = GrayBlogColor;
            self.loginBtn.enabled = NO;
        }
    }else {
        if (self.passwordTF.text.length > 5) {
            if ([self.phoneTF validate]) {
                self.loginBtn.backgroundColor = HexCOLOR(0x318311);
                self.loginBtn.enabled = YES;
            }else {
                self.loginBtn.backgroundColor = GrayBlogColor;
                self.loginBtn.enabled = NO;
            }
        }else {
            self.loginBtn.backgroundColor = GrayBlogColor;
            self.loginBtn.enabled = NO;
        }
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
