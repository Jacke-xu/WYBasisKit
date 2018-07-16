//
//  TestBoolJudgeViewController.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "TestBoolJudgeViewController.h"
#import "NSString+Emoji.h"

@interface TestBoolJudgeViewController ()

@end

@implementation TestBoolJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WYLog(@"是否包含Emoji = %@",[NSNumber numberWithBool:[@"fwet😁" isIncludingEmoji]]);
    WYLog(@"是否包含Emoji = %@",[NSNumber numberWithBool:[@"😁" isIncludingEmoji]]);
    WYLog(@"是否是Emoji = %@",[NSNumber numberWithBool:[@"😁" isEmoji]]);
    WYLog(@"是否是Emoji = %@",[NSNumber numberWithBool:[@"j" isEmoji]]);
    WYLog(@"查看Emoji = %@",@"fwet😁");
    WYLog(@"移除Emoji = %@",[@"fwet😁" removedEmojiString]);
    WYLog(@"移除Emoji = %@",[@"fwet" removedEmojiString]);
    WYLog(@"移除Emoji = %@",[@"fwet💕" stringByReplacingEmojiCheatCodesWithUnicode]);
    WYLog(@"文字化Emoji = %@",[@"fwet💕" stringByReplacingEmojiUnicodeWithCheatCodes]);
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
