({
    deactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deactivateUser");
    },
    reactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.reactivateUser");
    },
    deleteAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deleteUser")
            .then($A.getCallback(_ => {
                const workspaceAPI = component.find("workspace");
                workspaceAPI.getFocusedTabInfo().then(response => workspaceAPI.closeTab({tabId: response.tabId}));
            }));
    }
});