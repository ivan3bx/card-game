//
//  Card.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/2/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong, nonatomic) NSString *contents;
@property(nonatomic, getter = isFaceUp) BOOL faceUp;
@property(nonatomic, getter = isUnPlayable) BOOL unPlayable;

/*
 * Returns whether this card matches contents in any card in the array
 * '0' == matches
 * '1' == does not match
 */
- (int)match:(NSArray *)otherCards;
@end
