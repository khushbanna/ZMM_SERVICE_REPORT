@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_SERVICE_REPORT_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_SERVICE_REPORT_CDS
  as select from    I_PurchaseOrderItemAPI01    as A
    left outer join I_PurchaseOrderHistoryAPI01 as serv on(
      serv.PurchaseOrder                 = A.PurchaseOrder
      and serv.PurchaseOrderItem         = A.PurchaseOrderItem
      and serv.PurchasingHistoryCategory = '0'
      and serv.Quantity                  > 0
    )
    left outer join ZMM_CDS1                    as D    on(
         D.ReferenceDocumentItem = serv.PurchasingHistoryDocumentItem
         and D.ReferenceDocument = serv.PurchasingHistoryDocument
       )
    left outer join I_PurchaseOrderAPI01        as F    on(
         F.PurchaseOrder = A.PurchaseOrder
       )
    left outer join I_Supplier                  as E    on(
         E.Supplier = F.Supplier
       )
    left outer join Zytax_code2                 as g    on(
         g.taxcode = A.TaxCode
       ) //01-08-2024-ranveer
    left outer join C_SupplierInvoiceItemDEX    as h    on(
         h.PurchaseOrder         = A.PurchaseOrder
         and h.PurchaseOrderItem = A.PurchaseOrderItem
       )

  //left outer join I_PurchaseOrderItemAPI01 as G on ( G.PurchaseOrder = F.PurchaseOrder )
{
  key A.PurchaseOrder,
      A.PurchaseOrderItem,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      A.OrderQuantity,
      A.PurchaseOrderQuantityUnit,
      A.Plant,
      D.SupplierInvoice,
      D.SupplierInvoiceIDByInvcgParty,
      D.SupplierInvoiceStatus,
      serv.CompanyCodeCurrency, //CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      h.SupplierInvoiceItemAmount                                                         as Invoicevalue,
      cast  ( h.SupplierInvoiceItemAmount as abap.dec( 13, 2 ) ) * g.totalgstrate / 100   as Gstvalue, //01-08-2024-ranveer
      D.PostingDate                                                                       as INVOICEPOSINGDATE,
      E.SupplierName,
      F.PurchasingGroup,
      F.YY1_OurInvoice_PDH,
      F.ExchangeRate,
      g.gstrate, //01-08-2024-ranveer
      g.totalgstrate, //01-08-2024-ranveer
      g.taxcodedescription, //01-08-2024-ranveer
      A.Material,
      A.PurchaseOrderItemText                                                             as Service,
      serv.PurchasingHistoryDocument,
      serv.PurchasingHistoryDocumentItem,
      serv.PostingDate,
      serv.Currency,
      //      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      cast(serv.PurchaseOrderAmount as abap.dec( 13,2  ) )                                as PurchaseOrderAmount,
      @Semantics.quantity.unitOfMeasure:'PurchaseOrderQuantityUnit'
      serv.Quantity,
      A.TaxCode,
      cast  ( h.SupplierInvoiceItemAmount as abap.dec( 13, 2 ) ) +
      ( cast( h.SupplierInvoiceItemAmount as abap.dec( 13, 2 ) ) * g.totalgstrate / 100 ) as totalinvoiceamount, //01-08-2024-ranveer

      




      case when D.SupplierInvoiceStatus = '5' then 'POST'
          when D.SupplierInvoiceStatus = 'A' then 'PARK'
          when D.SupplierInvoiceStatus = 'B' then 'COMPLETED'
          end                                                                             as status


}

where
      A.ProductType                    = '2'
  and A.PurchasingDocumentDeletionCode = ''
//   and F.PurchasingGroup <> 'P20' and F.PurchasingGroup <> 'P21' 
