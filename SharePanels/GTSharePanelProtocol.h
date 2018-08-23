//
//  GTSharePanelProtocol.h
//  GTSharePanel
//
//  Created by law on 2018/8/23.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

/**
 *  Device info.
 */
#define KEYWINDOW [UIApplication sharedApplication].keyWindow
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define iPhoneX         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125.f, 2436.f), [[UIScreen mainScreen] currentMode].size) : NO)
#define kHomeIndicatorH (iPhoneX ? 34.f : 0)

/**
 *  rgb color
 */
#define rgb(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#import <Foundation/Foundation.h>

@protocol GTSharePanelProtocol<NSObject>

@optional
- (void)sharePanelDidShow:(id)panel;
- (void)sharePanelDidDismiss:(id)panel;

@end
