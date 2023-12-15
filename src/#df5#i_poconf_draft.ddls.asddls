@AbapCatalog.sqlViewName: '/DF5/IPOCONFDRAF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Empty Line for partially confirmd Orders'
define view /DF5/I_POCONF_DRAFT
  as select from /DF5/I_POCONF_CONF
{
  key Ebeln,
  key PurchaseOrderItem,
      '    '           as SupplierConfirmation,
      PurchaseOrder,
      Supplier,
      SupplierName,
      PurchOrganisation,
      PurchGroup,
      PODate,
      Material,
      MaterialClass,
      RequestedQuantity,
      TotalConfirmed,
      TotalUnconfirmed,
      TotalUnconfirmed as Quantity,
      Plant,
      StorageLocation,
      NetPrice,
      ekes_ebeln,
      ekes_ebelp,
      NextReqDelDate,
      TotalUnconfirmed as NextRequestedQuantity,
      QuantityToBeDelivered,
      ''               as Reference,
      ekes_ebtyp,
      0                as ReducedQuantity,
      NextReqDelDate   as ConfirmedDelDate,
      ConfirmationStatus,
      'O'              as ConfirmationLinestatus,
      ActionId,
      UoM,
      PriceUnit,
      OrderPriceUnit,
      ConfirmationControlKey,
      ConfirmationControlCategory,
      Currency,
      InvoiceReceiptIndicator,
      POCreator,
      Requisitioner,
      InvoiceIsExpected,
      SupplierMaterialNumber,
      ManufacturerPartNmbr,
      NetAmount,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
where
      ConfirmationStatus     = 'P'
  and ConfirmationLinestatus = 'C'
//  and Reference              is initial
