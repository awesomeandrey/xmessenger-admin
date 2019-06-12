({
    processAction: function (component, controllerMethodName) {
        const appUser = component.get("v._appUser");
        return this.toggleComponentState(component)
            .then($A.getCallback(_ => this.performAction(component, controllerMethodName, {appUser})))
            .then($A.getCallback(_ => this.processActionOnSuccess(component)))
            .catch($A.getCallback(error => this.processActionOnFailure(component, error)))
            .then($A.getCallback(_ => this.toggleComponentState(component)));
    },
    processActionOnSuccess: function (component) {
        const notificationLib = component.find("notificationLib");
        component.set("v.error", {});
        notificationLib.showToast({variant: "success", title: "Done!", message: "User was successfully updated."});
    },
    processActionOnFailure: function (component, error) {
        const notificationLib = component.find("notificationLib"), errorObj = error[0];
        component.set("v.error", errorObj);
        notificationLib.showNotice({
            variant: "error",
            header: "Error Occurred",
            title: "Details",
            message: errorObj.message
        });
    },
    openConsentBox: function (workspaceApi, onConfirmFunc, boxDetails) {
        $A.createComponent("c:ConsentBox",
            {onConfirmFunc}, formComponent => {
                boxDetails = Object.assign({
                    header: "Consent Screen",
                    showCloseButton: false,
                    footer: formComponent
                }, boxDetails);
                this.showCustomModal(boxDetails);
            });
    }
});