@AbapCatalog.sqlViewName: '/DF5/I_CLINESTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Confirmation Line Status'
define view /DF5/I_CONFIRMLINESTATUS
  as select from /df5/db_clinstat
  association [0..*] to /DF5/I_CONFIRMLINESTATUSTXT as _Text on $projection.ConfirmationLineStatus = _Text.ConfirmationLineStatus
{
      @ObjectModel.text.association: '_Text'
  key confirmation_line_status as ConfirmationLineStatus,
      _Text
}
