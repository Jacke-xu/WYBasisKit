//
//  StateView.m
//  WYBasisKit
//
//  Created by jacke－xu on 17/2/12.
//  Copyright © 2017年 com.jacke-xu. All rights reserved.
//

#import "StateView.h"

@interface StateView ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *label;

@end

@implementation StateView
static StateView *_stateView = nil;

+ (StateView *)shared {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        _stateView = [[StateView alloc]initWithFrame:CGRectMake(screenWidth/2-60, screenHeight/2-50, 120, 100)];
    });
    [LoadingView dismiss];
    
    return _stateView;
}

+ (void)showSuccessInfo:(NSString *)message {
    
    weakSelf(self);
    [[weakself shared] layoutStateViewWithImage:@"success" message:message superView:[UIApplication sharedApplication].keyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself dismiss];
    });
}

+ (void)showErrorInfo:(NSString *)message {
    
    weakSelf(self);
    [[weakself shared] layoutStateViewWithImage:@"error" message:message superView:[UIApplication sharedApplication].keyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself dismiss];
    });
}

+ (void)showWarningInfo:(NSString *)message {
    
    weakSelf(self);
    [[weakself shared] layoutStateViewWithImage:@"waitting" message:message superView:[UIApplication sharedApplication].keyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself dismiss];
    });
}

- (void)layoutStateViewWithImage:(NSString *)image message:(NSString *)message superView:(UIView *)superView {
    
    self.imageView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"] stringByAppendingPathComponent:image]];
    self.label.text = message;
    [self.label sizeToFit];
    
    if(_label.frame.size.width <= 90) {
    }else if (_label.frame.size.width <= 220.0) {
        
        if(_label.frame.size.width <= 110) {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-65, superView.frame.size.height/2-55, 130, 110);
            
        }else {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-70, superView.frame.size.height/2-60, 140, 120);
        }
        
    }else if (_label.frame.size.width <= 390.0) {
        
        if(_label.frame.size.width <= 130) {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-75, superView.frame.size.height/2-65, 150, 130);
            
        }else {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-80, superView.frame.size.height/2-70, 160, 140);
        }
        
    }else {
        
        if(_label.frame.size.width <= 150) {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-85, superView.frame.size.height/2-75, 170, 150);
            
        }else {
            
            _stateView.frame = CGRectMake(superView.frame.size.width/2-90, superView.frame.size.height/2-80, 180, 160);
        }
    }
    
    _bgView.frame = CGRectMake(0, 0, _stateView.frame.size.width, _stateView.frame.size.height);
    _imageView.frame = CGRectMake(0, 20, _bgView.frame.size.width, 35);
    _label.frame = CGRectMake(15, 65, _stateView.frame.size.width-30, 0);
    _label.numberOfLines = 4;
    [self setLabLineSpacing:5 WithControll:_label];
    _label.numberOfLines = 4;
    _label.frame = CGRectMake(15, 65, _bgView.frame.size.width-30, _label.frame.size.height);
    _label.textAlignment = NSTextAlignmentCenter;
    
    _stateView.frame = CGRectMake(_stateView.frame.origin.x, (superView.frame.size.height-(65+_label.frame.size.height+8))/2, _stateView.frame.size.width, 65+_label.frame.size.height+8);
    _bgView.frame = CGRectMake(0, 0, _stateView.frame.size.width, _stateView.frame.size.height);
    
    [superView addSubview:_stateView];
}

+ (void)dismiss {
    
    [_stateView removeFromSuperview];
}

- (UIView *)bgView {
    
    if(!_bgView) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 100)];
        view.layer.cornerRadius = 15;
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [_stateView addSubview:view];
        
        _bgView = view;
    }
    
    return _bgView;
}

- (UIImageView *)imageView {
    
    if(!_imageView) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 120, 35)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgView addSubview:imgView];
        _imageView = imgView;
    }
    
    return _imageView;
}

- (UILabel *)label {
    
    if(!_label) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, 90, 20)];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor whiteColor];
        [_bgView addSubview:lab];
        
        _label = lab;
    }
    
    return _label;
}

- (UILabel *)setLabLineSpacing:(NSInteger)lineSpacing WithControll:(UILabel *)lab {
    
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
