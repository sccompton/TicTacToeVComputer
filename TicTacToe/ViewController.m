//
//  ViewController.m
//  TicTacToe
//
//  Created by Stephen Compton on 1/10/14.
//  Copyright (c) 2014 Stephen Compton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    __weak IBOutlet UILabel *myLabelOne;
    __weak IBOutlet UILabel *myLabelTwo;
    __weak IBOutlet UILabel *myLabelThree;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelNine;
    
    __weak IBOutlet UILabel *whichPlayerLabel;
    __weak IBOutlet UILabel *timerLabel;
    
    __weak IBOutlet UILabel *xDragger;
    __weak IBOutlet UILabel *oDragger;
    
    __weak IBOutlet UIButton *helpButton;
    
    CGAffineTransform xDraggerTransform;
    CGAffineTransform oDraggerTransform;
    
    float countDown;
    NSTimer *timer;
    BOOL firstPlayer;
    BOOL gameOver;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    xDraggerTransform = xDragger.transform;
    oDraggerTransform = oDragger.transform;
    firstPlayer = YES;
    whichPlayerLabel.text = @"Human";
    gameOver = NO;
    countDown = 10.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(showTimer:)
                                           userInfo:nil repeats:YES];
}



-(IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRecognizer{
    if (!gameOver) {
        if ((CGRectContainsPoint(xDragger.frame, [panGestureRecognizer locationInView:self.view])) && (xDragger.hidden == NO)) {
            CGPoint point = [panGestureRecognizer translationInView:self.view];
            xDragger.transform = CGAffineTransformMakeTranslation(point.x, point.y);
            
            point.x += xDragger.center.x;
            point.y += xDragger.center.y;
            NSLog(@"Dragging");
            
            UILabel *draggedLabel = [self findLabelUsingPoint:point];
            if ((panGestureRecognizer.state == UIGestureRecognizerStateEnded) && (CGRectContainsPoint(draggedLabel.frame, point))) {
                if ([draggedLabel.text isEqualToString:@""]) {
                    [UIView animateWithDuration:0.5 animations:^{
                        xDragger.transform = xDraggerTransform;
                        [self onLabelPlayed:point];
                    }];
                }
                else {
                    NSLog(@"xDraggerTransform");
                    xDragger.transform = xDraggerTransform;
                }
                
            }
        }
    }
}


-(void)onLabelPlayed:(CGPoint)point {
    if (!gameOver) {
        if (firstPlayer) {
            NSLog(firstPlayer ? @"On Label Played Yes" : @"On Label Played No");
            xDragger.hidden = !(xDragger.hidden);
            oDragger.hidden = !(oDragger.hidden);
            whichPlayerLabel.text = @"Computer";
            UILabel *playedLabel = [self findLabelUsingPoint:point];
            
            if ([playedLabel.text length] == 0) {
                if (firstPlayer) {
                    playedLabel.textColor = [UIColor yellowColor];
                    playedLabel.text = @"X";
                    firstPlayer = !(firstPlayer);
                }
            }
            
            if ([[self whoOne]  isEqual:@"X"]) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Human Wins!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                gameOver = YES;
                [alert show];
                NSLog(@"win alert onHuman");
            } else if ([[self whoOne]  isEqual:@"Draw"]) {
                NSLog(@"player draw alert");
                firstPlayer = !(firstPlayer);
                xDragger.hidden = !(xDragger.hidden);
                oDragger.hidden = !(oDragger.hidden);
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Draw!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                gameOver = YES;
                [alert show];
            }
            
            
            [timer invalidate];
            countDown = 1.0;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                     target:self
                                                   selector:@selector(showTimer:)
                                                   userInfo:nil repeats:YES];
        } else {
            xDragger.hidden = !(xDragger.hidden);
            oDragger.hidden = !(oDragger.hidden);
            [self onComputerPlayed];
        }

    }
}

