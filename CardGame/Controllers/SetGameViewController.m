//
//  SetGameViewController.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/16/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (nonatomic) NSUInteger count;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *results;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetGameViewController


-(void)setCount:(NSUInteger)count
{
    _count = count;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", count];
}

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[SetCardDeck alloc] init]
                                             matchingNumber:3];
    }
    return _game;
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        
        [self setTitleFor:cardButton with:card onState:UIControlStateSelected];
        [self setTitleFor:cardButton with:card onState:(UIControlStateSelected|UIControlStateDisabled)];
        
        if (card.isFaceUp) {
            cardButton.selected = YES;
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            cardButton.selected = NO;
            [cardButton setImage:[UIImage imageNamed:@"lur_futurama.png"] forState:UIControlStateNormal];
        }
        
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.2 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(void)setTitleFor:(UIButton *)cardButton with:(SetCard *)card onState:(UIControlState)state
{
    NSMutableAttributedString *title;
    title = [[NSMutableAttributedString alloc] initWithAttributedString:[cardButton attributedTitleForState:state]];
    if (!title.length) {
        [title appendAttributedString:[[NSAttributedString alloc] initWithString:card.contents]];
    }
    
    // Set color & shading
    [title addAttribute:NSForegroundColorAttributeName
                  value:[card.color colorWithAlphaComponent:card.shade]
                  range:NSMakeRange(0, title.length)];
    
    // Set font size
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, title.length)];
    [cardButton setAttributedTitle:title forState:state];
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (IBAction)deal
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.count++;
    [self updateUI];
}

@end
