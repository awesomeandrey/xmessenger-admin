({
    deactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.deactivateUser")
            .then($A.getCallback(_ => $A.get("e.force:refreshView").fire()));
    },
    reactivateAppUser: function (component, event, helper) {
        helper.processAction(component, "c.reactivateUser")
            .then($A.getCallback(_ => $A.get("e.force:refreshView").fire()));
    },
    deleteAppUser: function (component, event, helper) {
        const workspaceApi = component.find("workspace"), appUser = component.get("v._appUser");
        helper.openConsentBox(workspaceApi, _ => {
            helper.processAction(component, "c.deleteUser")
                .then($A.getCallback(_ => {
                    const error = component.get("v.error");
                    if ($A.util.isEmpty(error)) helper.closeConsoleTab(workspaceApi);
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