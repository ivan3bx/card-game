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
    NSString *scoreAdjustmentDescription = @"";
    
    if (!card.isUnPlayable) {
        //
        // Card is playable!
        //
        if (!card.isFaceUp) {
            // Card is transitioning to 'faceup', and might match!
            NSSet *playableCards       = [self selectPlayableCards];
            scoreAdjustment            = [self calculateScoreFor:card using:playableCards];
            scoreAdjustmentDescription = [self descriptionForMatching:card to:playableCards withScore:scoreAdjustment];
            
            // Always subtract a flip cost
            scoreAdjustment -= FLIP_COST;
        }
        
        self.lastResult = scoreAdjustmentDescription;
        self.score += scoreAdjustment;
        card.faceUp = !card.faceUp;
    }
}

-(NSString *)descriptionForMatching:(Card *)card to:(NSSet *)playableCards withScore:(int)score
{
    if (score == 0) {
        // We didn't adjust any score
        return [NSString stringWithFormat:@"Flipped up %@", card.contents];
    } else if (score > 0) {
        // There was a match
        return [self descriptionForMatchOf:card to:playableCards withScore:score];
    } else {
        // Negative score means no match (with a penalty)
        return [self descriptionForPenaltyOf:card to:playableCards withScore:score];
    }
    
}

-(NSString *)descriptionForMatchOf:(Card *)card to:(NSSet *)otherCards withScore:(int)score
{
    if (otherCards.count == 1) {
        Card *otherCard = otherCards.anyObject;
        return [NSString stringWithFormat:@"Matched %@ and %@ for %d points", card.contents, otherCard.contents, score];
    } else {
        // TODO: handle output for case of > 1 card matches..
        return @"no description for multi-card match";
    }
}

-(NSString *)descriptionForPenaltyOf:(Card *)card to:(NSSet *)otherCards withScore:(int)score
{
    if (otherCards.count == 1) {
        Card *otherCard = otherCards.anyObject;
        return [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, score];
    } else {
        // TODO: handle output for case of > 1 card matches..
        return @"no description for multi-card match";
    }
}

-(NSSet *)selectPlayableCards
{
    NSMutableSet *results = [[NSMutableSet alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
            [results addObject:otherCard];
        }
    }
    return results;
}

-(int)calculateScoreFor:(Card *)card using:(NSSet *)otherCards
{
    int score = 0;
    if (otherCards.count) {
        int matchScore = [card match:otherCards.allObjects];
        
        // Set cards to be unplayable if there's been a match
        for (Card *otherCard in otherCards) {
            otherCard.unPlayable = (matchScore != 0);
            otherCard.faceUp = (matchScore != 0);
        }
        
        // Set this card to be unplayable if there's been a match
        card.unPlayable = (matchScore != 0);

        if (matchScore) {
            score = matchScore * MATCH_BONUS;
        } else {
            score -= MISMATCH_PENALTY;
        }
    }
    return score;
}

@end
