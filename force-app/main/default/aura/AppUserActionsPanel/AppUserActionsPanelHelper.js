({
    performServerCall: function (component, controllerMethodName) {
        this.toggleComponentState(component);
        const notifLib = component.find("notifLib"), appUser = component.get("v._appUser");
        return this.performAction(component, controllerMethodName, {appUser})
            .then($A.getCallback(_ => {
                component.set("v._error", {});
                notifLib.showToast({
                    variant: "success", title: "Done",
                    message: "User was successfully updated.",
                });
            }))
            .catch($A.getCallback(error => {
                let errorObj = error[0];
                component.set("v._error", errorObj);
                notifLib.showNotice({
                    variant: "error", header: "Error Occurred",
                    title: "Details", message: errorObj.message,
                });
            }))
            .then($A.getCallback(_ => {
                $A.get('e.force:refreshView').fire();
                this.toggleComponentState(component);
            }));
    }
});