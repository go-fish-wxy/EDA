import { LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class EdcSettings extends NavigationMixin(LightningElement) {
    viewModel = {
        cards: [
            {
                label: "EDA",
                body: "EDA is a product and this is some really long text",
                componentName: "c__edaSettingsContainer",
            },
            {
                label: "Health Check",
                body: "Health check is nifty!",
                componentName: "c__healthCheckContainer",
            },
        ],
    };

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
