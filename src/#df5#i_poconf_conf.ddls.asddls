@AbapCatalog.sqlViewName: '/DF5/IPOCONFCONF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '(partially) confirmed Sales Order'
define view /DF5/I_POCONF_CONF
  as select from /DF5/I_POCONFIRMATION
{
  key ebeln,
  key PurchaseOrderItem,
  key SupplierConfirmation,
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
      ekes_menge as Quantity,
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
      ekes_eindt as ConfirmedDelDate,
      case
        when TotalConfirmed >= RequestedQuantity then 'F'
        else 'P'
      end        as ConfirmationStatus,
      'C'        as ConfirmationLinestatus,
      ActionId,
      UoM,
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
where
  ekes_ebeln is not null
