//
//  SetGameViewController.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/16/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()
@property (nonatomic) NSUInteger count;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *results;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetGameViewController

-(void)setCount:(NSUInteger)count
{
    _count = count;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", count];
}

- (IBAction)deal
{
    // Implement deal logic
}

@end
