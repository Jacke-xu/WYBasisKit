//
//  ViewController.m
//  WYBasisKit
//
//  Created by jacke-xu on 2018/5/27.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "ViewController.h"
#import "WKWebView+Extension.h"
#import "NSMutableAttributedString+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)webView:(UIButton *)sender {
    
    UIViewController *viewController = [self sharedViewController];
    UIView *view = viewController.view;
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, navViewHeight, screenWidth, screenHeight-navViewHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://developer.apple.com"]]];
    [webView showProgressWithColor:[UIColor orangeColor]];
    [view addSubview:webView];
    
    [self presentViewController:viewController animated:YES completion:nil];
}
- (IBAction)attributed:(UIButton *)sender {
    
    UIViewController *viewController = [self sharedViewController];
    UIView *view = viewController.view;
    
    CGFloat labHeight = [[self testStr] boundingRectWithSize:CGSizeMake(screenWidth-40, 0) withFont:boldFont(15) lineSpacing:5].height;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, screenWidth-40, labHeight)];
    lab.text = [self testStr];
    lab.font = boldFont(15);
    lab.backgroundColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    
    NSMutableAttributedString *attribute = [NSMutableAttributedString attributeWithStr:lab.text];
    [attribute setLineSpacing:5];
    NSArray *colorsOfRanges = @[@{[UIColor orangeColor]:@[@"0",@"6"]},@{[UIColor greenColor]:@[@"8",@"10"]}];
    NSArray *fontsOfRanges = @[@{[UIFont systemFontOfSize:18]:@[@"30",@"5"]},@{[UIFont boldSystemFontOfSize:30]:@[@"1",@"2"]}];
    [attribute colorsOfRanges:colorsOfRanges];
    [attribute fontsOfRanges:fontsOfRanges];
    lab.attributedText = attribute;
    [lab sizeToFit];
    [view addSubview:lab];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (UIViewController *)sharedViewController {
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = randomColor;
    
    [vc.view addSubview:[UIView createBackNavWithTitle:@"basisKitTest" target:self selector:@selector(goBack)]];
    
    return vc;
}

- (NSString *)testStr {
    
    return @"治性之道，必审己之所有余而强其所不足，盖聪明疏通者戒于太察，寡闻少见者戒于壅蔽，勇猛刚强者戒于太暴，仁爱温良者戒于无断，湛静安舒者戒于后时，广心浩大者戒于遗忘。必审己之所当戒而齐之以义，然后中和之化应，而巧伪之徒不敢比周而望进。";
}

- (void)goBack {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
