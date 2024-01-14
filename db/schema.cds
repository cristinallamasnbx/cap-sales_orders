namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Header : cuid, managed {
        Email        : String(36);
        FirstName    : String(30);
        LastName     : String(30);
        Country      : String(30);
        CreatedOn    : Date default $now;
        DeliveryDate : DateTime;
        OrderStatus  : Integer enum {
            received   = 1;
            processing = 2;
            shipped    = 3;
            delivered  = 4;
            canceled   = -1;
        };
        ImageUrl     : String;
        ToItems      : Association to many HeaderxItem
                           on ToItems.Header = $self;
}

entity Item : cuid, managed {
    Name             : String(36);
    Description      : String(36);
    ReleaseDate      : Date;
    DiscontinuedDate : Date;
    Price            : Decimal(12, 2);
    Height           : Decimal(15, 3);
    Width            : Decimal(13, 3);
    Depth            : Decimal(12, 2);
    Quantity         : Decimal(16, 2);
    ToUnitOfMeasure  : Association to ItemxUnitOfMeasure
                           on ToUnitOfMeasure.Item = $self;
    ToHeader         : Association to many HeaderxItem
                           on ToHeader.Item = $self;
}

entity UnitOfMeasure {
    key ID          : String(2);
        Description : String;
}

entity HeaderxItem : cuid {
    Header : Association to Header;
    Item   : Association to Item;
}

entity ItemxUnitOfMeasure: cuid {
    Item          : Association to Item;
    UnitOfMeasure : Association to UnitOfMeasure;
}
