//
//  DCCInfoViewController.m
//  Discord Classic
//
//  Created by XML on 12/11/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import "DCCInfoViewController.h"

@interface DCCInfoViewController ()

@end

@implementation DCCInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.recipients = [NSMutableArray array];
    NSArray *recipientDictionaries = [DCServerCommunicator.sharedInstance.selectedChannel recipients];
    for (NSDictionary *recipient in recipientDictionaries) {
        DCUser *dcUser = [DCTools convertJsonUser:recipient cache:YES];
        [self.recipients addObject:dcUser];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DCServerCommunicator.sharedInstance.selectedChannel.recipients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hackyMode"]) {
        DCRecipientTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Members cell"];
        DCUser *user = self.recipients[indexPath.row];
        cell.userName.text = user.globalName;
        cell.userPFP.image = user.profileImage;
        cell.userPFP.layer.cornerRadius = cell.userPFP.frame.size.width / 2.0;
        cell.userPFP.layer.masksToBounds = YES;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Members Cell"];
        if (!cell) cell = UITableViewCell.new;
        DCUser *user = self.recipients[indexPath.row];
        cell.textLabel.text = user.username;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedUser = self.recipients[indexPath.row];
    [self performSegueWithIdentifier:@"channelinfo to contact" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DCContactViewController class]]) {
        DCContactViewController *contactVC = (DCContactViewController *)segue.destinationViewController;
        contactVC.selectedUser = self.selectedUser;
    }
}

@end
