@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Confirmations header'
define view entity /DF5/I_POCONF_HEAD
  as select from /DF5/I_EKKO as POHeader

  association [1..*] to /DF5/I_POCONF_ITEMS as _Items    on _Items.PurchaseOrder = $projection.Ebeln
  association [0..1] to I_Supplier          as _Supplier on _Supplier.Supplier = $projection.Supplier
{
  key POHeader.Ebeln,
  key _Items[1:inner].PurchaseOrderItem,
  key _Items[1:inner].SupplierConfirmation,
      _Items[1:inner].PurchaseOrder as PurchaseOrder,
      POHeader.Lifnr                as Supplier,
      _Supplier.OrganizationBPName1 as SupplierName,
      POHeader.Ekorg                as PurchOrganisation,
      POHeader.Ekgrp                as PurchGroup,
      POHeader.Bedat                as PODate,

      _Items[1:inner].Material,
      _Items[1:inner].MaterialClass,
      _Items[1:inner].RequestedQuantity,
      _Items[1:inner].Plant,
      _Items[1:inner].StorageLocation,
      @Semantics.amount.currencyCode: 'Currency'
      _Items[1:inner].NetPrice,
      _Items[1:inner].ekes_ebeln,
      _Items[1:inner].ekes_ebelp,
      _Items[1:inner].ekes_eindt,
      _Items[1:inner].ekes_menge,
      _Items[1:inner].Reference,
      _Items[1:inner].ekes_ebtyp,
      _Items[1:inner].ReducedQuantity,
      _Items[1:inner].eket_eindt,
      _Items[1:inner].eket_menge,
      _Items[1:inner].QuantityToBeDelivered,
      _Items[1:inner].UoM,
      _Items[1:inner].PriceUnit,
      _Items[1:inner].OrderPriceUnit,
      _Items[1:inner].ConfirmationControlKey,
      _Items[1:inner].ConfirmationControlCategory,
      POHeader.Waers                as Currency,
      _Items[1:inner].InvoiceReceiptIndicator,
      POHeader.Ernam                as POCreator,
      _Items[1:inner].Requisitioner,
      _Items[1:inner].InvoiceIsExpected,
      _Items[1:inner].SupplierMaterialNumber,
      _Items[1:inner].ManufacturerPartNmbr,
      @Semantics.amount.currencyCode: 'Currency'
      _Items[1:inner].NetAmount,
      
      /* Associations */
      _Items,
      _Supplier,
      _Items[1:inner]._Product
}
where
      POHeader.Loekz  =  ''
  and POHeader.Memory =  ''
  and POHeader.Frgrl  =  ''
  and POHeader.Autlf  <> 'X'
  and POHeader.Bstyp  =  'F'
