({
    deactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deactivateUser");
    },
    reactivateAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.reactivateUser");
    },
    deleteAppUser: function (component, event, helper) {
        helper.performServerCall(component, "c.deleteUser");
    }
});