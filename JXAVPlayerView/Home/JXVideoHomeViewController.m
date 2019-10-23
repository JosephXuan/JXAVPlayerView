//
//  JXVideoHomeViewController.m
//  JXAVPlayerView
//
//  Created by JosephXuan on 2019/10/21.
//  Copyright © 2019 JosephXuan. All rights reserved.
//

#import "JXVideoHomeViewController.h"

@interface JXVideoHomeViewController ()

@end

@implementation JXVideoHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
