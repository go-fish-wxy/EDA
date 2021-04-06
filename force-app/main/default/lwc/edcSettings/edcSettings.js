import { LightningElement, api, wire, track } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import getEDCSettingsModels from "@salesforce/apex/EDCSettingsController.getEDCSettingsModels";
export default class EdcSettings extends NavigationMixin(LightningElement) {
    @api labelValueByName;

    @track edcSettingsModels;
    @track edcSettingsWireResult;

    @wire(getEDCSettingsModels)
    edcSettingsVModelWire(result) {
        this.edcSettingsWireResult = result;
        if (result.data) {
            this.edcSettingsModels = result.data;
            this.handleLabels(result.data);
        } else if (result.error) {
            //console.log("error retrieving edcSettingsVModel");
        }
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

    handleLabels(edcSettingsModels) {
        const handleDynamicLabelEvent = new CustomEvent("handleDynamicLabel", {
            detail: { edcSettingsModels },
        });
        this.dispatchEvent(handleDynamicLabelEvent);
    }
}
