@AbapCatalog.sqlViewName: '/DF5/I_POCONFIRM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Helper interface for PO Confirmations'
define view /DF5/I_POCONFIRMATION
  as select from /DF5/I_POCONF_HEAD
  association [1..1] to /DF5/I_POCONF_SUM as _sum on  _sum.PurchaseOrder     = $projection.PurchaseOrder
                                                  and _sum.PurchaseOrderItem = $projection.PurchaseOrderItem
{
  key Ebeln,
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
      @Semantics.quantity.unitOfMeasure : 'UoM'
      RequestedQuantity,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      _sum.TotalConfirmed,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      case
        when _sum.TotalConfirmed is not null
          then RequestedQuantity - _sum.TotalConfirmed
        else RequestedQuantity
      end                          as TotalUnconfirmed,
      Plant,
      StorageLocation,
      @Semantics.amount.currencyCode: 'Currency'
      NetPrice,
      ekes_ebeln,
      ekes_ebelp,
      eket_eindt                   as NextReqDelDate,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      eket_menge                   as NextRequestedQuantity,
      Reference,
      ekes_ebtyp,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      ReducedQuantity,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      ekes_menge,
      ekes_eindt,
      eket_eindt,
      eket_menge,
      cast('0' as abap.char( 22 )) as ActionId,
      @Semantics.unitOfMeasure: true
      UoM,
      PriceUnit,
      OrderPriceUnit,
      ConfirmationControlKey,
      ConfirmationControlCategory,
      @Semantics.currencyCode: true
      Currency,

      /* Associations */
      _Items,
      _Supplier,
      _Product
}
