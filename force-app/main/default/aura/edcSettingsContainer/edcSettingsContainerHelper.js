({
    getLabelValueByName: function (component, edcSettingsModels) {
        let newEDCSettingsModels = [];

        //$Label.c.stgEDASettingsDescription
        //$Label.c.stgSALSettingsDescription

        for (let i in edcSettingsModels) {
            let labelName = edcSettingsModels[i].description;
            let labelReference = $A.getReference("$Label.c." + labelName);
            component.set("v.tempLabelAttr", labelReference);
            let dynamicLabel = component.get("v.tempLabelAttr");
            let newEDCSettingsModel = {
                id: edcSettingsModels[i].Id,
                description: dynamicLabel,
                masterLabel: edcSettingsModels[i].masterLabel,
                componentName: edcSettingsModels[i].componentName
            };
            newEDCSettingsModels.push(newEDCSettingsModel);
        }

        component.set("v.newEDCSettingsModels", newEDCSettingsModels);
    }
});
