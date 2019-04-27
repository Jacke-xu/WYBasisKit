//
//  WYSegmentedView.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/14.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "WYSegmentedView.h"
#import "UIButton+WY_EdgeInsets.h"

@interface WYSegmentedView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *headerScrollView;

@property (nonatomic, weak) UIScrollView *vcScrollView;

@property (nonatomic, strong) UIView *dividingStrip;//标签下面的滚动线条

@property (nonatomic, assign) CGFloat dividingStripWidth;//滚动线条宽度

@property (nonatomic, strong) UIButton *currentItem;//当前选中的标签

@property (nonatomic, copy) void(^clickItem)(NSInteger itemIndex);//点击事件

@property (nonatomic, strong) NSArray *titleAry;//title数组

@property (nonatomic, strong) NSArray *normalImageAry;//未选中状态图片数组

@property (nonatomic, strong) NSArray *selerctedImageAry;//选中状态图片数组

@property (nonatomic, strong) NSArray *controllerAry;//控制器数组

@property (nonatomic, strong) UIViewController *superViewController;//父控制器

@end

@implementation WYSegmentedView

- (instancetype)initWithFrame:(CGRect)frame superViewController:(UIViewController *)superViewController {
    
    if(self == [super initWithFrame:frame]) {
        
        self.frame = frame;
        self.superViewController = superViewController;
        [self setUpDefaultProperty];
    }
    
    return self;
}

- (void)layoutWithControllerAry:(NSArray<UIViewController *> *)controllerAry TitleAry:(NSArray<NSString *> *)titleAry {
    
    self.titleAry = titleAry;
    self.controllerAry = controllerAry;
    
    [self layout];
}

- (void)layoutWithControllerAry:(NSArray<UIViewController *> *)controllerAry TitleAry:(NSArray<NSString *> *)titleAry normalImageAry:(NSArray *)normalImageAry selectedImageAry:(NSArray *)selectedImageAry {
    
    self.titleAry = titleAry;
    self.normalImageAry = normalImageAry;
    self.selerctedImageAry = selectedImageAry;
    self.controllerAry = controllerAry;
    
    [self layout];
}

- (void)setUpDefaultProperty {
    
    self.bg_no_Color = [UIColor whiteColor];
    self.bg_sl_Color = [UIColor whiteColor];
    
    self.headerHeight = 45;
    
    self.item_no_Color = wy_hexColor(@"9b9b9b");
    self.item_sl_Color = wy_hexColor(@"000000");
    
    self.dividingStripColor = wy_hexColor(@"fad961");
    self.dividingStripHeight = 2.0;
    
    self.control_dividingStripColor = WY_RGB(244, 244, 244);
    
    self.item_no_Font = [UIFont systemFontOfSize:15];
    self.item_sl_Font = [UIFont systemFontOfSize:15];
    
    self.selectedIndex = 0;
}

- (void)layout {
    
    if(!self.itemWidth) {
        
        self.itemWidth = (_titleAry.count > 5) ? wy_screenWidth/5 : wy_screenWidth/_titleAry.count;
        
        self.dividingStripWidth = _itemWidth-20;
    }
    [self layoutHeaderView];
    [self layoutController];
}

- (void)layoutHeaderView {
    
    self.scrollView.backgroundColor = _bg_no_Color;
    
    for (int i=0; i<_titleAry.count; i++) {
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(_itemWidth*i, 0, _itemWidth, _headerHeight-_dividingStripHeight);
        [item setTitleColor:_item_no_Color forState:UIControlStateNormal];
        [item setTitleColor:_item_sl_Color forState:UIControlStateSelected];
        item.titleLabel.font = (i == _selectedIndex) ? _item_sl_Font : _item_no_Font;
        [item setTitle:_titleAry[i] forState:UIControlStateNormal];
        if((_normalImageAry.count == _titleAry.count) && (_selerctedImageAry.count == _titleAry.count)) {
            
            UIImage *normalImage = ([_normalImageAry[i] isKindOfClass:[UIImage class]]) ? _normalImageAry[i] : [UIImage imageNamed:_normalImageAry[i]];
            [item setImage:normalImage forState:UIControlStateNormal];
            
            UIImage *selectedImage = ([_selerctedImageAry[i] isKindOfClass:[UIImage class]]) ? _selerctedImageAry[i] : [UIImage imageNamed:_selerctedImageAry[i]];
            [item setImage:selectedImage forState:UIControlStateSelected];
            
            item.wy_imageRect = CGRectMake(0, (item.wy_height-normalImage.size.height-5-15)/2, _itemWidth, normalImage.size.height);
            item.imageView.contentMode = UIViewContentModeCenter;
            item.wy_titleRect = CGRectMake(0, 5+item.imageView.wy_right, _itemWidth, 15);
            item.titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }else {
            //WYLog(@"图片数组越界");
        }
        item.tag = 100+i;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i == _selectedIndex) {
            
            item.selected = YES;
            _currentItem = item;
        }
        [_headerScrollView addSubview:item];
    }
    
    //设置scrollView的ContentSize让其滚动
    _headerScrollView.contentSize = CGSizeMake(_itemWidth * _titleAry.count, 0);
}

