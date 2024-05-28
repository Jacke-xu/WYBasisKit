//
//  TestWebViewViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestWebViewViewController.h"
#import "WKWebView+WY_Extension.h"
#import "UIButton+WY_EdgeInsets.h"

@interface TestWebViewViewController ()

@end

@implementation TestWebViewViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self.navigationController wy_customLeftBarButtonItem:self.navigationItem target:self selector:@selector(click) complete:^(UIButton *itemButton) {
        
        itemButton.backgroundColor = [UIColor whiteColor];
        [itemButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [itemButton setTitle:@"回首页" forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
        [itemButton wy_layouEdgeInsetsPosition:WY_ButtonPositionImageLeft_titleRight spacing:5];
        [itemButton sizeToFit];
    }];
}

- (void)click {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, wy_screenWidth, wy_screenHeight-wy_navViewHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com/cn/"]]];
    //看这里，看这里，一行代码就实现了进度监听个进度条颜色自定义
    [webView wy_showProgressWithColor:[UIColor orangeColor]];
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
