({
    performAction: function (component, actionName, actionParams) {
        return new Promise($A.getCallback(function (resolve, reject) {
            let action = component.get(actionName);
            action.setParams(actionParams || {});
            action.setCallback(this, function (response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    let result = response.getReturnValue();
                    resolve(result);
                } else if (state === 'ERROR') {
                    reject(response.getError());
                }
            });
            // Initiate process;
            $A.enqueueAction(action);
        }));
    },
    navigateToRecord: function (recordId) {
        const navigationEvt = $A.get("e.force:navigateToSObject");
        navigationEvt.setParams({
            "recordId": recordId
        });
        navigationEvt.fire();
    },
    showCustomModal: function (modalParams) {
        $A.createComponent("lightning:overlayLibrary", {},
            (overlayLib, status) => {
                if (status === "SUCCESS") {
                    const customCloseCallback = modalParams.closeCallback;
                    modalParams.closeCallback = _ => {
                        if (!!customCloseCallback) {
                            // Execute custom callback function if present;
                            customCloseCallback();
                        }
                        // Destroy modal component;
                        overlayLib.destroy();
                    };
                    overlayLib.showCustomModal(modalParams)
                }
            });
    },
    notify: function (params) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(params);
        toastEvent.fire();
    },
    showSpinner: function (component) {
        $A.util.removeClass(component.find("spinner"), "slds-hide");
    },
    hideSpinner: function (component) {
        $A.util.addClass(component.find("spinner"), "slds-hide");
    },
    toggleComponentState: function (component) {
        if (!!component && component.isInstanceOf('c:Stateful')) {
            component.set("v.loading", !component.get("v.loading"))
        } else {
            console.warn("Passed components does not implement 'c:Stateful' interface.");
        }
    }
});