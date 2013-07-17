//
//  SetCardDeck.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/17/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (UIColor *color in [SetCard validColors]) {
                for (NSNumber *number in [SetCard validNumbers]) {
                    for (NSNumber *alpha in [SetCard validShades]) {
                        SetCard *newCard = [self createCardWithShape:shape
                                                               color:color
                                                              number:number
                                                               alpha:alpha];
                        [self addCard:newCard atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

- (SetCard *)createCardWithShape:(NSString *)shape
                           color:(UIColor *)color
                          number:(NSNumber *)number
                           alpha:(NSNumber *)alpha
{
    SetCard *newCard = [[SetCard alloc] init];
    newCard.shape = shape;
    newCard.color = color;
    newCard.number = [number unsignedIntegerValue];
    newCard.shade = (CGFloat)[alpha floatValue];
    return newCard;
}


@end
