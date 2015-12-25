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

@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self createGroup];
//    [self createAsyncQueue];
//    [self createDelay];
//    [self createSerialAndConcurrentTest];
    [self customButton];
//    [self dispatchApplyTest];
}

#pragma mark - Button

- (void)customButton{
    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickButton.frame = CGRectMake(0, 100, 200, 50);
    self.clickButton.backgroundColor = [UIColor redColor];
    [self.clickButton addTarget:self action:@selector(createSerialAndConcurrentTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickButton];
}

#pragma mark - dispatch_apply

- (void)dispatchApplyTest{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"The index is %zu",index);
    });
    
}

#pragma mark - dispatch_after

- (void)createDelay{
    dispatch_time_t delaytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delaytime, dispatch_get_main_queue(), ^{
        NSLog(@"Hello world");
    });
    
}

#pragma mark - (dispatch_queue_serial && dispatch_queue_concurrent) && dispatch_async && dispatch_sync)

- (void)createSerialAndConcurrentTest{
    dispatch_queue_t serialQueue = dispatch_queue_create("RexMaSerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue =dispatch_queue_create("RexMaConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
        NSThread *thread = [NSThread currentThread];
        NSLog(@"The dispatch inner is %@",isMain);
        NSLog(@"The inner thread is %@",thread);
        dispatch_async(concurrentQueue, ^{
            NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
            NSThread *thread = [NSThread currentThread];
            NSLog(@"The dispatch inner inner is %@",isMain);
            NSLog(@"The inner inner thread is %@",thread);
        });
    });
    NSString *isMain = [[NSThread currentThread] isMainThread]?@"YES":@"NO";
    NSThread *thread = [NSThread currentThread];
    NSLog(@"The dispatch outter is %@",isMain);
    NSLog(@"The outter thread is %@",thread);
//    NSLog(@"");
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
