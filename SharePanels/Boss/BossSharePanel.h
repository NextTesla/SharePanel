//
//  BossSharePanel.h
//  GTSharePanel
//
//  Created by law on 2018/8/23.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTSharePanelProtocol.h"

@interface BossSharePanel : UIView

/// delegate
@property (nonatomic, weak) id<GTSharePanelProtocol> delegate;

- (void)show;
- (void)dismiss;

@end
