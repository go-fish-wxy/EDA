import { LightningElement, wire, track } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import getEDCSettingsConfigs from "@salesforce/apex/EDCSettingsController.getEDCSettingsConfigs";
export default class EdcSettings extends NavigationMixin(LightningElement) {
    @wire(getEDCSettingsConfigs) edcSettingsConfigs;

    handleNavigationClick(event) {
        event.preventDefault();
        console.log("Navigating to: " + event.currentTarget.dataset.componentName);
        const pageReference = {
            type: "standard__component",
            attributes: {
                componentName: event.currentTarget.dataset.componentName,
            },
            state: {},
        };
        this[NavigationMixin.Navigate](pageReference);
    }
}
