//
//  SetCard.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/17/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSUInteger number;
@property (nonatomic) CGFloat shade;

+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validNumbers;
+ (NSArray *)validShades;

@end
