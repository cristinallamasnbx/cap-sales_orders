using com.logali as logali from '../db/schema';

service CatalogServices {
    entity Header @(
        Capabilities.Insertable: true,
        Capabilities.Updatable: true
    ) as select from logali.Header {
        ID,
        Email @mandatory,
        FirstName @mandatory,
        LastName @mandatory,
        Country @mandatory,
        CreatedOn @mandatory,
        DeliveryDate @mandatory,
        OrderStatus @mandatory,
        ImageUrl,
        ToItems
    };

    entity Item @(
        Capabilities.Insertable: true,
        Capabilities.Updatable: true
    ) as select from logali.Item {
        ID,
        Name @mandatory,
        Description,
        ReleaseDate,
        DiscontinuedDate,
        Price @mandatory,
        Height @mandatory,
        Width @mandatory,
        Depth @mandatory,
        Quantity @mandatory,
        ToUnitOfMeasure @mandatory,
        Header
    };

    @readonly
    entity UnitOfMeasure as select from logali.UnitOfMeasure {
        ID,
        Description
    }
}