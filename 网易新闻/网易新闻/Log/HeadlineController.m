//
//  HeadlineController.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "HeadlineController.h"
#import "Headline.h"
#import "LoopView.h"
@interface HeadlineController ()

@end

@implementation HeadlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Headline headlineWithSuccess:^(NSArray *array) {
        NSLog(@"%@",array);
        LoopView *loopView = [[LoopView alloc] initWithURLs:[array valueForKey:@"imgsrc"] titles:[array valueForKey:@"title"]];
        loopView.frame = self.view.bounds;
        [self.view addSubview:loopView];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
