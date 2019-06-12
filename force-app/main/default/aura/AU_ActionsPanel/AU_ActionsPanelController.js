({
    deactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.deactivateUser");
    },
    reactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.reactivateUser");
    },
    deleteAppUser: function (component, event, helper) {
        const workspaceApi = component.find("workspace"), appUser = component.get("v._appUser");
        helper.openConsentBox(workspaceApi, _ => {
            helper.toggleComponentState(component)
                .then($A.getCallback(_ => helper.performAction(component, "c.deleteUser", {appUser})))
                .catch($A.getCallback(error => {
                    helper.processActionOnFailure(component, error);
                    helper.processActionOnComplete(component);
                }));
        }, {body: `Do you want to completely delete account for ${appUser.Fullname__c}?`});
    },
    resetAppUserPassword: function (component, event, helper) {
        const workspaceApi = component.find("workspace"), appUser = component.get("v._appUser");
        helper.openConsentBox(workspaceApi, _ => {
            // todo - implement;
            alert(`Reset password for ${appUser.Fullname__c}`);
        }, {body: `Do you want to reset password for ${appUser.Fullname__c}?`});
    }
});