//
//  TestTextFieldViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/22.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestTextFieldViewController.h"
#import "UITextField+Extension.h"

@interface TestTextFieldViewController ()

@end

@implementation TestTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //全局收起键盘
    [self.navigationController.view gestureHidingkeyboard];
    
    UIView *superView = [UIView createViewWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-200) color:[UIColor redColor]];
    [self.view addSubview:superView];
    
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(20, screenHeight-60-navViewHeight, screenWidth-40, 50)];
    textField1.placeholder = @"这个是加载在控制器view上的";
    textField1.placeholderColor = [UIColor orangeColor];
    textField1.backgroundColor = [UIColor greenColor];
    [textField1 automaticFollowKeyboard:self.view];
    [textField1 textDidChange:^(NSString *textStr) {

        NSLog(@"输入的文本是：%@",textStr);
    }];
    [textField1 fixMessyDisplay];
    [self.view addSubview:textField1];
    
    UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(20, superView.bottom-60, screenWidth-40, 50)];
    textField2.placeholder = @"这个是加载在子view上的,5个字符";
    textField2.backgroundColor = [UIColor greenColor];
    [textField2 automaticFollowKeyboard:self.view];
    textField2.maximumLimit = 5;
    [textField2 textDidChange:^(NSString *textStr) {

        NSLog(@"输入的文本是：%@",textStr);
    }];
    [superView addSubview:textField2];
}

- (void)dealloc {
    
    NSLog(@"dealloc");
    [self.view releaseKeyboardNotification];
}

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
