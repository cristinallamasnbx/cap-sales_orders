namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Header : cuid, managed {
    key Email        : String(36);
        FirstName    : String(30);
        LastName     : String(30);
        Country      : String(30);
        CreatedOn    : Date;
        DeliveryDate : DateTime;
        OrderStatus  : Integer;
        ImageUrl     : String;
        Items        : Association to many Item
                           on Items.Header = $self;
}

entity Item : cuid, managed {
    Name             : String(36);
    Description      : String(36);
    ReleaseDate      : Date;
    DiscontinuedDate : Date;
    Price            : Decimal(12, 2);
    Header           : Association to Header;
}
