//
//  Deck.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/4/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

-(int) count;

@end
