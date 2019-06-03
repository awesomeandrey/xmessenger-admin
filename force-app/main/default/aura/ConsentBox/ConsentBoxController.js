({
    onConfirm: function (component, event, helper) {
        helper.invokeCallbackFunc(component.get("v.onConfirmFunc"));
        $A.enqueueAction(component.get("c.onCancel"));
    },
    onCancel: function (component, event, helper) {
        component.find("overlayLib").notifyClose();
    }
});