#import <UIKit/UIKit.h>


@interface LabeledCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *label;
@property(nonatomic,weak)IBOutlet UILabel *content;
@property(nonatomic,assign)BOOL hasContent;

- (void)setLabelText:(NSString *)text;
- (void)setContentText:(NSString *)text;
@end