//
//  LastViewController.h
//  SKBlockTest
//
//  Created by nachuan on 16/7/9.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastViewController : UIViewController

@property (nonatomic, weak) void (^blockTest3)(NSString *title);//此处用assign可以解决循环引用的问题.

@end
