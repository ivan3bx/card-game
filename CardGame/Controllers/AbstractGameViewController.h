//
//  GameViewController.h
//  CardGame
//
//  Created by Ivan Moscoso on 7/18/13.
//  Copyright (c) 2013 ivan3bx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface AbstractGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *results;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

-(void)initializeCardMatchingGameWithDeck:(Deck *)deck checkingForMatchAt:(int)numberOfCards;

@end
