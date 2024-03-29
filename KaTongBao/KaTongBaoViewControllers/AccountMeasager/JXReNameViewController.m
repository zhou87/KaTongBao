//
//  JXReNameViewController.m
//  JingXuan
//
//  Created by rongfeng on 16/6/6.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "JXReNameViewController.h"
#import "Common.h"
#import "macro.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>

@interface JXReNameViewController ()

@end

@implementation JXReNameViewController {
    NSTimer *timer;
    UIButton *btn;
    NSInteger index;
    UIButton *nextBtn;
    UITextField *phoneFld;
    UITextField *codeFld;
    UITextField *pwdfld;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"修改登录密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登陆密码";
    self.view.backgroundColor = [UIColor whiteColor];
    // create UI
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = LightGrayColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UITapGestureRecognizer *TapHiddenKayBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoard)];
    TapHiddenKayBoard.numberOfTouchesRequired = 1;
    [backImg addGestureRecognizer:TapHiddenKayBoard];
    
    
    UIImageView *Img = [[UIImageView alloc] init];
    Img.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Img];
    //身份证
    UILabel *phoneLab = [[UILabel alloc] init];
    phoneLab.text = @"原登录密码：";
    phoneLab.font = [UIFont systemFontOfSize:14];
    //phoneLab.textColor = Gray100;
    [self.view addSubview:phoneLab];
    
    phoneFld = [[UITextField alloc] init];
    phoneFld.placeholder = @"请输入原始登录密码";
    phoneFld.font = [UIFont systemFontOfSize:14];
    phoneFld.delegate = self;
    phoneFld.secureTextEntry = YES;
    [self.view addSubview:phoneFld];
    
    Img.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,78.5 - 64).heightIs(134.5);
    phoneLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,89.5 - 64).widthIs(100).heightIs(20);
    phoneFld.sd_layout.leftSpaceToView(self.view,119).topSpaceToView(self.view,90 - 64).widthIs(226).heightIs(20);
    //中间的横线
    UIImageView *lineImg = [[UIImageView alloc] init];
    lineImg.backgroundColor = Gray229;
    [self.view addSubview:lineImg];
    lineImg.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,122.5 - 64).heightIs(0.5);
    UIImageView *lineImgS = [[UIImageView alloc] init];
    lineImgS.backgroundColor = Gray229;
    [self.view addSubview:lineImgS];
    lineImgS.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,0).topSpaceToView(self.view,167.5 - 64).heightIs(0.5);
    UIImageView *LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = Gray229;
    [self.view addSubview:LineOne];
    LineOne.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,78.5 - 64).heightIs(0.5);
    UIImageView *LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor = Gray229;
    [self.view addSubview:LineTwo];
    LineTwo.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,212.5).heightIs(0.5);
    //密码
    UILabel *codeLab = [[UILabel alloc] init];
    codeLab.text = @"新登录密码：";
    codeLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:codeLab];
    
    codeFld = [[UITextField alloc] init];
    codeFld.placeholder = @"请输入新登录密码";
    codeFld.font = [UIFont systemFontOfSize:14];
    codeFld.secureTextEntry = YES;
    codeFld.delegate = self;
    [self.view addSubview:codeFld];
    
    codeLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,137 - 64).widthIs(100).heightIs(20);
    codeFld.sd_layout.leftSpaceToView(self.view,119).topSpaceToView(self.view,137.5 - 64).widthIs(140).heightIs(20);
    //确认密码
    UILabel *pwdLab = [[UILabel alloc] init];
    pwdLab.text = @"新登录密码：";
    pwdLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:pwdLab];
    pwdfld = [[UITextField alloc] init];
    pwdfld.placeholder = @"请再次输入新登录密码";
    pwdfld.font = [UIFont systemFontOfSize:14];
    pwdfld.secureTextEntry = YES;
    pwdfld.delegate = self;
    [self.view addSubview:pwdfld];
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"密码由6-20位英文字母,数字,或符号组成";
    TipsLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:TipsLab];
    pwdLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,183 - 64).widthIs(100).heightIs(20);
    pwdfld.sd_layout.leftSpaceToView(self.view,119).topSpaceToView(self.view,183.5 - 64).widthIs(226).heightIs(20);
    TipsLab.sd_layout.leftSpaceToView(self.view,16).topSpaceToView(self.view,222 - 64).widthIs(228).heightIs(12.5);
    //下一步
    nextBtn = [[UIButton alloc] init];
    nextBtn.backgroundColor = NavBack;
    [nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nextBtn.layer.cornerRadius = 3.5;
    nextBtn.layer.masksToBounds = YES;
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(self.view,276 - 64).heightIs(45);


}
//下一步
- (void)nextStep {
    if (self.cert) {
        if ([codeFld.text isEqualToString:@""] || [pwdfld.text isEqualToString:@""]) {
            [self alert:@"请填写完整信息"];
            return;
        }
    }else {
        
        if ([phoneFld.text isEqualToString:@""] || [codeFld.text isEqualToString:@""] || [pwdfld.text isEqualToString:@""]) {
            [self alert:@"请填写完整信息!"];
            return;
        }
    }
    //
    NSString *url = JXUrl;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"token"];
    NSString *key = [user objectForKey:@"key"];
    
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",codeFld.text,pwdfld.text,phoneFld.text,key];
    NSLog(@"签名：%@",md5);
    NSString *sign = [self md5HexDigest:md5];
    NSDictionary *dic1 = @{
                           @"oldPass":phoneFld.text,
                           @"newPass":codeFld.text,
                           @"conPass":pwdfld.text,
                           @"token":token,
                           @"sign":sign
                           };
    NSDictionary *dicc = @{
                           @"action":@"shopModifyPassState",
                           @"data":dic1
                           };
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:url params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *content = dic[@"msg"];
        if ([content isEqualToString:@"Success"]) {
            content = @"密码修改成功！";
        }
        [self alert:content];
        if ([code isEqualToString:@"000000"]) {
            //注册成功 2 登陆页面
            //LoginViewController *Login = [[LoginViewController alloc] init];
            [self performSelector:@selector(backToRootView) withObject:nil afterDelay:2];
        } else {
            
        }
        NSLog(@"返回的数据:%@",dic);
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        nextBtn.enabled = YES;
    }];
}
- (void)backToRootView {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
//MD5加密
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}
#define mark -

- (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)HiddenKeyBoard {
    
    [phoneFld resignFirstResponder];
    [codeFld  resignFirstResponder];
    [pwdfld resignFirstResponder];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
