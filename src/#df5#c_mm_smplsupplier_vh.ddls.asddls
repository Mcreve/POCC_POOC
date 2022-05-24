@EndUserText.label: 'Simple Supplier Value help projection'
@AccessControl.authorizationCheck: #CHECK
define root view entity /DF5/C_MM_SMPLSUPPLIER_VH
  provider contract transactional_query
  as projection on /DF5/I_MM_SMPLSUPPLIER_VH
{
  key Supplier,
  key CompanyCode,
      SupplierName,
      Country,
      FirstName,
      LastName,
      OrganizationBPName1,
      OrganizationBPName2,
      OrganizationBPName3,
      OrganizationBPName4,
      AuthorizationGroup,
      SupplierAccountGroup,
      IsBusinessPurposeCompleted,
      
      /* Associations */
      _BusinessPartnerSuplrCo
}
