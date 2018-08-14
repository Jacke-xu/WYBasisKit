//
//  TestLableViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/20.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestLableViewController.h"
#import "UILabel+RichText.h"
#import "NSMutableParagraphStyle+Extension.h"
#import "NSMutableAttributedString+Extension.h"

@interface TestLableViewController ()<RichTextDelegate>

@end

@implementation TestLableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat labHeight = [[self testStr] boundingRectWithSize:CGSizeMake(screenWidth-40, 0) withFont:boldFont(15) lineSpacing:5].height;
    
    UILabel *lab = [UILabel createLabWithFrame:CGRectMake(20, 0, screenWidth-40, labHeight) text:[self testStr] textColor:[UIColor blackColor] font:boldFont(15) bgColor:[UIColor lightGrayColor]];
    lab.numberOfLines = 0;
    
    NSMutableAttributedString *attribute = [NSMutableAttributedString attributeWithStr:lab.text];
    [attribute setLineSpacing:5];
    NSArray *colorsOfRanges = @[@{[UIColor orangeColor]:@"治性之道"},@{[UIColor greenColor]:@"盖聪明疏通者戒于太察"}];
    NSArray *fontsOfRanges = @[@{[UIFont systemFontOfSize:18]:@"广心浩大者戒于遗忘"},@{[UIFont boldSystemFontOfSize:30]:@[@"1",@"2"]}];
//    NSArray *colorsOfRanges = @[@{[UIColor orangeColor]:@[@"0",@"6"]},@{[UIColor greenColor]:@[@"8",@"10"]}];
//    NSArray *fontsOfRanges = @[@{[UIFont systemFontOfSize:18]:@[@"30",@"5"]},@{[UIFont boldSystemFontOfSize:30]:@[@"1",@"2"]}];
    [attribute colorsOfRanges:colorsOfRanges];
    [attribute fontsOfRanges:fontsOfRanges];
    lab.attributedText = attribute;
    [lab sizeToFit];
    [attribute addAttribute:NSLinkAttributeName value:@"聪明" range:[[attribute string] rangeOfString:@"仁爱温良"]];
    [self.view addSubview:lab];
    
    
    //富文本点击
    //需要点击的字符相同
    NSString *label_text1 = @"我是个抽奖Label， 点我有奖，点我没奖哦";
    
    NSMutableAttributedString *attributedString1 = [NSMutableAttributedString attributeWithStr:label_text1];
    
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, label_text1.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12, 2)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(17, 2)];

    NSMutableParagraphStyle *sty = [NSMutableParagraphStyle paragraphStyle];
    sty.alignment = NSTextAlignmentCenter;
    sty.lineSpacing = 5;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:sty range:NSMakeRange(0, label_text1.length)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, lab.bottom+50, self.view.bounds.size.width - 20, 60)];
    label1.backgroundColor = [UIColor yellowColor];
    label1.numberOfLines = 2;
    //设置点击效果颜色 默认lightGrayColor
    label1.clickEffectColor = [UIColor greenColor];
    label1.attributedText = attributedString1;
    [self.view addSubview:label1];
    
    [label1 clickRichTextWithStrings:@[@"点我",@"点我"] delegate:self];
    
    //需要点击的字符不同
    NSString *label_text2 = @"您好！您是小明吗？你中奖了，领取地址“https://github.com/Jacke-xu/WYBasisKit”,领奖码“记得给star哦”";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19, 38)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(63, 8)];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, label1.bottom+50, self.view.bounds.size.width - 20, 80)];
    label2.backgroundColor = [UIColor greenColor];
    label2.numberOfLines = 3;
    label2.attributedText = attributedString2;
    [self.view addSubview:label2];
    
    [label2 clickRichTextWithStrings:@[@"https://github.com/Jacke-xu/WYBasisKit",@"记得给star哦"] clickAction:^(NSString *string, NSRange range, NSInteger index) {
        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
        WYLog(@"messge = %@",message);
    }];
    //设置是否有点击效果，默认是YES
    label2.enabledClickEffect = NO;
}

- (NSString *)testStr {
    
    return @"治性之道，必审己之所有余而强其所不足，盖聪明疏通者戒于太察，寡闻少见者戒于壅蔽，勇猛刚强者戒于太暴，仁爱温良者戒于无断，湛静安舒者戒于后时，广心浩大者戒于遗忘。必审己之所当戒而齐之以义，然后中和之化应，而巧伪之徒不敢比周而望进。";
}

- (void)didClickRichText:(NSString *)string range:(NSRange)range index:(NSInteger)index {
    
    NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
    WYLog(@"messge = %@",message);
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
