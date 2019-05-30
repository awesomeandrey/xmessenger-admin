({
    performServerCall: function (component, controllerMethodName) {
        this.toggleComponentState(component);
        const notifLib = component.find("notifLib");
        component.find("recordLoader").reloadRecord(false, _ => {
            const appUser = component.get("v._appUser");
            this.performAction(component, controllerMethodName, {appUser})
                .then($A.getCallback(_ => notifLib.showToast({
                    variant: "success", title: "Done",
                    message: "User was successfully updated.",
                })))
                .catch($A.getCallback(error => notifLib.showNotice({
                    variant: "error", header: "Error Occurred",
                    title: "Details", message: error[0].message,
                })))
                .then($A.getCallback(_ => {
                    $A.get('e.force:refreshView').fire();
                    this.toggleComponentState(component);
                }));
        });
    }
});