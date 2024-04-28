import { LightningElement } from 'lwc';
import getTrainDeatails from '@salesforce/apex/trainDetails.getTrainDeatails';

const columns = [
    { label: 'Station Name', fieldName: 'station_name' },
    { label: 'Distance', fieldName: 'distance'},
	{ label: 'Halt', fieldName: 'halt' },
    { label: 'Delay', fieldName: 'delay' },
    { label: 'Platform', fieldName: 'platform' },
	{ label: 'Timing', fieldName: 'timing'},
		
];

export default class LiveTrainTracking extends LightningElement {
    trainNo = '';
    columns = columns;
    showSpinner = false;
    showTrainDeatils = false;
    trainDetails = {};

    handleInputChange(event) {
        this.trainNo = event.target.value;
        console.log(this.trainNo);
    }

    handleClick(){
        this.showSpinner = true;
        this.showTrainDeatils = false;
        getTrainDeatails({trainNo : this.trainNo})
       .then(result => {
            this.showSpinner = false;
            this.showTrainDeatils = true;
            this.trainDetails = result;
            console.log(this.trainDetails);
       })
       .catch(err => {
            this.showTrainDeatils = false;
            console.error(err, errorMessage);
       });
    }
}