#import "GHOrganization.h"
#import "GHAccount.h"
#import "GHEvents.h"
#import "GHUser.h"
#import "GHUsers.h"
#import "GHRepository.h"
#import "GHRepositories.h"
#import "GravatarLoader.h"
#import "iOctocat.h"
#import "NSURL+Extensions.h"
#import "NSString+Extensions.h"
#import "NSDictionary+Extensions.h"


@implementation GHOrganization

+ (id)organizationWithLogin:(NSString *)theLogin {
	return [[self.class alloc] initWithLogin:theLogin];
}

- (id)initWithLogin:(NSString *)theLogin {
	self = [self init];
	if (self) {
		self.login = theLogin;
		self.gravatar = [iOctocat cachedGravatarForIdentifier:self.login];
		self.gravatarLoader = [GravatarLoader loaderWithTarget:self andHandle:@selector(loadedGravatar:)];
	}
	return self;
}

- (NSUInteger)hash {
	NSString *hashValue = [self.login lowercaseString];
	return [hashValue hash];
}

- (int)compareByName:(GHOrganization *)theOtherOrg {
	return [self.login localizedCaseInsensitiveCompare:theOtherOrg.login];
}

- (void)setLogin:(NSString *)theLogin {
	_login = theLogin;

	NSString *repositoriesPath = [NSString stringWithFormat:kOrganizationRepositoriesFormat, self.login];
	NSString *membersPath = [NSString stringWithFormat:kOrganizationMembersFormat, self.login];
	NSString *eventsPath = [NSString stringWithFormat:kOrganizationEventsFormat, self.login];

	self.resourcePath = [NSString stringWithFormat:kOrganizationFormat, self.login];
	self.repositories = [GHRepositories repositoriesWithPath:repositoriesPath];
	self.publicMembers = [GHUsers usersWithPath:membersPath];
	self.events = [GHEvents resourceWithPath:eventsPath];
}

- (void)setValues:(id)theDict {
	NSDictionary *resource = [theDict objectForKey:@"organization"] ? [theDict objectForKey:@"organization"] : theDict;
	NSString *theLogin = [resource valueForKey:@"login" defaultsTo:@""];
	
	if (![theLogin isEmpty] && ![self.login isEqualToString:theLogin]) self.login = theLogin;
	self.name = [resource valueForKey:@"name" defaultsTo:@""];
	self.email = [resource valueForKey:@"email" defaultsTo:@""];
	self.company = [resource valueForKey:@"company" defaultsTo:@""];
	self.location = [resource valueForKey:@"location" defaultsTo:@""];
	self.blogURL = [NSURL smartURLFromString:[resource valueForKey:@"blog" defaultsTo:@""]];
	self.followersCount = [[resource objectForKey:@"followers"] integerValue];
	self.followingCount = [[resource objectForKey:@"following"] integerValue];
	self.publicGistCount = [[resource objectForKey:@"public_gists"] integerValue];
	self.privateGistCount = [[resource objectForKey:@"private_gists"] integerValue];
	self.publicRepoCount = [[resource objectForKey:@"public_repos"] integerValue];
	self.privateRepoCount = [[resource objectForKey:@"total_private_repos"] integerValue];
	self.gravatarURL = [NSURL URLWithString:[theDict objectForKey:@"avatar_url"]];
	self.htmlURL = [NSURL URLWithString:[theDict objectForKey:@"html_url"]];
}

#pragma mark Gravatar

- (void)setGravatarURL:(NSURL *)theURL {
	_gravatarURL = theURL;

	if (self.gravatarURL) {
		[self.gravatarLoader loadURL:self.gravatarURL];
	}
}

- (void)loadedGravatar:(UIImage *)theImage {
	self.gravatar = theImage;
}

@end