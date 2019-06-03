({
    deactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deactivateUser");
    },
    reactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.reactivateUser");
    },
    deleteAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deleteUser");
            // .then($A.getCallback(_ => {
            //     const error = component.get("v.error"), workspaceAPI = component.find("workspace");
            //     debugger;
            //     if ($A.util.isEmpty(error)) {
            //         workspaceAPI.getFocusedTabInfo().then(response => workspaceAPI.closeTab({tabId: response.tabId}));
            //     }
            // }));
    }
});