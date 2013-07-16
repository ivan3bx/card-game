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
@property (nonatomic, readwrite) NSString *lastResult;
@property (nonatomic, readwrite) NSUInteger numberOfCardsToMatch;
@end

@implementation CardMatchingGame

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
        matchingNumber:(NSUInteger)numberOfCardsToMatch
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
        self.numberOfCardsToMatch = numberOfCardsToMatch;
    }
    return self;
}

-(NSUInteger)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) {
        _numberOfCardsToMatch = 2;
    }
    return _numberOfCardsToMatch;
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
    int scoreAdjustment = 0;
    
    self.lastResult = @"";
    
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
                        scoreAdjustment = matchScore * MATCH_BONUS;
                        self.lastResult = [NSString stringWithFormat:@"Matched %@ and %@ for %d points", card.contents, otherCard.contents, scoreAdjustment];
                    } else {
                        //
                        // No match!
                        //
                        otherCard.faceUp = NO;
                        scoreAdjustment -= MISMATCH_PENALTY;
                        self.lastResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, scoreAdjustment];
                    }
                }
            }
            
            if (scoreAdjustment == 0) {
                // We didn't adjust any score, so there were no matches/mismatches
                self.lastResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            }
            scoreAdjustment -= FLIP_COST;
        }
        
        self.score += scoreAdjustment;
        card.faceUp = !card.faceUp;
    }
}

@end
