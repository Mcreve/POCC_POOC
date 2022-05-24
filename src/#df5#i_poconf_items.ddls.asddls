@AbapCatalog.sqlViewName: '/DF5/IPOCONFITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Confirmations line item'
define view /DF5/I_POCONF_ITEMS
  as select from ekpo as PurchaseOrders

  association [0..*] to ekes                   as _ekes    on  PurchaseOrders.ebeln = _ekes.ebeln
                                                           and PurchaseOrders.ebelp = _ekes.ebelp
                                                           and _ekes.ebtyp          = 'AB'

  association [1..1] to /DF5/I_EKET_DELDATEQTY as _eket    on  PurchaseOrders.ebeln = _eket.PurchaseOrder
                                                           and PurchaseOrders.ebelp = _eket.PurchaseOrderLine

  association [0..1] to I_Product              as _Product on  PurchaseOrders.matnr = _Product.Product
{
  key PurchaseOrders.ebeln as PurchaseOrder,
  key PurchaseOrders.ebelp as PurchaseOrderItem,
  key _ekes.etens          as SupplierConfirmation,

      PurchaseOrders.werks as Plant,
      PurchaseOrders.lgort as StorageLocation,
      @ObjectModel.text.association: '_Product'
      PurchaseOrders.matnr as Material,
      PurchaseOrders.matkl as MaterialClass,
      PurchaseOrders.menge as RequestedQuantity,
      PurchaseOrders.netpr as NetPrice,
      PurchaseOrders.meins as UoM,

      PurchaseOrders.loekz,

      _ekes.ebeln          as ekes_ebeln,
      _ekes.ebelp          as ekes_ebelp,
      _ekes.eindt          as ekes_eindt,
      _ekes.menge          as ekes_menge,
      _ekes.xblnr          as Reference,
      _ekes.ebtyp          as ekes_ebtyp,
      _ekes.dabmg          as ReducedQuantity,

      _eket.DelDate        as eket_eindt,
      _eket.Quantity       as eket_menge,

      /* Associations */
      _ekes,
      _eket,
      _Product
}
where
      loekz is initial
  and bstae is not initial
  and elikz is initial
  and attyp <> '01'
