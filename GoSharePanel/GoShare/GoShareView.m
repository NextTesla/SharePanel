//
//  GoShareView.m
//  GoSharePanel
//
//  Created by law on 2018/7/30.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHomeIndicatorH (iPhoneX ? 34 : 0)

#import "GoShareView.h"
#import "GoShareButton.h"

@interface GoShareView ()
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

@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;

@end

@implementation GoShareView

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title content:(NSString *)content image:(UIImage *)image {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.sharePanel];
        
        self.shareUrl = [url copy];
        self.shareTitle = [title copy];
        self.shareContent = [content copy];
        self.shareImage = image;
    }
    return self;
}

- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    CGRect frame = self.sharePanel.frame;
    frame.origin.y = SCREEN_HEIGHT - kHomeIndicatorH - 10 - frame.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = .3f;
        self.sharePanel.frame = frame;
    }];
    
    [self.btns enumerateObjectsUsingBlock:^(UIButton *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [UIView animateWithDuration:0.5 delay:0.1 + 0.05 * (idx + 1) usingSpringWithDamping:0.75 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            obj.alpha = 1.f;
            obj.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (void)dismiss {
    
    CGRect frame = self.sharePanel.frame;
    frame.origin.y = SCREEN_HEIGHT;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.f;
        self.sharePanel.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)clickButton:(UIButton *)btn {
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
        _sharePanel = [[UIView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT, SCREEN_WIDTH-20, 190)];
        _sharePanel.backgroundColor = [UIColor whiteColor];
        _sharePanel.layer.cornerRadius = 10;
        _sharePanel.layer.masksToBounds = YES;
        
        NSInteger cols = 4;
        NSInteger count = 7;
        CGFloat w = 60;
        CGFloat h = 60;
        CGFloat marginX = 19;
        CGFloat paddingX = (_sharePanel.frame.size.width - 2*marginX - w*cols)/(cols-1);
        CGFloat marginY = 26;
        CGFloat paddingY = 20;
        
        for (NSInteger i = 0; i<count; i++) {
            NSInteger row = i/cols;
            NSInteger col = i%cols;
            CGFloat x = marginX + col*(w+paddingX);
            CGFloat y = marginY + row*(h+paddingY);
            GoShareButton *btn = [[GoShareButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
            [btn setTitle:self.titles[i] forState:UIControlStateNormal];
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
        _imageNames = @[@"share_wechat", @"share_timeline", @"share_sina", @"share_qq", @"share_qqzone", @"share_alipay", @"share_link"];
    }
    return _imageNames;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"微信", @"朋友圈", @"新浪微博", @"QQ好友", @"QQ空间", @"支付宝好友", @"复制链接"];
    }
    return _titles;
}

@end
