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

@implementation SetGameViewController


-(CardMatchingGame *)game
{
    if (!super.game) {
        [super initializeCardMatchingGameWithDeck:[[SetCardDeck alloc] init]
                               checkingForMatchAt:3];
    }
    return super.game;
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        [self setTitleFor:cardButton with:card onState:UIControlStateNormal];
        
        if (card.isFaceUp) {
            cardButton.selected = YES;
            [cardButton setBackgroundColor:[UIColor colorWithWhite:0.92 alpha:1.0]];
        } else {
            cardButton.selected = NO;
            [cardButton setBackgroundColor:[UIColor clearColor]];
        }
        
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.2 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(void)setTitleFor:(UIButton *)cardButton with:(SetCard *)card onState:(UIControlState)state
{
    NSAttributedString *buttonString = [cardButton attributedTitleForState:state];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithAttributedString:buttonString];
    
    // Set the text
    [title setAttributedString:[[NSAttributedString alloc] initWithString:card.contents]];
    
    // Set color & shading
    [title addAttribute:NSForegroundColorAttributeName
                  value:[card.color colorWithAlphaComponent:card.shade]
                  range:NSMakeRange(0, title.length)];
    
    // Set font size
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, title.length)];
    [cardButton setAttributedTitle:title forState:state];
}

@end
