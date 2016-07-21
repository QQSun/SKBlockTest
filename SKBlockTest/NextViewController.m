//
//  NextViewController.m
//  SKBlockTest
//
//  Created by nachuan on 16/7/9.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "NextViewController.h"
#import "LastViewController.h"
@interface NextViewController ()

@property (nonatomic, strong) LastViewController *last;

@property (nonatomic, copy) NSString *blockTitle;

@property (nonatomic, copy) void (^blockTest2)(NSString *title);

@property (nonatomic, weak) void (^blockTest4)(NSString *title);

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(50, 50, 50, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    /**
     *  此处没有循环引用
     */
    [self blockTest1:^(NSInteger index) {
        self.blockTitle = [NSString stringWithFormat:@"block : %zd",index];
        NSLog(@"%@",self.blockTitle);
    }];
    
    
    /**
     *  此处引起了循环引用
     */
    self.blockTest2 = ^ (NSString *title) {
        self.blockTitle = title;//此处引起了循环引用了
        NSLog(@"%@",self.blockTitle);
    };
    self.blockTest2(@"blockTest2");//该处就算不调用.也不会释放内存
    
    
    
}



- (void)btnClicked:(UIButton *)sender
{
    
    /**
     *  以下引起了循环引用 1
     */
//    LastViewController *last = [[LastViewController alloc] init];
//    self.last = last;   //此处是引起内存泄漏的主因.而非下面Block.这一句导致了本类对象和last对象均不能被释放
//                        //比较隐蔽.而且Xcode不会报警告
//    last.blockTest3 = ^(NSString *title){
//        NSLog(@"%@",title);
//        self.view.backgroundColor = [UIColor magentaColor];
//    };
//    [self presentViewController:self.last animated:YES completion:^{}];

    //或者
    
    /**
     *  以下引起了循环引用 2 ,Xcode有警告,此处self.last如果不被初始化.虽然报警告.但是不会导致self无法被释放
     */
//    self.last = [[LastViewController alloc] init];//没有该句.下面有警告也不会导致内存泄漏,注意上面的 self.last = last;
//    self.last.blockTest3 = ^(NSString *title){
//        NSLog(@"%@",title);
//        self.view.backgroundColor = [UIColor magentaColor];
//    };
//    [self presentViewController:self.last animated:YES completion:^{}];

    
    /**
     *  解决方法
     */
    //    __weak typeof(self)weakSelf = self;
    //    self.last.blockTest3 = ^(NSString *title){
    //
    //        //只需要将block内部调用self的弱化指针即可
    //        weakSelf.view.backgroundColor = [UIColor magentaColor];
    //    };

    
    /**
     *  下面的奇葩用法没有造成循环引用
     */
//    LastViewController *last = [[LastViewController alloc] init];
//    last.blockTest3 = ^(NSString *title){
//        NSLog(@"%@",title);
//        self.view.backgroundColor = [UIColor magentaColor];
//    };
//    [self presentViewController:last animated:YES completion:^{}];

    
    /**
     *  更奇葩用法.两个界面的block都用weak修饰.导致self提前释放.
     */
//    LastViewController *last = [[LastViewController alloc] init];
//    self.blockTest4 = ^(NSString *title){
//        self.view.backgroundColor = [UIColor greenColor];
//    };
//    last.blockTest3 = self.blockTest4;
//    [self presentViewController:last animated:YES completion:^{
//        
//    }];
    
    
    
    /**
     *  此处不用考虑循环引用
     */
//    [self presentViewController:self.last animated:YES completion:^{}];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)blockTest1:(void(^)(NSInteger index))block
{
    if (block) {
        block(5);
    }
}


- (void)dealloc
{
    NSLog(@"NextViewController --- dealloc");
}

@end
