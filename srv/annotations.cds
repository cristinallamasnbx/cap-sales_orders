using {CatalogServices as service} from './catalog-service.cds';

annotate service.Header with {
    OrderStatus @title: 'Status';
    LastName    @title: 'Surname';
}

annotate service.Header with @(
    // SemanticKey
    Common.SemanticKey: [ID],

    // Filters
    UI.SelectionFields: [
        Email,
        LastName
    ],

    // Header
    UI.HeaderInfo     : {
        $Type         : '',
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : {
            $Type: 'UI.DataField',
            Value: Email,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: {$edmJson: {
                $Apply   : [
                    {Path: 'FirstName'},
                    ' ',
                    {Path: 'LastName'}
                ],
                $Function: 'odata.concat'
            }}
        },
        ImageUrl      : {$edmJson: {$Path: 'ImageUrl', }}
    },

    // Table
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: CreatedOn,
            Label: 'Date'
        },
        {
            $Type: 'UI.DataField',
            Value: OrderStatus,
            Label: 'Status'
        },
        {
            $Type: 'UI.DataField',
            Value: FirstName,
            Label: 'Name'
        },
        {
            $Type: 'UI.DataField',
            Value: LastName,
            Label: 'Surname'
        },
        {
            $Type: 'UI.DataField',
            Value: Email
        },
        {
            $Type: 'UI.DataField',
            Value: Country
        },
        {
            $Type: 'UI.DataField',
            Value: DeliveryDate,
            Label: 'Estimated delivery'
        },
    ]

);

annotate service.Item with @(
    UI.HeaderInfo    : {
        $Type         : '',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
    },
    UI.LineItem #Item: [
        {
            $Type: 'UI.DataField',
            Value: Name
        },
        {
            $Type: 'UI.DataField',
            Value: Description
        },
        {
            $Type: 'UI.DataField',
            Value: Price
        },
        {
            $Type: 'UI.DataField',
            Value: Quantity
        },
        {
            $Type: 'UI.DataField',
            Value: ToUnitOfMeasure.UnitOfMeasure.Description,
            Label: 'Unit'
        }
    ]
);
