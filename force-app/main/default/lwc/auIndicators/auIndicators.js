import {LightningElement, track} from "lwc";
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import getUsersOnline from "@salesforce/apex/AdminController.getUsersOnline";

export default class AuIndicators extends LightningElement {
    @track appUsers = [];
    @track loading = false;

    handleRefreshIndicators() {
        this.loading = true;
        getUsersOnline().then(result => {
            this.appUsers = result;
        }).catch(error => {
            this.appUsers = [];
            console.error(">>>", JSON.stringify(error));
            this.alert({
                variant: "error",
                title: "Could not load user indicators",
                message: "Please, refer to console log for error details."
            });
        }).then(_ => {
            this.loading = false;
        });
    }

    connectedCallback() {
        this.handleRefreshIndicators();
    }

    alert(toastDetails) {
        const event = new ShowToastEvent(toastDetails);
        this.dispatchEvent(event);
    }
}