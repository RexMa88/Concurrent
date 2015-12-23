//
//  ViewController.m
//  GrandCentralDispatch
//
//  Created by Rex Ma on 15/6/16.
//  Copyright (c) 2015年 Rex Ma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self createGroup];
//    [self createAsyncQueue];
//    [self createDelay];
}

#pragma mark - dispatch_after

- (void)createDelay{
    dispatch_time_t delaytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delaytime, dispatch_get_main_queue(), ^{
        NSLog(@"Hello world");
    });
    
}

#pragma mark - dispatch_queue

- (void)createAsyncQueue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"The Background Thread");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"The Main Thread");
        });
    });
}

#pragma mark - dispatch_group

- (void)createGroup{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"The Thread One");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"The Thread Two");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"The Thread Three");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"The Thread Four");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"The Thread Five");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"The Thread Six");
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"The notify Thread");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //code
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
