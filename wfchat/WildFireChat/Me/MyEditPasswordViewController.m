//
//  MyEditPasswordViewController.m
//  WildFireChat
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 WildFireChat. All rights reserved.
//

#import "MyEditPasswordViewController.h"
#import "AppService.h"
#import "BWPasswordValidator.h"
#import "BWTextField.h"

@interface MyEditPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BWTextField *currentPasswordTF;
@property (weak, nonatomic) IBOutlet BWTextField *myPasswordTF;

@property (weak, nonatomic) IBOutlet BWTextField *confirPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;

@end

@implementation MyEditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
        
    self.currentPasswordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.currentPasswordTF.layer.borderWidth = 1;
    self.currentPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    self.currentPasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.currentPasswordTF.validator = [BWPasswordValidator new];
    
    self.myPasswordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.myPasswordTF.layer.borderWidth = 1;
    self.myPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    self.myPasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.myPasswordTF.validator = [BWPasswordValidator new];

    
    self.confirPasswordTF.layer.borderColor = GrayBlogColor.CGColor;
    self.confirPasswordTF.layer.borderWidth = 1;
    self.confirPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    self.confirPasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    self.confirPasswordTF.validator = [BWPasswordValidator new];

    
    
}


- (IBAction)modifyClick:(UIButton *)sender {
    
    if (![self.currentPasswordTF validate] || ![self.myPasswordTF validate] || ![self.confirPasswordTF validate]) {
        [MBProgressHUD showMessage:@"请输入6-15位英文、数字、可使用特殊符号"];
        return;
    }

    
    if (![self.myPasswordTF.text isEqualToString:self.confirPasswordTF.text]) {
        [MBProgressHUD showMessage:@"两次输入的密码不一致"];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"修改中...";
    [hud showAnimated:YES];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedName"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@""];
    [dic setValue:self.myPasswordTF.text forKey:@""];
    
    [[AppService sharedAppService] modifyPassword:dic success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [MBProgressHUD showMessage:@"修改成功"];
        });
    } error:^(NSString * _Nonnull message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [MBProgressHUD showMessage:@"网络错误"];
        });
    }];
    
}


- (IBAction)eyeClick1:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.currentPasswordTF.secureTextEntry = !sender.selected;
}

- (IBAction)eyeClick2:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.myPasswordTF.secureTextEntry = !sender.selected;
}
- (IBAction)eyeClick3:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.confirPasswordTF.secureTextEntry = !sender.selected;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BWTextField *customField = (BWTextField *)textField;
    return [customField validateCharacter:string range:range];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
