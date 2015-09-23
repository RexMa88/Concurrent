//
//  ViewController.m
//  multithreading
//
//  Created by Rex Ma on 15/9/20.
//  Copyright © 2015年 Rex Ma. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    [thread start];
    
    [self GCD];
    
    [self operation];
}

- (void)GCD{
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    //串行队列
    dispatch_queue_t queueOne = dispatch_queue_create("queueOne", NULL);
    dispatch_queue_t queueTwo = dispatch_queue_create("queueTwo", DISPATCH_QUEUE_SERIAL);
    //并行队列
    dispatch_queue_t queueThree = dispatch_queue_create("queueThree", DISPATCH_QUEUE_CONCURRENT);
    //全局并行队列
    dispatch_queue_t queueGlobal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queueThree, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01-%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queueThree, ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02-%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queueGlobal, ^{
        NSLog(@"完成 - %@",[NSThread currentThread]);
    });
}

- (void)operation{
    //创建NSInvocationOperation对象
    NSInvocationOperation *operationOne = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationMethod) object:nil];
    //创建NSBlockOperation对象
    NSBlockOperation *operationTwo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"The block operation");
    }];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    NSOperationQueue *anotherQueue = [[NSOperationQueue alloc] init];
    
    [operationOne start];
    
    [operationTwo start];
}

- (void)operationMethod{
    NSLog(@"The Invocation operation");
}

- (void)run{
    NSLog(@"The Thread One");
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
