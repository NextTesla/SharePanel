//
//  GoShareView.h
//  GoSharePanel
//
//  Created by law on 2018/7/30.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoShareView : UIView

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title content:(NSString *)content image:(UIImage *)image;

- (void)showInView:(UIView *)view;
- (void)dismiss;

@end
