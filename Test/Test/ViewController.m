//
//  ViewController.m
//  Test
//
//  Created by xinxin on 2020/4/12.
//  Copyright © 2020 PM. All rights reserved.
//

#import "ViewController.h"
#import "HttpServerce.h"
#import "MessageController.h"
#import "ZYProgressHUD.h"
#define SendUrl @"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message"
#define UserId @"20200412123600"
#define kWidth [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发送消息";
    [self bulidUI];
    // Do any additional setup after loading the view.
}
-(void)bulidUI{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, kWidth-40, 50)];
    self.textField.backgroundColor = [UIColor grayColor];
    self.textField.textColor = [UIColor blackColor];
    self.textField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.textField];
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(kWidth/2-40, 170, 80, 35);
    sendBtn.backgroundColor = [UIColor orangeColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.textColor = [UIColor whiteColor];
    [sendBtn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
}
-(void)getData{
    [ZYProgressHUD showLoading:@"发送中..."];
    NSDictionary *param = @{@"id":UserId,@"content":self.textField.text};
    [[HttpServerce instance]sendHttpPostMethod:SendUrl andParameters:param completion:^(id objects, BOOL isSuccess) {
        [ZYProgressHUD showSuccess:@"发送成功"];
    }];
}
-(void)nextVC{
    [self.navigationController pushViewController:[MessageController new] animated:YES];
}
@end
