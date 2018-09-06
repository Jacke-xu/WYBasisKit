//
//  TestTUIButtonViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/22.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestTUIButtonViewController.h"
#import "UIImage+Extension.h"

@interface TestTUIButtonViewController ()

@end

@implementation TestTUIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn    = [[UIButton alloc]initWithFrame:CGRectMake(20, navViewHeight+50, screenWidth-40, 100) target:self selector:@selector(btnClick:)];
    btn.backgroundColor = [UIColor orangeColor];
    btn.titleFont = [UIFont boldSystemFontOfSize:25];
    btn.nTitle = @"默认状态";
    btn.hTitle = @"高亮状态";
    btn.sTitle = @"选中状态";
    btn.title_nColor = [UIColor greenColor];
    btn.title_hColor = [UIColor yellowColor];
    btn.title_sColor = [UIColor blackColor];
    btn.nImage = [UIImage imageNamed:@"timg-n"];
    btn.hImage = [UIImage imageNamed:@"timg-h"];
    btn.sImage = [UIImage imageNamed:@"timg-s"];
    
    CGSize titleSize = [btn.titleLabel.text boundingRectWithSize:btn.size withFont:btn.titleFont lineSpacing:0];
    CGSize imageSize = CGSizeMake(50, 50);
    
    //通过运行时设置图片控件与文本控件的位置
    btn.titleRect = CGRectMake((btn.width-titleSize.width)/2, (btn.height-imageSize.height-titleSize.height-5)/2, titleSize.width, titleSize.height);
    btn.imageRect = CGRectMake((btn.width-imageSize.width)/2, 5+titleSize.height+((btn.height-imageSize.height-titleSize.height-5)/2), imageSize.width, imageSize.height);
    
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(20, navViewHeight+200, screenWidth-40, 100) target:self selector:@selector(btnClick:)];
    btn2.backgroundColor = [UIColor orangeColor];
    btn2.titleFont = [UIFont boldSystemFontOfSize:25];
    btn2.nTitle = @"默认状态";
    btn2.title_nColor = [UIColor greenColor];
    btn2.nImage = [UIImage cutImage:[UIImage imageNamed:@"timg-n"] andSize:CGSizeMake(20, 30)];
    
    //通过EdgeInsets设置图片控件与文本控件的位置
    [btn2 layouEdgeInsetsPosition:ButtonPositionImageTop_titleBottom spacing:5];
    
    [self.view addSubview:btn2];
}

- (void)btnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSLog(@"sender:%@",sender);
    NSLog(@"nTitle = %@\nhTitle = %@\nsTitle = %@",sender.nTitle,sender.hTitle,sender.sTitle);
    NSLog(@"title_nColor = %@\ntitle_hColor = %@\ntitle_sColor = %@",sender.title_nColor,sender.title_hColor,sender.title_sColor);
    NSLog(@"nImage = %@\nhImage = %@\nsImage = %@",sender.nImage,sender.hImage,sender.sImage);
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
