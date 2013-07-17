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
            NSArray *playableCards     = [self selectPlayableCards];
            scoreAdjustment            = [self calculateScoreFor:card using:playableCards];
            scoreAdjustmentDescription = [self descriptionForMatching:[playableCards arrayByAddingObject:card] withScore:scoreAdjustment];
            
            // Always subtract a flip cost
            scoreAdjustment -= FLIP_COST;
        }
        
        self.lastResult = scoreAdjustmentDescription;
        self.score += scoreAdjustment;
        card.faceUp = !card.faceUp;
    }
}

-(NSString *)descriptionForMatching:(NSArray *)cards withScore:(int)score
{
    if (score == 0) {
        // We didn't adjust any score
        return [NSString stringWithFormat:@"Flipped up %@", ((Card *)cards.lastObject).contents];
    } else if (score > 0) {
        // There was a match
        return [self descriptionForMatchOf:cards withScore:score];
    } else {
        // Negative score means no match (with a penalty)
        return [self descriptionForPenaltyOf:cards withScore:score];
    }
    
}

-(NSString *)descriptionForMatchOf:(NSArray *)cards withScore:(int)score
{
    return [NSString stringWithFormat:@"Matched %@ for %d points", [cards componentsJoinedByString:@" and "], score];
}

-(NSString *)descriptionForPenaltyOf:(NSArray *)cards withScore:(int)score
{
    return [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [cards componentsJoinedByString:@" and "], score];
}

-(NSArray *)selectPlayableCards
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
            [results addObject:otherCard];
        }
    }
    return results;
}

-(int)calculateScoreFor:(Card *)card using:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count) {
        int matchScore = [card match:otherCards];
        
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
