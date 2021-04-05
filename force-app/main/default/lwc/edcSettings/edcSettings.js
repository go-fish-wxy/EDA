import { LightningElement, api, wire, track } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import getEDCSettingsModels from "@salesforce/apex/EDCSettingsController.getEDCSettingsModels";
export default class EdcSettings extends NavigationMixin(LightningElement) {
    @wire(getEDCSettingsModels) edcSettingsModels;

    connectedCallback() {
        console.log(edcSettingsModels);

        const handleDynamicLabelEvent = new CustomEvent("handleDynamicLabel", {
            detail: { edcSettingsModels },
        });

        this.dispatchEvent(handleDynamicLabelEvent);
    }

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
