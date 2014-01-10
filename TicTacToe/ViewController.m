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
    BOOL firstPlayer;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstPlayer = YES;
    whichPlayerLabel.text = @"Player 1";
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer{
    CGPoint point = [tapGestureRecognizer locationInView:self.view];
    
    UILabel *tappedLabel = [self findLabelUsingPoint:point];
    
    if ([tappedLabel.text length] == 0) {
        if (firstPlayer) {
            tappedLabel.textColor = [UIColor blueColor];
            tappedLabel.text = @"X";
        } else {
            tappedLabel.textColor = [UIColor redColor];
            tappedLabel.text = @"O";
        }
    }

    if ([[self whoOne]  isEqual:@"X"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Player 1 Wins" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
        [alert show];
    }
    if ([[self whoOne] isEqual:@"O"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Player 2 Wins" message:nil delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
        [alert show];
    }
    
    firstPlayer = !(firstPlayer);
 
    if (firstPlayer) {
        whichPlayerLabel.text = @"Player 1";
    } else {
        whichPlayerLabel.text = @"Player 2";
    }
}

-(NSString *)whoOne {
    
    if (([myLabelOne.text isEqual:myLabelTwo.text]) && ([myLabelTwo.text isEqual:myLabelThree.text]) && ([myLabelOne.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelFour.text isEqual:myLabelFive.text]) && ([myLabelFive.text isEqual: myLabelSix.text]) && ([myLabelFour.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelSeven.text isEqual:myLabelEight.text]) && ([myLabelEight.text isEqual:myLabelNine.text]) && ([myLabelSeven.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelOne.text isEqual:myLabelFour.text]) && ([myLabelFour.text isEqual:myLabelSeven.text]) && ([myLabelOne.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelTwo.text isEqual: myLabelFive.text]) && ([myLabelFive.text isEqual: myLabelEight.text]) && ([myLabelTwo.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelThree.text isEqual: myLabelSix.text]) && ([myLabelSix.text isEqual: myLabelNine.text]) && ([myLabelThree.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelOne.text isEqual: myLabelFive.text]) && ([myLabelFive.text isEqual: myLabelNine.text]) && ([myLabelOne.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else if (([myLabelThree.text isEqual: myLabelFive.text]) && ([myLabelFive.text isEqual: myLabelSeven.text]) && ([myLabelThree.text length] > 0)) {
        if (firstPlayer) {
            return @"X";
        } else {
            return @"O";
        }
    } else {
        return nil;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        myLabelOne.text = nil;
        myLabelTwo.text = nil;
        myLabelThree.text = nil;
        myLabelFour.text = nil;
        myLabelFive.text = nil;
        myLabelSix.text = nil;
        myLabelSeven.text = nil;
        myLabelEight.text = nil;
        myLabelNine.text = nil;
        
        firstPlayer = YES;
        whichPlayerLabel.text = @"Player 1";
    }
}

-(UILabel *)findLabelUsingPoint:(CGPoint) point{
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
