public with sharing class EDCSettingsModel {
    public Id Id;
    public String masterLabel;
    public String description;
    public String namespace;
    public String componentName;

    public EDCSettingsModel(Id id, String masterLabel, String description, String componentName) {
        this.Id = id;
        this.masterLabel = masterLabel;
        this.description = description;
        this.componentName = componentName;
    }
}
