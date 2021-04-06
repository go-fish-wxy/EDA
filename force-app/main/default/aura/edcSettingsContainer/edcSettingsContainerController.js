({
    getLabelValueByName: function (component, event) {
        let labelValueByName = new Map();

        let newEdcSettingsModels = event.getParam("edcSettingsModels");
        console.log(newEdcSettingsModels);

        for (let i in newEdcSettingsModels) {
            labelValueByName.set(newEdcSettingsModels[i].description, "okok");
        }

        component.set("v.labelValueByName", labelValueByName);
    }
});
