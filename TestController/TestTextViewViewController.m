//
//  TestTextViewViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/21.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestTextViewViewController.h"
#import "UITextView+Extension.h"

@interface TestTextViewViewController ()

@end

@implementation TestTextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //全局收起键盘
    [self.navigationController.view gestureHidingkeyboard];
    
    UIView *superView = [UIView createViewWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-200) color:[UIColor redColor]];
    [self.view addSubview:superView];
    
    UITextView *textView1 = [[UITextView alloc]initWithFrame:CGRectMake(20, screenHeight-300, screenWidth-40, 200)];
    textView1.backgroundColor = [UIColor orangeColor];
    textView1.placeholderStr = @"这个是添加在控制器view上的";
    textView1.placeholderColor = [UIColor whiteColor];
    textView1.font = [UIFont systemFontOfSize:30];
    textView1.placeholderFont = [UIFont systemFontOfSize:15];
    [textView1 automaticFollowKeyboard:self.view];
    [textView1 textDidChange:^(NSString *textStr) {

        NSLog(@"输入的文本是：%@",textStr);
    }];
    [self.view addSubview:textView1];

    UITextView *textView2 = [[UITextView alloc]initWithFrame:CGRectMake(20, superView.bottom-320, screenWidth-40, 200)];
    textView2.backgroundColor = [UIColor orangeColor];
    textView2.placeholderStr = @"这个是添加在子view上的,设置了最大输入10个字符";
    textView2.placeholderColor = [UIColor whiteColor];
    [textView2 automaticFollowKeyboard:self.view];
    textView2.maximumLimit = 20;
    textView2.characterLengthPrompt = YES;
    textView2.font = [UIFont systemFontOfSize:30];
    textView2.placeholderFont = [UIFont systemFontOfSize:15];
    [superView addSubview:textView2];
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
