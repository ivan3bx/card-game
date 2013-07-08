//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/7/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "CardMatchingGame.h"

#define FLIP_COST        1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS      4

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation CardMatchingGame

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

-(NSMutableArray*)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(Card*)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = self.cards[index];
    if (!card.isUnPlayable) {
        //
        // Card is playable!
        //
        if (!card.isFaceUp) {
            //
            // Card is transitioning to 'faceup', and might match!
            //
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        //
                        // It's a match, so both cards become unplayable
                        //
                        otherCard.unPlayable = YES;
                        card.unPlayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        //
                        // No match!
                        //
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

@end
