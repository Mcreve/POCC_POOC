@AbapCatalog.sqlViewName: '/DF5/IPOCONFUNIO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Union for all required lines'
define view /DF5/I_POCONF_UNION
  as select from /DF5/I_POCONF_CONF
{
  key ebeln as PurchaseOrder,
  key PurchaseOrderItem,
  key SupplierConfirmation,
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
      Quantity,
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
      ConfirmedDelDate,
      ConfirmationStatus,
      ConfirmationLinestatus,
      ActionId,
      UoM,
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
union select from /DF5/I_POCONF_NOTCONF
{
  key ebeln as PurchaseOrder,
  key PurchaseOrderItem,
  key SupplierConfirmation,
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
      Quantity,
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
      ConfirmedDelDate,
      ConfirmationStatus,
      ConfirmationLinestatus,
      ActionId,
      UoM,
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
union select distinct from /DF5/I_POCONF_DRAFT
{
  key ebeln as PurchaseOrder,
  key PurchaseOrderItem,
  key SupplierConfirmation,
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
      Quantity,
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
      ConfirmedDelDate,
      ConfirmationStatus,
      ConfirmationLinestatus,
      ActionId,
      UoM,
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
