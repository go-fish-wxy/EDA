({
    getLabelValueByName: function (component, event, helper) {
        event.stopPropagation();
        helper.getLabelValueByName(component, event.getParam("edcSettingsModels"));
    }
});
