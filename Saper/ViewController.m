//
//  ViewController.m
//  Saper
//
//  Created by Admin on 21.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"
#import "ButtonData.h"
#import "GameData.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)GameData *gameData;
@property(nonatomic, strong)InitGame *iGame;

@end

@implementation ViewController

-(instancetype)initWithInitGame:(InitGame *)iGame
{
    self = [super init];
    if(self)
    {
        self.iGame = iGame;
    }
    return self;
}

-(void)touchButton:(NSInteger)i
{
    ButtonData *butData =self.gameData.arrayButtonState[i-1];
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *but = (UIButton *)view;
            if(but.tag == i)
            {
                if(!butData.isFlag)
                {
                    but.backgroundColor = [UIColor grayColor];
                    
                    [but setTitle:butData.buttonState forState:UIControlStateNormal];
                    butData.touched = true;
                }
                
            }
        }
    }
}



-(void)openButton:(NSInteger)i
{
    ButtonData *butData = self.gameData.arrayButtonState[i];
    if(![butData.buttonState isEqualToString:@"M"])
    {
        [self touchButton:i];
    }
}

-(void)prov{
    int res = 0;
    for (ButtonData *bData in self.gameData.arrayButtonState) {
        if(bData.isFlag && [bData.buttonState isEqualToString:@"M"])
        {
            res++;
        }
    }
    if(res == 10)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"You Win!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    
    UIButton *but = (UIButton *)sender.view;
    ButtonData *butData =self.gameData.arrayButtonState[but.tag-1];
    if(butData)
    {
        if(!butData.isTouched)
        {
            if(butData.isFlag)
            {
                [but setTitle:@"" forState:UIControlStateNormal];
                butData.flag = false;
            }
            else
            {
                [but setTitle:@"F" forState:UIControlStateNormal];
                butData.flag = true;
                [self prov];
            }
        }
        else
        {
            NSInteger number = (NSInteger)butData.buttonState; ////неверно конвертируется стринг в инт
            int sch = 0;
            for(int i = -1; i<2; i++)
            {
                for(int j = -1; j< 2; j++)
                {
                    if(!(i % 8) && j == -1)
                        continue;
                    if(!((i+1)%8) && j == 1)
                    {
                        continue;
                    }
                    int k = (int)but.tag + i+8 + j;
                    ButtonData *bData = self.gameData.arrayButtonState[k];
                    if([bData.buttonState isEqualToString:@"M"] && bData.isFlag)
                    {
                        sch++;
                    }
                }
            }
            if(sch == number)
            {
                for(int i = -1; i<2; i++)
                {
                    for(int j = -1; j< 2; j++)
                    {
                        if(!(i % 8) && j == -1)
                            continue;
                        if(!((i+1)%8) && j == 1)
                        {
                            continue;
                        }
                        int k = (int)but.tag + i+8 + j;
                        ButtonData *bData = self.gameData.arrayButtonState[k];
                        if(![bData.buttonState isEqualToString:@"M"] && !bData.isTouched)
                        {
                            [self touchButton:k];
                        }
                    }
                }
            }
        }
    }
    
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    UIButton *but = (UIButton *)sender.view;
    ButtonData *butData =self.gameData.arrayButtonState[but.tag-1];
    if(butData)
    {
        if(!butData.isTouched)
        {
            if( [butData.buttonState isEqualToString:@"M"] && !butData.isFlag)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"You Lose" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            if([butData.buttonState isEqualToString:@""])
            {
                [self.gameData openAllVoidField:but.tag-1];
                int i = 1;
                for (ButtonData *bData in self.gameData.arrayButtonState) {
                    if(bData.isTouched)
                    {
                        [self touchButton:i];
                    }
                    i++;
                }
            }
            [self touchButton:but.tag];
        }
    }
}

-(void)addButtons
{
    UIButton *but;
    self.view.backgroundColor = [UIColor whiteColor];
    /*but = [UIButton buttonWithType:UIButtonTypeSystem];
    [but sizeToFit];
    but.backgroundColor = [UIColor redColor];
    but.titleLabel.text = @"strdy";
    but.center = self.view.center;
    [self.view addSubview:but];*/
    
    CGFloat y = 70.0f;
    int k= 1;
    for(int i = 0; i<self.iGame.widthField; i++)
    {
        CGFloat x = -48.0f;
        for(int j = 0; j<self.iGame.heightField; j++)
        {
            CGRect rect = CGRectMake(x, y, 50.0f, 50.0f);
            UITapGestureRecognizer *doubleTap;
            UITapGestureRecognizer *singleTap;
            doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
            doubleTap.numberOfTapsRequired = 2;
            //doubleTap.delegate = self;
            
            singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
            singleTap.numberOfTapsRequired = 1;
            //singleTap.delegate = self;
            singleTap.delaysTouchesEnded = YES;
            [singleTap requireGestureRecognizerToFail:doubleTap];
            
            but = [[UIButton alloc]initWithFrame:rect];
            x+=50.0f;
            but.backgroundColor = [UIColor lightGrayColor];
            
            but.bounds = rect;
            
            but.center = CGPointMake(25.0f + x, 25.0f + y);
            but.tag = k;
            k++;
            
            [but addGestureRecognizer:doubleTap];
            [but addGestureRecognizer:singleTap];
            
            [self.view addSubview:but];
            
        }
        y+=50.0f;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Game";
    self.gameData = [[GameData alloc] initWithIGame:self.iGame];
    [self.gameData randomInitArrayButtonState];
    
    [self addButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
