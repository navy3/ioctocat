#import <UIKit/UIKit.h>
#import "TextCell.h"


@protocol EventCellDelegate
- (void)openEventItem:(id)theEventItem;
@end


@class GHEvent;

@interface EventCell : TextCell
@property(nonatomic,weak)id<EventCellDelegate> delegate;
@property(nonatomic,strong)GHEvent *event;
@property(nonatomic,weak)IBOutlet UIView *actionsView;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UIImageView *iconView;
@property(nonatomic,weak)IBOutlet UIImageView *gravatarView;
@property(nonatomic,strong)IBOutlet UIButton *repositoryButton;
@property(nonatomic,strong)IBOutlet UIButton *otherRepositoryButton;
@property(nonatomic,strong)IBOutlet UIButton *userButton;
@property(nonatomic,strong)IBOutlet UIButton *otherUserButton;
@property(nonatomic,strong)IBOutlet UIButton *organizationButton;
@property(nonatomic,strong)IBOutlet UIButton *issueButton;
@property(nonatomic,strong)IBOutlet UIButton *pullRequestButton;
@property(nonatomic,strong)IBOutlet UIButton *wikiButton;
@property(nonatomic,strong)IBOutlet UIButton *commitButton;
@property(nonatomic,strong)IBOutlet UIButton *gistButton;

- (void)markAsNew;
- (void)markAsRead;
- (IBAction)showRepository:(id)sender;
- (IBAction)showOtherRepository:(id)sender;
- (IBAction)showUser:(id)sender;
- (IBAction)showOtherUser:(id)sender;
- (IBAction)showOrganization:(id)sender;
- (IBAction)showIssue:(id)sender;
- (IBAction)showPullRequest:(id)sender;
- (IBAction)showWiki:(id)sender;
- (IBAction)showCommit:(id)sender;
- (IBAction)showGist:(id)sender;
@end