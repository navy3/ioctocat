#import "AuthenticationController.h"
#import "GHAccount.h"
#import "GHUser.h"
#import "iOctocat.h"


@interface AuthenticationController ()
@property(nonatomic,weak)UIViewController *delegate;
@property(nonatomic,strong)UIActionSheet *authSheet;
@property(nonatomic,strong)GHAccount *account;

- (void)setAccount:(GHAccount *)theAccount;
@end


@implementation AuthenticationController

- (id)initWithDelegate:(UIViewController *)theDelegate {
	self = [super init];
	self.delegate = theDelegate;
	return self;
}

- (void)dealloc {
	[self stopAuthenticating];
	[self.account removeObserver:self forKeyPath:@"user.loadingStatus"];
}

- (void)setAccount:(GHAccount *)theAccount {
	[self.account removeObserver:self forKeyPath:@"user.loadingStatus"];
	_account = theAccount;
	[self.account addObserver:self forKeyPath:@"user.loadingStatus" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)authenticateAccount:(GHAccount *)theAccount {
	self.account = theAccount;
	[self.account.user loadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (self.account.user.isLoading) {
		self.authSheet = [[UIActionSheet alloc] initWithTitle:@"\nAuthenticating, please wait…\n\n"
													  delegate:self
											 cancelButtonTitle:nil
										destructiveButtonTitle:nil
											 otherButtonTitles:nil];
		[self.authSheet showInView:[iOctocat sharedInstance].window];
	} else {
		[self stopAuthenticating];
		[self.delegate performSelector:@selector(authenticatedAccount:) withObject:self.account];
	}
}

- (void)stopAuthenticating {
	[self.authSheet dismissWithClickedButtonIndex:0 animated:YES];
}

@end