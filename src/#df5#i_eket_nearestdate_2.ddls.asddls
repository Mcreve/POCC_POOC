@AbapCatalog.sqlViewName: '/DF5/IEKETNRSDA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Nearest date for EKET Level 2'
define view /DF5/I_EKET_NEARESTDATE_2
  as select from    /DF5/I_EKET_NEARESTDATE_3A as _NearestDate
    left outer join /DF5/I_EKET_NEARESTDATE_3B as _NearestDate2 on  _NearestDate.Ebeln = _NearestDate2.Ebeln
                                                                and _NearestDate.Ebelp = _NearestDate2.Ebelp
{
  key _NearestDate.Ebeln as PurchaseOrder,
  key _NearestDate.Ebelp as PurchaseOrderLine,
      _NearestDate.Eindt as ItemDeliveryDate,
      _NearestDate.Menge as Quantity
}
where
  _NearestDate2.Ebeln is null
