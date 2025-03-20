--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Name: Daniel Maina
--Date: 2025 March

DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @SQL = @SQL + '
INSERT INTO madiva..DataSheet 
SELECT PatientId ,RegistrationDate ,DoB ,YoB ,Sex ,HealthFacility ,NameComplete ,SurnameComplete ,DoBComplete ,GenderComplete ,PhoneNumber1Complete ,PhoneNumber2Complete ,NationalIDComplete ,HomeAddressComplete ,NextOfKinNameComplete ,NextOfKinSurnameComplete ,Consented ,Refused ,NotAsked ,MissingConsentInfo ,HasClinicalVisits ,MatchFound ,MatchCriteria ,Score ,Date ,day ,month ,year ,TypeOfInteraction ,PatientCategory ,diagnosis1 ,diagnosis2 ,diagnosis3 ,diagnosis4 ,diagnosis5 ,asthma ,diabetes ,epilepsy ,hiv ,hypertension ,raised_bp ,mental_illness ,tb ,other_illness ,DiastolicBP ,SystolicBP ,visit_note ,Weight ,Height ,Pulse ,BloodGlucose ,CD4CountResults ,CD4countUnits ,HIVStage ,ViralLoadResults ,ViralLoadUnits ,UndetectableViralLoad ,Edu_Counselling ,given_medication ,referred ,checkup_appmt ,seen_by_dr ,return_date ,sms_reminder ,phone_reminder ,visit_reminder ,other_reminder ,no_contact_reminder ,Started_fu ,sms_fu ,sms_fu_outcome ,phone_fu ,phone_fu_outcome ,visit_fu ,visit_fu_outcome ,chw_fu ,chw_fu_outcome ,identifiers_data_typist ,date_identifiers_entered ,lhw_name ,DateEntered ,data_typist
 FROM [' + name + ']..DataSheet 
WHERE PatientId IN (SELECT PatientId FROM [' + name + ']..Matches);'
FROM sys.databases
WHERE name IN ('LLHC', 'KHC', 'MHC', 'BabaDogo', 'KochHC')

PRINT @SQL  -- Debugging: View generated SQL
EXEC sp_executesql @SQL  -- Execute dynamically
