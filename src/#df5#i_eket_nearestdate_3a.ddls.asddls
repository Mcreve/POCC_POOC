@AbapCatalog.sqlViewName: '/DF5/IEKETNSDA3A'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Nearest date for EKET Level 3A'
define view /DF5/I_EKET_NEARESTDATE_3A
  as select from /DF5/I_EKET
{
  key Ebeln,
  key Ebelp,
      Eindt,
      Menge
}
where
  Eindt < $session.system_date
