//
//  LoadingView.m
//  WYBasisKit
//
//  Created by jacke-xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *lable;

@property (nonatomic, weak) UIActivityIndicatorView *activity;

@property (nonatomic, weak) UIImageView *heartImageView;

@end

@implementation LoadingView

static LoadingView *_loadingView = nil;
+ (LoadingView *)shared {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        _loadingView = [[LoadingView alloc]init];
    });
    [StateView dismiss];
    
    return _loadingView;
}

+ (void)showMessage:(NSString *)message {
    
    [self showWithMessage:message superView:[UIApplication sharedApplication].delegate.window];
}

+ (void)showMessage:(NSString *)message superView:(UIView *)superView {
    
    [self showWithMessage:message superView:superView];
}

+ (void)showInfo:(NSString *)message {
    
    [self showWithInfo:message superView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showInfo:(NSString *)message superView:(UIView *)superView {
    
    [self showWithInfo:message superView:superView];
}

+ (void)showWithMessage:(NSString *)message superView:(UIView *)superView {
    
    _loadingView = [self shared];
    superView = [_loadingView sharedSuperView:superView];
    _loadingView.frame = CGRectMake(superView.frame.size.width/2-75, superView.frame.size.height/2-60, 150, 120);
    [superView addSubview:_loadingView];
    _loadingView.activity.hidden = YES;
    if(_loadingView.bgView.frame.size.width != 150) {
        
        _loadingView.bgView.frame = CGRectMake(0, 0, 150, 120);
        _loadingView.bgView.layer.cornerRadius = 10;
    }
    _loadingView.heartImageView.hidden = NO;
    [_loadingView.heartImageView startAnimating];
    
    _loadingView.lable.frame = CGRectMake(_loadingView.bgView.frame.size.width/2-50, 80, 100, 40);
    _loadingView.lable.text = message;
}

+ (void)showWithInfo:(NSString *)message superView:(UIView *)superView {
    
    _loadingView = [self shared];
    superView = [_loadingView sharedSuperView:superView];
    _loadingView.frame = CGRectMake(superView.frame.size.width/2-60, superView.frame.size.height/2-50, 120, 100);
    [superView addSubview:_loadingView];
    _loadingView.heartImageView.hidden = YES;
    if(_loadingView.bgView.frame.size.width != 120) {
        
        _loadingView.bgView.frame = CGRectMake(0, 0, 120, 100);
        _loadingView.bgView.layer.cornerRadius = 15;
    }
    
    _loadingView.activity.hidden = NO;
    [_loadingView.activity startAnimating];
    
    _loadingView.lable.frame = CGRectMake(15, 65, 90, 20);
    _loadingView.lable.text = message;
    [_loadingView layoutFrame];
}

+ (void)dismiss {
    
    [_loadingView removeFromSuperview];
}

- (UILabel *)setLabLineSpacing:(NSInteger)lineSpacing withControll:(UILabel *)lab {
    
    if(lab.text.length > 0) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lab.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lab.text length])];
        lab.attributedText = attributedString;
        [lab sizeToFit];
    }
    
    return lab;
}

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(UIFont *)font Text:(NSString *)text {
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

- (UIView *)bgView {
    
    if(_bgView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        view.layer.masksToBounds = YES;
        [_loadingView addSubview:view];
        
        _bgView = view;
    }
    
    return _bgView;
}

- (UIActivityIndicatorView *)activity {
    
    if(_activity == nil) {
        
        UIActivityIndicatorView *acti = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        acti.frame = CGRectMake(_bgView.frame.size.width/2-20, 15, 40, 40);
        [_bgView addSubview:acti];
        
        _activity = acti;
    }
    
    return _activity;
}

- (UILabel *)lable {
    
    if(_lable == nil) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:lab];
        
        _lable = lab;
    }
    
    return _lable;
}

- (UIImageView *)heartImageView {
    
    if(_heartImageView == nil) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_bgView.frame.size.width/2-50, 10, 100, 80)];
        NSMutableArray *images = [[NSMutableArray alloc]initWithCapacity:6];
        for (int i=1; i<=5; i++)
        {
            [images addObject:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"car%d.png",i]]]];
        }
        imgView.animationImages = images;
        imgView.animationDuration = 0.4 ;
        imgView.animationRepeatCount = MAXFLOAT;
        [_bgView addSubview:imgView];
        
        _heartImageView = imgView;
    }
    
    return _heartImageView;
}

- (void)layoutFrame {
    
    CGSize labSize = [self boundingRectWithSize:CGSizeMake(_lable.frame.size.width, 0) withFont:[UIFont boldSystemFontOfSize:16] Text:_lable.text];
    if(labSize.height > 25) {
        
        _bgView.frame = CGRectMake(0, 0, 135, 120);
        _lable.frame = CGRectMake(25, 65, 85, 0);
        _lable.numberOfLines = 2;
        [self setLabLineSpacing:5 withControll:_lable];
        _lable.numberOfLines = 2;
    }
    _activity.frame = CGRectMake(_bgView.frame.size.width/2-20, 15, 40, 40);
}

- (UIView *)sharedSuperView:(UIView *)superView {
    
    if([self belongsViewController] != nil) {
        
        superView = [self belongsViewController].view;
    }
    return superView;
}

- (UIViewController *)belongsViewController {
    
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGSize)proportionSize:(CGSize)size {
    
    size.height = (size.width/5)*4;
    
    return size;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

