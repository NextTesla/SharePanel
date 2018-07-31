//
//  GoShareButton.m
//  GoSharePanel
//
//  Created by law on 2018/7/30.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#import "GoShareButton.h"

@implementation GoShareButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.7 weight:UIFontWeightThin];
        [self setTitleColor:RGB(52, 52, 52) forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat ratio = 0.4;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * ratio;
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height * (1 - ratio) + 7;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 34;
    CGFloat imageX = (self.frame.size.width - imageW) * 0.5;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageW);
}

@end
