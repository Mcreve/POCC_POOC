@EndUserText.label: 'Root view entity for Confirmation ID'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity /DF5/C_POCONF_ID
  as projection on /DF5/I_POCONF_ID
{
  key purchaseorder,
  key actionid,
      created_by,
      created_on,
      
      /* Associations */
      _Action : redirected to parent /DF5/C_ACTIONID,
      _Lines : redirected to composition child /DF5/C_POCONF_LIST,
      _Log : redirected to composition child /DF5/C_POCONF_LOG
}
