#import "ADCellLayoutMetrics.h"

@interface  ADCellLayoutMetrics()

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, assign, getter=shouldUseNib) BOOL useNib;

@end

@implementation ADCellLayoutMetrics

- (instancetype)initWithClass:(Class) cellClass
               cellIdentifier:(NSString *) cellIdentifier
                       useNib:(BOOL)useNib {
        self = [super init];
        if (self == nil) {
                return nil;
        }
        self.cellClass = cellClass;
        self.cellIdentifier = cellIdentifier;
        self.useNib = useNib;
    
        return self;
}

- (void) registerWithCollectionView:(UICollectionView *) collectionView
{
    if (self.shouldUseNib) {
        [collectionView registerNib:[UINib nibWithNibName:self.cellIdentifier bundle:[NSBundle mainBundle]]
         forCellWithReuseIdentifier:self.cellIdentifier];
    } else {
        [collectionView registerClass:[self cellClass] forCellWithReuseIdentifier:[self cellIdentifier]];
    }
}


@end