-(void)onComputerPlayed{
    if (!gameOver) {
        UILabel *computerSelectedLabel;
        whichPlayerLabel.text = @"Human";
        BOOL foundEmpty = NO;
        
        if (!(firstPlayer)) {
            NSLog(firstPlayer ? @"On Computer Played Yes" : @"On Computer Played No");
            if ([self findMove] != nil) {
                computerSelectedLabel = [self findMove];
                computerSelectedLabel.textColor = [UIColor redColor];
                computerSelectedLabel.text = @"O";
                firstPlayer = !(firstPlayer);
                
                if ([[self whoOne] isEqualToString:@"O"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Computer Wins!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                    gameOver = YES;
                    [alert show];
                    NSLog(@"win alert on computer found move");
                } else if ([[self whoOne]  isEqual:@"Draw"]) {
                    NSLog(@"computer found move draw alert");
                    firstPlayer = !(firstPlayer);
                    xDragger.hidden = !(xDragger.hidden);
                    oDragger.hidden = !(oDragger.hidden);
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Draw!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                    gameOver = YES;
                    [alert show];
                }
                
                [timer invalidate];
                countDown = 10.0;
                timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                         target:self
                                                       selector:@selector(showTimer:)
                                                       userInfo:nil repeats:YES];
            } else {
                while (foundEmpty == NO) {
                    int random = (arc4random() % 9) + 1;
                    switch (random) {
                        case 1:
                            computerSelectedLabel = myLabelOne;
                            break;
                        case 2:
                            computerSelectedLabel = myLabelTwo;
                            break;
                        case 3:
                            computerSelectedLabel = myLabelThree;
                            break;
                        case 4:
                            computerSelectedLabel = myLabelFour;
                            break;
                        case 5:
                            computerSelectedLabel = myLabelFive;
                            break;
                        case 6:
                            computerSelectedLabel = myLabelSix;
                            break;
                        case 7:
                            computerSelectedLabel = myLabelSeven;
                            break;
                        case 8:
                            computerSelectedLabel = myLabelEight;
                            break;
                        case 9:
                            computerSelectedLabel = myLabelNine;
                            break;
                    }
                    if ([computerSelectedLabel.text isEqualToString:@""]) {
                        foundEmpty = YES;
                    }
                }
                computerSelectedLabel.textColor = [UIColor redColor];
                computerSelectedLabel.text = @"O";
                firstPlayer = !(firstPlayer);
                if ([[self whoOne] isEqualToString:@"O"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Computer Wins!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                    gameOver = YES;
                    [alert show];
                    NSLog(@"win alert on computer random");
                } else if ([[self whoOne]  isEqual:@"Draw"]) {
                    NSLog(@"computer random move draw alert");
                    firstPlayer = !(firstPlayer);
                    xDragger.hidden = !(xDragger.hidden);
                    oDragger.hidden = !(oDragger.hidden);
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Draw!" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
                    gameOver = YES;
                    [alert show];
                }
                
                [timer invalidate];
                countDown = 10.0;
                timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                         target:self selector:@selector(showTimer:) userInfo:nil repeats:YES];
            }
        }

    }
}

-(UILabel *)findMove{
    if (!gameOver) {
        if ([self determineBlockOrWin:myLabelOne withSecondLabel:myLabelTwo withThirdLabel:myLabelThree] != nil) {
            return [self determineBlockOrWin:myLabelOne withSecondLabel:myLabelTwo withThirdLabel:myLabelThree];
        } else if ([self determineBlockOrWin:myLabelFour withSecondLabel:myLabelFive withThirdLabel:myLabelSix] != nil) {
            return [self determineBlockOrWin:myLabelFour withSecondLabel:myLabelFive withThirdLabel:myLabelSix];
        } else if ([self determineBlockOrWin:myLabelSeven withSecondLabel:myLabelEight withThirdLabel:myLabelNine] != nil) {
            return [self determineBlockOrWin:myLabelSeven withSecondLabel:myLabelEight withThirdLabel:myLabelNine];
        } else if ([self determineBlockOrWin:myLabelOne withSecondLabel:myLabelFour withThirdLabel:myLabelSeven] != nil) {
            return [self determineBlockOrWin:myLabelOne withSecondLabel:myLabelFour withThirdLabel:myLabelSeven];
        } else if ([self determineBlockOrWin:myLabelTwo withSecondLabel:myLabelFive withThirdLabel:myLabelEight] != nil) {
            return [self determineBlockOrWin:myLabelTwo withSecondLabel:myLabelFive withThirdLabel:myLabelEight];
        } else if ([self determineBlockOrWin:myLabelThree withSecondLabel:myLabelSix withThirdLabel:myLabelNine] != nil) {
            return [self determineBlockOrWin:myLabelThree withSecondLabel:myLabelSix withThirdLabel:myLabelNine];
        } else if ([self determineBlockOrWin:myLabelOne withSecondLabel:myLabelFive withThirdLabel:myLabelNine] != nil) {
            return [self determineBlockOrWin:myLabelOne withSecondLabel:myLabelFive withThirdLabel:myLabelNine];
        } else if ([self determineBlockOrWin:myLabelThree withSecondLabel:myLabelFive withThirdLabel:myLabelSeven] != nil) {
            return [self determineBlockOrWin:myLabelThree withSecondLabel:myLabelFive withThirdLabel:myLabelSeven];
        } else {
            return nil;
        }
    }
    return nil;
}

-(UILabel *)determineBlockOrWin:(UILabel *)firstLabel withSecondLabel:(UILabel *)secondLabel withThirdLabel:(UILabel *)thirdLabel{
    if (!gameOver) {
        int xCounter = 0;
        int oCounter = 0;
        UILabel *blankLabel = nil;
        
        if ([firstLabel.text isEqualToString:@"X"]) {
            xCounter++;
        } else if ([firstLabel.text isEqualToString:@"O"]) {
            oCounter++;
        } else {
            blankLabel = firstLabel;
        }
        if ([secondLabel.text isEqualToString:@"X"]) {
            xCounter++;
        } else if ([secondLabel.text isEqualToString:@"O"]) {
            oCounter++;
        } else {
            blankLabel = secondLabel;
        }
        if ([thirdLabel.text isEqualToString:@"X"]) {
            xCounter++;
        } else if ([thirdLabel.text isEqualToString:@"O"]) {
            oCounter++;
        } else {
            blankLabel = thirdLabel;
        }
        if ( ((xCounter == 2) && (oCounter == 0)) || ((oCounter == 2) && (xCounter ==0)) ) {
                NSLog(@"blanklabel");
                return blankLabel;
        } else {
            return nil;
        }
    }
    return nil;
}

