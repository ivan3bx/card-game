//
//  SetCard.m
//  CardGame
//
//  Created by Ivan Moscoso on 7/17/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@end

@implementation SetCard

- (NSString *)contents
{
    NSMutableString *value = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < self.number; i++) {
        [value appendString:self.shape];
    }
    return value;
}

- (int)match:(NSArray *)otherCards
{
    if (otherCards.count < 2) {
        return 0;
    }
    
    // Pick two cards
    SetCard *first = otherCards[0];
    SetCard *second = otherCards[1];
    
    BOOL shapeMatch  = [self.shape isEqualToString:first.shape] && [self.shape isEqualToString:second.shape];
    BOOL colorMatch  = [self.color isEqual:first.color] && [self.color isEqual:second.color];
    BOOL numberMatch = self.number == first.number == second.number;
    BOOL shadeMatch  = self.shade == first.shade == second.shade;

    int score = 0;
    // this is blatantly wrong..
    if (shapeMatch) {
        score = 1;
    }
    
    return score;
}


#pragma mark -
#pragma mark Constants
#pragma mark -

+ (NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor]];
}

+ (NSArray *)validShapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validNumbers
{
    return @[@1, @2, @3];
}

+ (NSArray *)validShades
{
    return @[@1.0, @0.7, @0.4];
}


@end