- (void)layoutController {
    
    self.vcScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)clickItemAtIndex:(void (^)(NSInteger))itemIndex {
    
    _clickItem = itemIndex;
}

- (void)itemClick:(UIButton *)sender {
    
    if(sender.tag != _currentItem.tag) {
        
        _vcScrollView.contentOffset = CGPointMake(wy_screenWidth*(sender.tag-100), 0);
    }
    //重新赋值标签属性
    [self updateItemProperty:sender];
}

- (void)updateItemProperty:(UIButton *)currentItem {
    
    if(currentItem.tag != _currentItem.tag) {
        
        _currentItem.selected = NO;
        
        _currentItem.backgroundColor = _bg_no_Color;
        [_currentItem setTitleColor:_item_no_Color forState:UIControlStateNormal];
        _currentItem.titleLabel.font = _item_no_Font;
        
        //将当前选中的item赋值
        currentItem.selected = YES;
        _currentItem = currentItem;
        
        _currentItem.backgroundColor = _bg_sl_Color;
        [_currentItem setTitleColor:_item_sl_Color forState:UIControlStateSelected];;
        _currentItem.titleLabel.font = _item_sl_Font;
        
        //调用最终的方法
        [self lastMethod];
    }
}

- (void)lastMethod{
    
    //计算应该滚动多少
    CGFloat needScrollOffsetX = _currentItem.center.x - _headerScrollView.bounds.size.width * 0.5;
    
    //最大允许滚动的距离
    CGFloat maxAllowScrollOffsetX = _headerScrollView.contentSize.width - _headerScrollView.bounds.size.width;
    
    if (needScrollOffsetX < 0) {
        
        needScrollOffsetX = 0;
    }
    
    if (needScrollOffsetX > maxAllowScrollOffsetX) {
        
        needScrollOffsetX = maxAllowScrollOffsetX;
    }
    
    [_headerScrollView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:.2f animations:^{
        
        weakself.dividingStrip.frame = CGRectMake((weakself.currentItem.tag-100)*weakself.currentItem.wy_width+((weakself.currentItem.wy_width-weakself.dividingStripWidth)/2), weakself.headerHeight-weakself.dividingStripHeight, weakself.dividingStripWidth, weakself.dividingStripHeight);
    }];
    
    if(_clickItem) {
        
        _clickItem(_currentItem.tag-100);
    }
}

//监听滚动事件判断当前拖动到哪一个了
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if((scrollView == _vcScrollView) && (_vcScrollView.contentOffset.x >= 0)) {
        
        CGFloat index = scrollView.contentOffset.x / wy_screenWidth;
        UIButton *channeItem =  (UIButton *)[_headerScrollView viewWithTag:100+index];
        //重新赋值标签属性
        [self updateItemProperty:channeItem];
    }
}

- (UIScrollView *)scrollView {
    
    if (_headerScrollView == nil) {
        
        //给scrollView的每个控件添加标志用的分隔线
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((_itemWidth*_selectedIndex)+10, _headerHeight-_dividingStripHeight, _dividingStripWidth, _dividingStripHeight)];
        view.backgroundColor = _dividingStripColor;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _headerHeight-_dividingStripHeight, wy_screenWidth, _dividingStripHeight)];
        lineView.backgroundColor = _control_dividingStripColor;
        
        //设置ScrollView的位置与大小
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wy_screenWidth, _headerHeight)];
        scroll.showsHorizontalScrollIndicator = NO;
        [scroll addSubview:lineView];
        [scroll addSubview:view];
        
        [self addSubview:scroll];
        
        self.dividingStrip = view;
        _headerScrollView = scroll;
    }
    return _headerScrollView;
}

- (UIScrollView *)vcScrollView {
    
    if(_vcScrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerHeight, wy_screenWidth, self.frame.size.height-_headerHeight)];
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled = YES;
        scrollView.scrollEnabled = YES;
        scrollView.contentSize = CGSizeMake(wy_screenWidth*_titleAry.count, scrollView.frame.size.height);
        [scrollView setContentOffset:CGPointMake(wy_screenWidth*_selectedIndex, 0)];
        [self addSubview:scrollView];
        
        _vcScrollView = scrollView;
        
        for (int i = 0; i < _controllerAry.count; i++) {
            
            UIViewController *viewcontroller = _controllerAry[i];
            UIView *viewcon = viewcontroller.view;
            viewcon.frame = CGRectMake(wy_screenWidth*i, 0, wy_screenWidth, scrollView.frame.size.height);
            
            [scrollView addSubview:viewcon];
            [self.superViewController addChildViewController:viewcontroller];
        }
    }
    
    return _vcScrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
