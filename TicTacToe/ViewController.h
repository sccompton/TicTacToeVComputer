//
//  ViewController.h
//  TicTacToe
//
//  Created by Stephen Compton on 1/10/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

-(void)onLabelPlayed:(CGPoint)point;
-(NSString *)whoOne;
-(UILabel *)findLabelUsingPoint:(CGPoint) point;
-(void)showTimer:(NSTimer *)timer;

@end
