({
    deactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.deactivateUser");
    },
    reactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.reactivateUser");
    },
    deleteAppUser: function (component, event, helper) {
        const workspaceApi = component.find("workspace");
        $A.createComponent("c:ConsentBox",
            {
                onConfirmFunc: _ => {
                    const appUser = component.get("v._appUser");
                    helper.toggleComponentState(component)
                        .then($A.getCallback(_ => helper.performAction(component, "c.deleteUser", {appUser})))
                        .then($A.getCallback(_ => helper.closeConsoleTab(workspaceApi)))
                        .catch($A.getCallback(error => {
                            helper.processActionOnFailure(component, error);
                            helper.processActionOnComplete(component);
                        }));
                }
            }, formComponent => helper.showCustomModal({
                header: "Consent Screen", showCloseButton: false,
                body: "Do you want to completely delete user account?", footer: formComponent
            }));
    }
});