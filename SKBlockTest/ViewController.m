//
//  ViewController.m
//  SKBlockTest
//
//  Created by nachuan on 16/7/9.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(50, 50, 50, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    NSString *str1 = @"aaaa";//存放在常量区
    NSString *str2 = [str1 copy];//依然指向常量区的aaaa
    NSString *str7 = [NSString stringWithFormat:@"%@",str1]; //在栈中开辟了空间
    NSLog(@"str1==%p,str2==%p,str7==%p",str1, str2, str7);
    
    NSLog(@"str1==%p,str2==%p,str7==%p",&str1, &str2, &str7);

    
    /**
     *  以下都开辟了新的空间
     */
    NSMutableString *str3 = [NSMutableString stringWithString:str1];
    NSMutableString *str4 = [str3 copy];
    NSMutableString *str5 = [str3 mutableCopy];
    NSMutableString *str6 = [NSMutableString stringWithFormat:@"%@",str3];
    
    
    NSLog(@"str3==%p,str4==%p,str5==%p,str6==%p",str3, str4, str5, str6);
    NSLog(@"str3==%p,str4==%p,str5==%p,str6==%p",&str3, &str4, &str5, &str6);

    
    
    
}

- (void)rolAnim {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 60, 60)];
    layer.frame = CGRectMake(100, 100, 60, 60);
    layer.path = path.CGPath;
     
    
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 4;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.fromValue = @(M_PI / 2);
    animation.duration = 2;
    
    [layer addAnimation:animation forKey:nil];
    
    [self.view.layer addSublayer:layer];
}


- (void)btnClicked:(UIButton *)sender
{
    [self rolAnim];

    
//    NextViewController *next = [[NextViewController alloc] init];
////    [self.navigationController pushViewController:next animated:YES];
//    [self presentViewController:next animated:YES completion:^{
//        
//    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
