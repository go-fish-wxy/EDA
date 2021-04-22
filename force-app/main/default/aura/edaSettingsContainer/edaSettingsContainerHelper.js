({
    setPageReference: function (component) {
        const componentPageReference = component.get("v.pageReference");
        component.set("v.pageReference", componentPageReference);
    },
    openPrimaryAffiliationModal: function (component, eventParameters) {
        const mappingName = eventParameters.mappingName;
        const affiliationsAction = eventParameters.affiliationsAction;
        const accountRecordType = eventParameters.accountRecordType;
        const contactField = eventParameters.contactField;
        const autoProgramEnrollment = eventParameters.autoProgramEnrollment;

        component
            .find("primaryAffiliationsModal")
            .openPrimaryAffiliationsModal(
                affiliationsAction,
                mappingName,
                accountRecordType,
                contactField,
                autoProgramEnrollment
            );
    },
    handleModalSaveEvent: function (component, saveModel) {
        const edaSettings = component.find("edaSettings");
        const edaSettingsElement = edaSettings.getElement();
        edaSettingsElement.modalSave(saveModel);
    }
});
