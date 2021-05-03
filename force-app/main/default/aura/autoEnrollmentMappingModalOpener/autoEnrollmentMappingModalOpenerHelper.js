({
    openAutoEnrollmentMappingModal: function (component, eventParameters) {
        const actionName = eventParameters.actionName;
        const mappingName = eventParameters.mappingName;
        const accountRecordType = eventParameters.accountRecordType;
        const autoProgramEnrollmentStatus = eventParameters.autoProgramEnrollmentStatus;
        const autoProgramEnrollmentRole = eventParameters.autoProgramEnrollmentRole;

        component.set("v.actionName", actionName);
        component.set("v.mappingName", mappingName);
        component.set("v.accountRecordType", accountRecordType);
        component.set("v.autoProgramEnrollmentStatus", autoProgramEnrollmentStatus);
        component.set("v.autoProgramEnrollmentRole", autoProgramEnrollmentRole);

        let modalBody;
        let modalFooter;

        let modalHeaderLabel;
        let confirmButton;
        let cancelButton;

        switch (component.get("v.actionName")) {
            /*case "create":
                modalHeaderLabel = $A.get("$Label.c.stgNewAfflMapping");
                confirmButton = $A.get("$Label.c.stgBtnSave");
                cancelButton = $A.get("$Label.c.stgBtnCancel");
                break;*/
            case "edit":
                modalHeaderLabel = $A.get("$Label.c.stgAutoEnrollmentEditModalTitle");
                confirmButton = $A.get("$Label.c.stgBtnSave");
                cancelButton = $A.get("$Label.c.stgBtnCancel");
                break;
            /*case "delete":
                modalHeaderLabel = $A.get("$Label.c.stgAffiliationsDeleteModalTitle");
                cancelButton = $A.get("$Label.c.stgBtnCancel");
                confirmButton = $A.get("$Label.c.stgBtnDelete");
                break;*/
        }

        $A.createComponents(
            [
                [
                    "c:autoEnrollmentMappingModal",
                    {
                        actionName: component.get("v.actionName"),
                        accountRecordType: component.get("v.accountRecordType"),
                        autoProgramEnrollmentStatus: component.get("v.autoProgramEnrollmentStatus"),
                        autoProgramEnrollmentRole: component.get("v.autoProgramEnrollmentRole"),
                        modalDataChangeEvent: component.getReference("c.handleModalDataChangeEvent")
                    }
                ],
                [
                    "c:customModalFooter",
                    {
                        confirmButtonLabel: confirmButton,
                        confirmButtonTitle: confirmButton,
                        cancelButtonLabel: cancelButton,
                        cancelButtonTitle: cancelButton,
                        customModalFooterEvent: component.getReference("c.handleModalFooterEvent")
                    }
                ]
            ],
            function (components, status) {
                if (status === "SUCCESS") {
                    modalBody = components[0];
                    modalFooter = components[1];
                    //Create the modal
                    component.find("edaOverlayLibrary").showCustomModal({
                        header: modalHeaderLabel,
                        body: modalBody,
                        footer: modalFooter,
                        showCloseButton: false
                    });
                }
            }
        );
    },
    handleModalDataChangeEvent: function (component, event) {
        event.stopPropagation();
        const field = event.getParam("field");
        const fieldValue = event.getParam("fieldValue");
        switch (field) {
            case "autoProgramEnrollmentStatus":
                component.set("v.autoProgramEnrollmentStatus", fieldValue);
                break;
            case "autoProgramEnrollmentRole":
                component.set("v.autoProgramEnrollmentRole", fieldValue);
                break;
        }
    },
    handleModalFooterEvent: function (component, event) {
        event.stopPropagation();
        switch (event.getParam("action")) {
            case "confirm":
                this.handleModalFooterConfirm(component);
                break;
        }
    },
    handleModalFooterConfirm: function (component) {
        switch (component.get("v.actionName")) {
            /*case "create":
                this.handleModalCreateConfirm(component);
                break;*/
            case "edit":
                this.handleModalEditConfirm(component);
                break;
            /*case "delete":
                this.handleModalDeleteConfirm(component);
                break;*/
        }
    },

    handleModalEditConfirm: function (component) {
        let modalSaveEvent = component.getEvent("modalSaveEvent");

        const actionName = component.get("v.actionName");
        const mappingName = component.get("v.mappingName");
        const autoProgramEnrollmentStatus = component.get("v.autoProgramEnrollmentStatus");
        const autoProgramEnrollmentRole = component.get("v.autoProgramEnrollmentRole");

        const saveModel = {
            modalType: "autoenrollmentmapping",
            action: actionName,
            mappingName: mappingName,
            autoProgramEnrollmentStatus: autoProgramEnrollmentStatus,
            autoProgramEnrollmentRole: autoProgramEnrollmentRole
        };
        console.log(saveModel);
        modalSaveEvent.setParams({
            saveModel: saveModel
        });
        modalSaveEvent.fire();
    }
    /*
    handleModalDeleteConfirm: function (component) {
        let modalSaveEvent = component.getEvent("modalSaveEvent");

        const mappingName = component.get("v.mappingName");
        const affiliationsAction = component.get("v.affiliationsAction");
        const accountRecordType = component.get("v.accountRecordType");
        const contactField = component.get("v.contactField");
        const autoProgramEnrollment = component.get("v.autoProgramEnrollment");

        const saveModel = {
            modalType: "affiliations",
            action: affiliationsAction,
            mappingName: mappingName,
            accountRecordType: accountRecordType,
            contactField: contactField,
            autoEnrollmentEnabled: autoProgramEnrollment
        };

        modalSaveEvent.setParams({
            saveModel: saveModel
        });
        modalSaveEvent.fire();
    },
    handleModalCreateConfirm: function (component) {
        let modalSaveEvent = component.getEvent("modalSaveEvent");

        const mappingName = component.get("v.accountRecordType");
        const affiliationsAction = component.get("v.affiliationsAction");
        const accountRecordType = component.get("v.accountRecordType");
        const contactField = component.get("v.contactField");

        const saveModel = {
            modalType: "affiliations",
            action: affiliationsAction,
            mappingName: mappingName,
            accountRecordType: accountRecordType,
            contactField: contactField
        };

        modalSaveEvent.setParams({
            saveModel: saveModel
        });
        modalSaveEvent.fire();
    }*/
});