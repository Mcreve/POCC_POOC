@AbapCatalog.sqlViewName: '/DF5/I_CLINSTATX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Confirmation Line Status Text'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ActionType'
@ClientHandling.algorithm: #SESSION_VARIABLE
define view /DF5/I_CONFIRMLINESTATUSTXT
  as select from /df5/db_clinsttx
{
  key confirmation_line_status     as ConfirmationLineStatus,
      @Semantics.language: true
  key language                     as Language,
      @Semantics.text: true
      confirmation_line_status_txt as ConfirmationLineStatusTxt
}
