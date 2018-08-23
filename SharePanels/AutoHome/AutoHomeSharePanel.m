//
//  AutoHomeSharePanel.m
//  GTSharePanel
//
//  Created by law on 2018/8/22.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import "AutoHomeSharePanel.h"
#import "UIButton+ImageTitleStyle.h"

static const NSUInteger cols = 4;
static const NSUInteger count = 7;
static const CGFloat btnW = 60.f;
static const CGFloat btnH = 60.f;

@interface AutoHomeSharePanel()
// mask
@property (nonatomic, strong) UIView *maskView;
// panel
@property (nonatomic, strong) UIView *sharePanel;
// buttons
@property (nonatomic, strong) NSMutableArray *btns;
// imageNames
@property (nonatomic, strong) NSArray *imageNames;
// titles
@property (nonatomic, strong) NSArray *titles;
@end

@implementation AutoHomeSharePanel

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.sharePanel];
    }
    return self;
}

- (void)show {
    
    [KEYWINDOW addSubview:self];
    
    CGRect frame = self.sharePanel.frame;
    frame.origin.y = kScreenHeight - kHomeIndicatorH - 10 - frame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.maskView.alpha = .3f;
        self.sharePanel.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(sharePanelDidShow:)]) {
            [self.delegate sharePanelDidShow:self];
        }
        
    }];
    
    [self.btns enumerateObjectsUsingBlock:^(UIButton *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger col = idx%cols;
        
        [UIView animateWithDuration:0.5 delay:0.1 + 0.08 * (col + 1) usingSpringWithDamping:0.75 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            obj.alpha = 1.f;
            obj.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (void)dismiss {
    
    CGRect frame = self.sharePanel.frame;
    frame.origin.y = kScreenHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.maskView.alpha = 0.f;
        self.sharePanel.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(sharePanelDidDismiss:)]) {
            [self.delegate sharePanelDidDismiss:self];
        }
        [self removeFromSuperview];
        
    }];
    
}

- (void)clickButton:(UIButton *)btn {
    NSLog(@"[分享至---%@]", btn.currentTitle);
    // do something...
    
    // dismiss
    [self dismiss];
}

#pragma mark - Getters

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (UIView *)sharePanel {
    if (!_sharePanel) {
        _sharePanel = [[UIView alloc] initWithFrame:CGRectMake(10, kScreenHeight, kScreenWidth-20, 190)];
        _sharePanel.backgroundColor = [UIColor whiteColor];
        _sharePanel.layer.cornerRadius = 10;
        _sharePanel.layer.masksToBounds = YES;
        
        CGFloat marginX = 19;
        CGFloat paddingX = (_sharePanel.frame.size.width - 2*marginX - btnW*cols)/(cols-1);
        CGFloat marginY = 26;
        CGFloat paddingY = 20;
        
        for (NSInteger i = 0; i<count; i++) {
            NSInteger row = i/cols;
            NSInteger col = i%cols;
            CGFloat x = marginX + col*(btnW+paddingX);
            CGFloat y = marginY + row*(btnH+paddingY);
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, btnW, btnH)];
            btn.titleLabel.font = [UIFont systemFontOfSize:11.7 weight:UIFontWeightThin];
            [btn setTitleColor:rgb(52, 52, 52) forState:UIControlStateNormal];
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
            [btn setButtonImageTitleStyle:(ButtonImageTitleStyleTop) padding:10];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_sharePanel addSubview:btn];
            [self.btns addObject:btn];
            
            // alpha + transform
            btn.alpha = 0.f;
            btn.transform = CGAffineTransformMakeTranslation(0, 50);
        }
    }
    return _sharePanel;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (NSArray *)imageNames {
    if (!_imageNames) {
        _imageNames = @[@"Riderscircle", @"share_icon_wechat", @"share_icon_wechatfriends", @"share_icon_sinaweibo", @"share_icon_qq", @"share_icon_qqzone", @"share_icon_alipay"];
    }
    return _imageNames;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"车友圈", @"微信", @"朋友圈", @"新浪微博", @"QQ好友", @"QQ空间", @"支付宝好友"];
    }
    return _titles;
}

@end
