//
//  MenuViewController.m
//  Saper
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
#import "InitGame.h"
#import "GameData.h"

@interface MenuViewController ()
@property(nonatomic, strong)UIButton *easyButton;
@end

@implementation MenuViewController

-(void)openEasyGame:(id)sender
{
    InitGame *iGame = [[InitGame alloc]initWithHightWaightAndBombs:8 :8 :10];
    
    ViewController *easyField = [[ViewController alloc]initWithInitGame:iGame];
    [self.navigationController pushViewController:easyField animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MENU";
    self.easyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.easyButton setTitle:@"Легко!" forState:UIControlStateNormal];
    [self.easyButton sizeToFit];
    self.easyButton.backgroundColor = [UIColor whiteColor];
    self.easyButton.center = self.view.center;
    [self.easyButton addTarget:self action:@selector(openEasyGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.easyButton];
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
