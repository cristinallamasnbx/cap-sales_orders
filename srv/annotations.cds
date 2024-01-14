using {CatalogServices as service} from './catalog-service.cds';

annotate service.Header with {
    OrderStatus @title: 'Status';
    LastName    @title: 'Surname';
    CreatedOn   @title: 'Created on';
    Email       @title: 'Email';
}

@odata.draft.enabled
annotate service.Header with @(
    Capabilities.Insertable: true,
    Capabilities.Updatable : true,
    UI.CreateHidden        : false,
    UI.UpdateHidden        : false,
    // SemanticKey
    Common.SemanticKey     : [ID],

    // Filters
    UI.SelectionFields     : [
        Email,
        LastName
    ],

    // Header
    UI.HeaderInfo          : {
        $Type         : '',
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : {
            $Type: 'UI.DataField',
            Value: Email,
        },
        Description   : {
            $Type: 'UI.DataField',
            /*Value: {$edmJson: {
                $Apply   : [
                    {Path: 'FirstName'},
                    ' ',
                    {Path: 'LastName'}
                ],
                $Function: 'odata.concat'
            }}*/
            Value: CreatedOn
        },
        ImageUrl      : ImageUrl
    },

    // Table sort order
    UI.PresentationVariant : {
        SortOrder     : [
                         //Default sort order
                        {Property: CreatedOn}, ],
        Visualizations: ['@UI.LineItem'],
    },

    // Table
    UI.LineItem            : [
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
    ],

    // Facets
    UI.FieldGroup #GroupA  : {
        $Type: 'UI.FieldGroupType',
        Data : [
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
                Value: Email,
                Label: 'Email'
            },
            {
                $Type: 'UI.DataField',
                Value: ImageUrl,
                Label: 'Company Logo'
            }
        ]
    },
    UI.FieldGroup #GroupB  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
                Label: 'Sales Order ID'
            },
            {
                $Type: 'UI.DataField',
                Value: CreatedOn,
                Label: 'Created on'
            },
            {
                $Type: 'UI.DataField',
                Value: OrderStatus,
                Label: 'Status'
            },
            {
                $Type: 'UI.DataField',
                Value: DeliveryDate,
                Label: 'Estimated delivery date'
            },
            {
                $Type: 'UI.DataField',
                Value: Country,
                Label: 'Country'
            }
        ]
    },
    UI.Facets              : [
        /*{
            $Type : 'UI.CollectionFacet',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: ![@UI.FieldGroup#GroupA],
                Label : 'Sales Order Information'
            }],
        },*/
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Client information',
            Target: ![@UI.FieldGroup#GroupA]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales order information',
            Target: ![@UI.FieldGroup#GroupB]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales order items',
            Target: 'ToItems/@UI.LineItem'
        }
    ]
);

annotate service.HeaderxItem with @(
    UI.PresentationVariant: {
        SortOrder     : [ //Default sort order
        {
            Property  : Item.Price,
            Descending: true,
        }, ],
        Visualizations: ['@UI.LineItem'],
    },
    UI.HeaderInfo         : {
        $Type         : '',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
    },
    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: Item.Name,
            Label: 'Name'
        },
        {
            $Type: 'UI.DataField',
            Value: Item.Description,
            Label: 'Description'
        },
        {
            $Type: 'UI.DataField',
            Value: Item.Price,
            Label: 'Price'
        },
        {
            $Type: 'UI.DataField',
            Value: Item.Quantity,
            Label: 'Quantity'
        },
        {
            $Type: 'UI.DataField',
            Value: Item.ToUnitOfMeasure.UnitOfMeasure.Description,
            Label: 'Unit'
        }
    ]
);

annotate service.Item with @(
    UI.PresentationVariant: {
        SortOrder     : [ //Default sort order
        {
            Property  : Price,
            Descending: true,
        }, ],
        Visualizations: ['@UI.LineItem'],
    },
    UI.HeaderInfo         : {
        $Type         : '',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
    },
    UI.LineItem           : [
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
