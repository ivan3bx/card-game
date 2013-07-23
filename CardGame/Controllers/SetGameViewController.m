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
        
        // Set UIButton text
        [cardButton setAttributedTitle:[self descriptionForCard:card] forState:UIControlStateNormal];
        
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
    
    // Set score label contents
    self.scoreLabel.text = [self descriptionForScore:self.game.score];
    
    // Set last results
    self.results.attributedText = [self descriptionForMatching:self.game.lastMatchedCards withScore:self.game.lastScoreAdjustment];
}

-(NSString *)descriptionForScore:(int)score
{
    return [NSString stringWithFormat:@"Score: %d", score];
}

-(NSAttributedString *)descriptionForMatching:(NSArray *)cards withScore:(int)score
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (score == 0) {
        // We didn't adjust any score
        NSString *resultString = [NSString stringWithFormat:@"Flipped up %@", ((SetCard *)cards.lastObject).contents];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:resultString]];
    } else if (score > 0) {
        // There was a match
        NSString *resultString = [NSString stringWithFormat:@"Matched %@ for %d points", [cards componentsJoinedByString:@" and "], score];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:resultString]];
    } else {
        // Negative score means no match (with a penalty)
        NSString *resultString = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [cards componentsJoinedByString:@" and "], score];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:resultString]];
    }
    return result;
}

-(NSAttributedString *)descriptionForCard:(SetCard *)card
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] init];
    
    // Set the text
    [title setAttributedString:[[NSAttributedString alloc] initWithString:card.contents]];
    
    // Set color & shading
    [title addAttribute:NSForegroundColorAttributeName
                  value:[card.color colorWithAlphaComponent:card.shade]
                  range:NSMakeRange(0, title.length)];
    
    // Set font size
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, title.length)];
    return title;
}

@end
