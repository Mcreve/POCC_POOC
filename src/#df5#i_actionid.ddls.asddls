@AbapCatalog.sqlViewName: '/DF5/IACTIONID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'IF for mass confirmation action id'
define root view /DF5/I_ACTIONID
  as select from /df5/db_acid
  composition [1..*] of /DF5/I_POCONF_ID as _ConfLines
{

      ///df5/db_acid
  key actionid,
      created_by,
      created_on,
      _ConfLines
}
