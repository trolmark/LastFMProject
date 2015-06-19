
#import <Foundation/Foundation.h>

@protocol ADDataViewProtocol <NSObject>

@optional
- (void) configureWithData:(id) data;
- (UIView *) snapshot;

@end
