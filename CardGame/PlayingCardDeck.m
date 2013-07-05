//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/4/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *newCard = [[PlayingCard alloc] init];
                newCard.suit = suit;
                newCard.rank = rank;
                [self addCard:newCard atTop:YES];
            }
        }
        NSLog(@"Added %d cards to deck..", [super count]);
    }
    return self;
}

@end
