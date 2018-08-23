//
//  BossSharePanel.m
//  GTSharePanel
//
//  Created by law on 2018/8/23.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import "BossSharePanel.h"
#import "UIButton+ImageTitleStyle.h"

typedef NS_ENUM(NSInteger, BossShareType) {
    BossShareTypeWXFriend,
    BossShareTypeWXTimeLine,
    BossShareTypeSM
};

static const CGFloat panelHeight = 170.f;

@interface BossSharePanel()
// mask
@property (nonatomic, strong) UIView *maskView;
// panel
@property (nonatomic, strong) UIVisualEffectView *sharePanel;
@end

@implementation BossSharePanel

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.maskView];
        [self addSubview:self.sharePanel];
    }
    return self;
}

- (void)clickShareButton:(UIButton *)button {
    NSLog(@"[分享至---%@]", button.currentTitle);
    // do something...
    
    // dismiss
    [self dismiss];
}

- (void)show {
    
    [KEYWINDOW addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CGRect frame = self.sharePanel.frame;
        frame.origin.y = kScreenHeight - frame.size.height;
        self.sharePanel.frame = frame;
        
    } completion:^(BOOL finished) {
        
        self.maskView.alpha = .3f;
        
        if ([self.delegate respondsToSelector:@selector(sharePanelDidShow:)]) {
            [self.delegate sharePanelDidShow:self];
        }
        
    }];
}

- (void)dismiss {
    
    self.maskView.alpha = 0.f;
    CGRect frame = self.sharePanel.frame;
    frame.origin.y = kScreenHeight;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.sharePanel.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(sharePanelDidDismiss:)]) {
            [self.delegate sharePanelDidDismiss:self];
        }
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark - Getters

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-panelHeight-kHomeIndicatorH)];
        _maskView.backgroundColor = [UIColor darkGrayColor];
        _maskView.alpha = 0.f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIVisualEffectView *)sharePanel {
    if (!_sharePanel) {
        // blur effect...
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _sharePanel = [[UIVisualEffectView alloc] initWithEffect:effect];
        _sharePanel.frame = CGRectMake(0, kScreenHeight, kScreenWidth, panelHeight+kHomeIndicatorH);
        
        // cancel button
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 50)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightThin];
        [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_sharePanel.contentView addSubview:cancelButton];
        
        // share buttons
        CGFloat btnY = 25.f;
        CGFloat btnW = 60.f;
        CGFloat btnH = 80.f;
        CGFloat margin = (kScreenWidth-btnW*3)/4;
        
        UIButton *wechat = [UIButton buttonWithType:UIButtonTypeCustom];
        wechat.frame = CGRectMake(margin, btnY, btnW, btnH);
        [wechat setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        wechat.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
        [wechat setTitle:@"微信好友" forState:UIControlStateNormal];
        [wechat setImage:[UIImage imageNamed:@"blur_share_wxhy"] forState:UIControlStateNormal];
        [wechat setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:8];
        wechat.tag = BossShareTypeWXFriend;
        [wechat addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [_sharePanel.contentView addSubview:wechat];
        
        UIButton *timeline = [UIButton buttonWithType:UIButtonTypeCustom];
        timeline.frame = CGRectMake(margin*2+btnW, btnY, btnW, btnH);
        [timeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        timeline.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
        [timeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [timeline setImage:[UIImage imageNamed:@"blur_share_wxpyq"] forState:UIControlStateNormal];
        [timeline setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:8];
        timeline.tag = BossShareTypeWXTimeLine;
        [timeline addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [_sharePanel.contentView addSubview:timeline];
        
        UIButton *sm = [UIButton buttonWithType:UIButtonTypeCustom];
        sm.frame = CGRectMake(margin*3+btnW*2, btnY, btnW, btnH);
        [sm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sm.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
        [sm setTitle:@"短信" forState:UIControlStateNormal];
        [sm setImage:[UIImage imageNamed:@"blur_share_sm"] forState:UIControlStateNormal];
        [sm setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:8];
        sm.tag = BossShareTypeSM;
        [sm addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [_sharePanel.contentView addSubview:sm];
        
        // seperators
        UIView *seperator1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        seperator1.backgroundColor = [UIColor lightGrayColor];
        [_sharePanel.contentView addSubview:seperator1];
        UIView *seperator2 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 0.5)];
        seperator2.backgroundColor = [UIColor darkGrayColor];
        [_sharePanel.contentView addSubview:seperator2];
    }
    return _sharePanel;
}

@end
