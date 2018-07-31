//
//  ViewController.m
//  GoSharePanel
//
//  Created by law on 2018/7/30.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import "ViewController.h"
#import "GoShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.center = self.view.center;
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"share" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)share {
    GoShareView *shareView = [[GoShareView alloc] initWithUrl:@"" title:@"" content:@"" image:nil];
    [shareView showInView:[UIApplication sharedApplication].keyWindow];
}


@end