-(void)showTimer:(NSTimer *)countdownTimer{
    if (!gameOver) {
        if ((countDown > 0.1)) {
            countDown -= 0.1;
            timerLabel.text = [NSString stringWithFormat:@"%.1f", countDown];
        } else {
            CGPoint nilPoint = CGPointMake(0, 0);
            [self onLabelPlayed:nilPoint];
            NSLog(@"NilPont");
        }
    }
}

-(NSString *)whoOne {
    if (!gameOver) {
        if (([myLabelOne.text isEqualToString:myLabelTwo.text]) && ([myLabelTwo.text isEqualToString:myLabelThree.text]) && ([myLabelOne.text length] == 1)) {
            if ([myLabelOne.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelFour.text isEqualToString:myLabelFive.text]) && ([myLabelFive.text isEqualToString:myLabelSix.text]) && ([myLabelFour.text length] == 1)) {
            if ([myLabelFour.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelSeven.text isEqualToString:myLabelEight.text]) && ([myLabelEight.text isEqualToString:myLabelNine.text]) && ([myLabelSeven.text length] == 1)) {
            if ([myLabelSeven.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelOne.text isEqualToString:myLabelFour.text]) && ([myLabelFour.text isEqualToString:myLabelSeven.text]) && ([myLabelOne.text length]  == 1)) {
            if ([myLabelOne.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelTwo.text isEqualToString:myLabelFive.text]) && ([myLabelFive.text isEqualToString:myLabelEight.text]) && ([myLabelTwo.text length] == 1)) {
            if ([myLabelTwo.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelThree.text isEqualToString:myLabelSix.text]) && ([myLabelSix.text isEqualToString:myLabelNine.text]) && ([myLabelThree.text length] == 1)) {
            if ([myLabelThree.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelOne.text isEqualToString:myLabelFive.text]) && ([myLabelFive.text isEqualToString:myLabelNine.text]) && ([myLabelOne.text length] == 1)) {
            if ([myLabelOne.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else if (([myLabelThree.text isEqualToString:myLabelFive.text]) && ([myLabelFive.text isEqualToString:myLabelSeven.text]) && ([myLabelThree.text length] == 1)) {
            if ([myLabelThree.text isEqualToString:@"X"]) {
                return @"X";
            } else if ([myLabelOne.text isEqualToString:@"O"]) {
                return @"O";
            }
        } else {
            if ( (myLabelOne.text.length > 0) && (myLabelTwo.text.length > 0) && (myLabelThree.text.length > 0) && (myLabelFour.text.length > 0) && (myLabelFive.text.length > 0) && (myLabelSix.text.length > 0) && (myLabelSeven.text.length > 0) && (myLabelEight.text.length > 0) && (myLabelNine.text.length > 0) ) {
                NSLog(@"Draw Calling");
                return @"Draw";
            }
            return nil;
        }
    }
    return nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    gameOver = NO;
    if (buttonIndex == [alertView cancelButtonIndex]) {
        myLabelOne.text = @"";
        myLabelTwo.text = @"";
        myLabelThree.text = @"";
        myLabelFour.text = @"";
        myLabelFive.text = @"";
        myLabelSix.text = @"";
        myLabelSeven.text = @"";
        myLabelEight.text = @"";
        myLabelNine.text = @"";
        countDown = 10.0;
        
        if (firstPlayer) {
            whichPlayerLabel.text = @"Computer";

        } else {
            whichPlayerLabel.text = @"Human";
        }
    }
    else {
        NSLog(@"alternate alert");
    }
}

-(UILabel *)findLabelUsingPoint:(CGPoint) point{
    if (!gameOver) {
        if (CGRectContainsPoint(myLabelOne.frame, point)) {
            return myLabelOne;
        }
        if (CGRectContainsPoint(myLabelTwo.frame, point)) {
            return myLabelTwo;
        }
        if (CGRectContainsPoint(myLabelThree.frame, point)) {
            return myLabelThree;
        }
        if (CGRectContainsPoint(myLabelFour.frame, point)) {
            return myLabelFour;
        }
        if (CGRectContainsPoint(myLabelFive.frame, point)) {
            return myLabelFive;
        }
        if (CGRectContainsPoint(myLabelSix.frame, point)) {
            return myLabelSix;
        }
        if (CGRectContainsPoint(myLabelSeven.frame, point)) {
            return myLabelSeven;
        }
        if (CGRectContainsPoint(myLabelEight.frame, point)) {
            return myLabelEight;
        }
        if (CGRectContainsPoint(myLabelNine.frame, point)) {
            return myLabelNine;
        }
        return nil;
    }
    return nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
