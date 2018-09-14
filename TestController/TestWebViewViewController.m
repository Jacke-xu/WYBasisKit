//
//  TestWebViewViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestWebViewViewController.h"
#import "WKWebView+Extension.h"

@interface TestWebViewViewController ()

@end

@implementation TestWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-navViewHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com/cn/"]]];
    //看这里，看这里，一行代码就实现了进度监听个进度条颜色自定义
    [webView showProgressWithColor:[UIColor orangeColor]];
    [self.view addSubview:webView];
}

- (void)dealloc {
    
    NSLog(@"dealloc");
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
