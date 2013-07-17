//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/7/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

#pragma mark -
#pragma mark Initialization

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck*)deck
        matchingNumber:(NSUInteger)numberOfCardsToMatch;

#pragma mark -
#pragma mark Playing a Card

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card*)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) int score;

// The last set of cards that were used to modify the score
@property(nonatomic, readonly) NSArray *lastMatchedCards;

// The last adjustment made to the score
@property(nonatomic, readonly) int lastScoreAdjustment;

@end
