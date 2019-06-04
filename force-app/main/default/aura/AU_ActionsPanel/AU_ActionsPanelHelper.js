({
    processAction: function (component, controllerMethodName) {
        const appUser = component.get("v._appUser");
        this.toggleComponentState(component)
            .then($A.getCallback(_ => this.performAction(component, controllerMethodName, {appUser})))
            .then($A.getCallback(_ => this.processActionOnSuccess(component)))
            .catch($A.getCallback(error => this.processActionOnFailure(component, error)))
            .then($A.getCallback(_ => this.processActionOnComplete(component)));
    },
    processActionOnSuccess: function (component) {
        const notifLib = component.find("notifLib");
        component.set("v._error", {});
        notifLib.showToast({variant: "success", title: "Done!", message: "User was successfully updated."});
    },
    processActionOnFailure: function (component, error) {
        const notifLib = component.find("notifLib"), errorObj = error[0];
        component.set("v._error", errorObj);
        notifLib.showNotice({variant: "error", header: "Error Occurred", title: "Details", message: errorObj.message});
    },
    processActionOnComplete: function (component) {
        $A.get("e.force:refreshView").fire();
        this.toggleComponentState(component);
    }
});