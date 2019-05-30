({
    deactivateAppUser: function (component, event, helper) {
        helper.toggleComponentState(component);
        const notifLib = component.find("notifLib");
        component.find("recordLoader").reloadRecord(false, _ => {
            const appUser = component.get("v._appUser");
            helper.performAction(component, "c.deactivateUser", {appUser})
                .then($A.getCallback(_ => {
                    notifLib.showToast({
                        variant: "success", title: "Done",
                        message: "User was successfully deactivated.",
                    });
                    $A.get('e.force:refreshView').fire();
                    $A.get("e.force:closeQuickAction").fire();
                }))
                .catch($A.getCallback(error => {
                    notifLib.showNotice({
                        variant: "error", header: "Error Occurred",
                        title: "Details", message: error[0].message,
                    });
                    helper.toggleComponentState(component);
                }));
        });
    }
});