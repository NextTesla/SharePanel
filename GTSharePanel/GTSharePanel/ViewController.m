//
//  ViewController.m
//  GTSharePanel
//
//  Created by law on 2018/8/21.
//  Copyright © 2018年 Goldx4. All rights reserved.
//

#import "ViewController.h"
#import "AutoHomeSharePanel.h"
#import "BossSharePanel.h"

@interface ViewController ()<GTSharePanelProtocol>
{
    NSIndexPath *_selectedIndexPath;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zelda"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = imageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath = indexPath;
    switch (indexPath.row) {
        case 0:
        {
            AutoHomeSharePanel *panel = [[AutoHomeSharePanel alloc] init];
            panel.delegate = self;
            [panel show];
        }
            break;
        case 1:
        {
            BossSharePanel *panel = [[BossSharePanel alloc] init];
            panel.delegate = self;
            [panel show];
        }
            break;
            
        case 2:
            
            break;
    }
}

- (void)sharePanelDidDismiss:(id)panel {
    NSLog(@"sharePanelDidDismiss---");
    [self.tableView deselectRowAtIndexPath:_selectedIndexPath animated:YES];
}

- (void)sharePanelDidShow:(id)panel {
    NSLog(@"sharePanelDidShow---");
}

@end
