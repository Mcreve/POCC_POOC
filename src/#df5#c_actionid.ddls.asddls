@EndUserText.label: 'Mass Confirmation action ID'
@AccessControl.authorizationCheck: #CHECK
define root view entity /DF5/C_ACTIONID
  provider contract transactional_query
  as projection on /DF5/I_ACTIONID
{
  key actionid,
      created_by,
      created_on,
      
      /* Associations */
      _ConfLines : redirected to composition child /DF5/C_POCONF_ID
}
