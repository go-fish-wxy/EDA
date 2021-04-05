public with sharing class EDCSettingsController {
    //Get EDU Settings Configs from Custom Metadata Type
    @AuraEnabled(cacheable=true)
    public static List<EDCSettingsModel> getEDCSettingsModels() {
        List<EDCSettingsModel> edcSettingsModels = EDCSettingsController.locateEDCSettingsService()
            .getEDCSettingsModels();
        system.debug(edcSettingsModels);
        return edcSettingsModels;
    }

    @TestVisible
    public static EDCSettingsService locateEDCSettingsService() {
        return EDCSettingsService.getInstance();
    }

    /*@AuraEnabled(cacheable=true)
    //Get Map of description label value by label name
    public static String getDescriptionLabelValue(String descriptionLabelName) {
        Component.Apex.OutputText output = new Component.Apex.OutputText();
        output.expressions.value = '{!$Label.' + descriptionLabelName + '}';
        return String.valueOf(output.expressions.value);
    }*/

    /*
    //Get EDU Settings Configs from Custom Metadata Type
    @AuraEnabled(cacheable=true)
    public static List<EDU_Settings_Config__mdt> getEDCSettingsConfigs() {
        List<EDU_Settings_Config__mdt> edcSettingsConfigs = [
            SELECT Id, MasterLabel, Description__c, Component_Name__c
            FROM EDU_Settings_Config__mdt
        ];
        return edcSettingsConfigs;
    }*/
}
