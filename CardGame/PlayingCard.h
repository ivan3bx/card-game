//
//  PlayingCard.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/4/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
