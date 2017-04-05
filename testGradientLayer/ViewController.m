//
//  ViewController.m
//  testGradientLayer
//
//  Created by Evan on 2017/3/15.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "ViewController.h"
#import "VKGradientBarView.h"
#import "VKPathView.h"
@interface ViewController ()

@property (nonatomic, strong) VKGradientBarView *barView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barView = [[VKGradientBarView alloc] initWithFrame:CGRectMake(0, 100,CGRectGetMaxX(self.view.bounds),180)];
    self.barView.values = @[@"0", @"0", @"0", @"20", @"0",@"5",@"0"];
    self.barView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.barView];

}


- (IBAction)thisWeek:(id)sender {
    if(self.barView){
        [self.barView removeFromSuperview];
        self.barView = nil;
    }
    [self.view addSubview:self.barView];
    self.barView.values = @[@"0", @"10", @"0", @"20", @"0",@"0",@"0"];
}

- (IBAction)lastWeek:(id)sender {
    if(self.barView){
        [self.barView removeFromSuperview];
        self.barView = nil;

    }
    self.barView.values = @[@"0", @"10", @"0", @"20", @"0",@"5",@"20"];
    [self.view addSubview:self.barView];

}

- (VKGradientBarView *)barView {
    if(!_barView){
        _barView = [[VKGradientBarView alloc] initWithFrame:CGRectMake(0, 100,CGRectGetMaxX(self.view.bounds),180)];
        _barView.backgroundColor = [UIColor whiteColor];
    }
    return _barView;
}

@end
