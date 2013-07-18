//
//  GameViewController.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/18/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "AbstractGameViewController.h"
#import "CardMatchingGame.h"

@interface AbstractGameViewController()
@property (nonatomic) NSUInteger count;
@end

@implementation AbstractGameViewController

-(void)initializeCardMatchingGameWithDeck:(Deck *)deck checkingForMatchAt:(int)numberOfCards
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:deck
                                             matchingNumber:numberOfCards];
}

-(void)setCount:(NSUInteger)count
{
    _count = count;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", count];
}

#pragma mark -
#pragma mark Methods that invoke [self updateUI]
#pragma mark -

- (IBAction)deal
{
    self.game = nil;
    self.count = 0;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.count++;
    [self updateUI];
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

#pragma mark -
#pragma mark To be subclassed
#pragma mark -
- (void)updateUI
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method"];
}

@end
