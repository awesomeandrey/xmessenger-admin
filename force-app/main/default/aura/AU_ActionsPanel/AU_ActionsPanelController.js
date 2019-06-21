({
    deactivateAppUser: function (component, event, helper) {
        const appUser = helper.copyObject(component.get("v._appUser"));
        appUser.Active__c = false;
        helper.processAction(component, "c.updateUserInfo", {appUser})
            .then($A.getCallback(_ => $A.get("e.force:refreshView").fire()));
    },
    reactivateAppUser: function (component, event, helper) {
        const appUser = helper.copyObject(component.get("v._appUser"));
        appUser.Active__c = true;
        helper.processAction(component, "c.updateUserInfo", {appUser})
            .then($A.getCallback(_ => $A.get("e.force:refreshView").fire()));
    },
    deleteAppUser: function (component, event, helper) {
        const workspaceApi = component.find("workspace"), appUser = component.get("v._appUser");
        helper.openConsentBox(workspaceApi, _ => {
            helper.processAction(component, "c.deleteUser", {appUser})
                .then($A.getCallback(_ => {
                    const error = component.get("v.error");
                    if ($A.util.isEmpty(error)) helper.closeConsoleTab(workspaceApi);
                }));
        }, {body: `Do you want to completely delete account for ${appUser.Name__c}?`});
    },
    resetAppUserPassword: function (component, event, helper) {
        const workspaceApi = component.find("workspace"), appUser = component.get("v._appUser");
        helper.openConsentBox(workspaceApi, _ => {
            // todo - implement;
            alert(`Reset password for ${appUser.Name__c}`);
        }, {body: `Do you want to reset password for ${appUser.Name__c}?`});
    }
});