//
//  LastViewController.m
//  SKBlockTest
//
//  Created by nachuan on 16/7/9.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "LastViewController.h"

@interface LastViewController ()

@end

@implementation LastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.blockTest3(@"test");
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.blockTest3(@"ddd");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"LastViewController --- dealloc");
}

@end
