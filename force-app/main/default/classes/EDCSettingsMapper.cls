public virtual with sharing class EDCSettingsMapper {
    /*********************************************
     * @description Instance for Singleton Pattern
     **********************************************/
    @TestVisible
    private static EDCSettingsMapper instance;

    /*********************************************************************
     * @description Empty constructor is not public for Singleton Pattern
     **********************************************************************/
    protected EDCSettingsMapper() {
    }

    /*****************************************************************************
     * @description Static method to get the current instance for Singleton pattern
     * @return The instance of AccountModelSettingsMapper.
     ******************************************************************************/
    public static EDCSettingsMapper getInstance() {
        if (instance == null) {
            instance = new EDCSettingsMapper();
        }

        return instance;
    }

    public List<EDCSettingsModel> getEDCSettingsModels() {
        List<EDCSettingsModel> edcSettingsModels = new List<EDCSettingsModel>();

        edcSettingsModels.add(
            new EDCSettingsModel(
                '1',
                'hed.stgHHAccountCustomName',
                'hed.stgHHAccountCustomName',
                'edaSettingsContainer__hed'
            )
        );
        edcSettingsModels.add(new EDCSettingsModel('1', 'c.TestLabel', 'c.TestLabel2', 'edaSettingsContainer__hed'));
        /*for (EDU_Settings_Config__mdt eduSettingsConfig : this.getEDUSettingsConfigs()) {
            EDCSettingsModel edcSettingsModel = new EDCSettingsModel(
                eduSettingsConfig.Id,
                eduSettingsConfig.MasterLabel,
                eduSettingsConfig.Description__c,
                eduSettingsConfig.Component_Name__c
            );
            edcSettingsModels.add(edcSettingsModel);
        }*/

        return edcSettingsModels;
    }

    /*private List<EDU_Settings_Config__mdt> getEDUSettingsConfigs() {
        List<EDU_Settings_Config__mdt> eduSettingsConfigs = [
            SELECT Id, MasterLabel, Description__c, Component_Name__c
            FROM EDU_Settings_Config__mdt
        ];
        return eduSettingsConfigs;
    }*/
}
