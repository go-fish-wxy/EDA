public with sharing class EDCSettingsModel {
    @AuraEnabled
    public Id Id;

    @AuraEnabled
    public String masterLabel;

    @AuraEnabled
    public String description;

    @AuraEnabled
    public String namespace;

    @AuraEnabled
    public String componentName;

    public EDCSettingsModel(Id id, String masterLabel, String description, String componentName) {
        this.Id = id;
        this.masterLabel = masterLabel;
        this.description = description;
        this.componentName = componentName;
    }
}
