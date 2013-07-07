//
//  CardGameViewController.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/2/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (nonatomic) NSUInteger count;
@property (weak, nonatomic) IBOutlet UILabel *flipCount;
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation CardGameViewController

-(void)setCount:(NSUInteger)count
{
    _count = count;
    self.flipCount.text = [NSString stringWithFormat:@"Flips: %d", count];
}

-(PlayingCardDeck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = YES;
    Card *nextCard = [self.deck drawRandomCard];
    [sender setTitle:[nextCard contents] forState:UIControlStateSelected];
    sender.titleLabel.text = [nextCard contents];
    self.count++;
}


@end
