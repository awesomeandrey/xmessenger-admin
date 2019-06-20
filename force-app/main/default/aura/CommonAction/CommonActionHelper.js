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
    showCustomModal: function (modalParams) {
        $A.createComponent("lightning:overlayLibrary", {},
            (overlayLib, status) => {
                if (status === "SUCCESS") {
                    const customCloseCallback = modalParams.closeCallback;
                    modalParams.closeCallback = _ => {
                        // Execute custom callback function if present;
                        this.invokeCallbackFunc(customCloseCallback);
                        // Destroy modal component;
                        overlayLib.destroy();
                    };
                    overlayLib.showCustomModal(modalParams)
                }
            });
    },
    toggleComponentState: function (component) {
        if (!!component && component.isInstanceOf('c:Stateful')) {
            component.set("v.loading", !component.get("v.loading"));
            return Promise.resolve(true);
        } else {
            return Promise.reject("Passed components does not implement 'c:Stateful' interface.");
        }
    },
    invokeCallbackFunc: function (callback, params) {
        if (!!callback && typeof callback === "function") {
            callback(params || {});
        }
    },
    closeConsoleTab: function (workspaceApi) {
        return workspaceApi.getFocusedTabInfo().then(response => {
            workspaceApi.closeTab({tabId: response.tabId});
        });
    },
    openConsentBox: function (workspaceApi, onConfirmFunc, boxDetails) {
        $A.createComponent("c:ConsentBox",
            {onConfirmFunc}, formComponent => {
                boxDetails = Object.assign({
                    header: "Consent Screen",
                    showCloseButton: false,
                    footer: formComponent
                }, boxDetails);
                this.showCustomModal(boxDetails);
            });
    },
    copyObject: function iterationCopy(sourceObject) {
        let targetObject = {};
        for (let prop in sourceObject) {
            if (sourceObject.hasOwnProperty(prop)) {
                targetObject[prop] = sourceObject[prop];
            }
        }
        return targetObject;
    }
});