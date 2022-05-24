@AbapCatalog.sqlViewName: '/DF5/IPONOTCONF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'IF for unconfirmed but required lines'
define view /DF5/I_POCONF_NOTCONF
  as select from /DF5/I_POCONFIRMATION
{
  key ebeln,
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
      NextRequestedQuantity,
      Reference,
      ekes_ebtyp,
      ReducedQuantity,
      eket_eindt       as ConfirmedDelDate,
      'U'              as ConfirmationStatus,
      'O'              as ConfirmationLinestatus,
      ActionId,
      UoM,
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
where
  ekes_ebeln is null // and TotalUnconfirmed > 0
