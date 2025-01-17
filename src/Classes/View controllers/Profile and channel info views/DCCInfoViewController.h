//
//  DCCInfoViewController.h
//  Discord Classic
//
//  Created by XML on 12/11/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRecipientTableCell.h"
#import "DCContactViewController.h"
#import "DCServerCommunicator.h"
#import "DCChatViewController.h"
#import "APLSlideMenuViewController.h"
#import "DCTools.h"
#import "DCUser.h"
@interface DCCInfoViewController : UITableViewController

@property NSMutableArray* recipients;
@property (nonatomic, strong) DCUser *selectedUser;

@property DCUser* user;
@end
