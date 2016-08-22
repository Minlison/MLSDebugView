//
//  ViewController.m
//  MLSLogger
//
//  Created by MinLison on 16/8/18.
//  Copyright © 2016年 MinLison. All rights reserved.
//
#define USE_MLSLOG
#import "ViewController.h"
#import "MLSDebugManager.h"

@interface ViewController ()
@property (strong, nonatomic) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)testBtn:(id)sender
{
        for (int i = 0; i < 100; i++)
        {
                NSLog(@"我在主线程中%d",i);
        }
        
        dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_SERIAL);
        self.queue = queue;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                for (int i = 0; i < 100; i++)
                {
                        dispatch_async(queue, ^{
                                
                                NSLog(@"我在异步串行队列中---%d",i);
                                usleep(100);
                        });
                        NSLog(@"我在异步并发队列中-----%d",i);
                }
        });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
        
}

@end
