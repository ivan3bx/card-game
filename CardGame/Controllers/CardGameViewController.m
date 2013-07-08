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
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

-(void)setCount:(NSUInteger)count
{
    _count = count;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", count];
}

-(Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    for (UIButton *cardButton in cardButtons) {
        Card *c = [self.deck drawRandomCard];
        [cardButton setTitle:c.contents forState:UIControlStateSelected];
    }
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.count++;
}


@end
