//
//  CardGameViewController.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/2/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!super.game) {
        [super initializeCardMatchingGameWithDeck:[[PlayingCardDeck alloc] init]
                               checkingForMatchAt:2];
    }
    return super.game;
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        if (card.isFaceUp) {
            cardButton.selected = YES;
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            cardButton.selected = NO;
            [cardButton setImage:[UIImage imageNamed:@"lur_futurama.png"] forState:UIControlStateNormal];
        }
        
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.results.text = [self descriptionForMatching:self.game.lastMatchedCards
                                           withScore:self.game.lastScoreAdjustment];
}

-(NSString *)descriptionForMatching:(NSArray *)cards withScore:(int)score
{
    if (score == 0) {
        // We didn't adjust any score
        return [NSString stringWithFormat:@"Flipped up %@", ((Card *)cards.lastObject).contents];
    } else if (score > 0) {
        // There was a match
        return [NSString stringWithFormat:@"Matched %@ for %d points", [cards componentsJoinedByString:@" and "], score];
    } else {
        // Negative score means no match (with a penalty)
        return [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [cards componentsJoinedByString:@" and "], score];
    }
}

@end
