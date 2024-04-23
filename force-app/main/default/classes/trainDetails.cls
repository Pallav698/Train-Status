public with sharing class trainDetails {
    @AuraEnabled
    public static trainDeatilsWrapper getTrainDeatails(String trainNo){
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://rappid.in/apis/train.php?train_no=' + trainNo);
            req.setMethod('GET');
            HttpResponse res = http.send(req);

            trainDeatilsWrapper trainDetail = new TrainDeatilsWrapper();
            if(res.getStatusCode() == 200){
                trainDetail = (trainDeatilsWrapper)JSON.deserialize(res.getBody(), trainDeatilsWrapper.class);
            }
            return trainDetail;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class TrainDeatilsWrapper{
        @AuraEnabled public boolean success {get; set;}
        @AuraEnabled public String train_name {get; set;}
        @AuraEnabled public String message {get; set;}
        @AuraEnabled public String update_time {get; set;}
        @AuraEnabled public List<Data> data {get; set;}
    }

    public class Data{
        @AuraEnabled public boolean is_current_station {get; set;}
        @AuraEnabled public String station_name {get; set;}
        @AuraEnabled public String train_no {get; set;}
        @AuraEnabled public String distance {get; set;}
        @AuraEnabled public String timing {get; set;}
        @AuraEnabled public String platform {get; set;}
        @AuraEnabled public String halt {get; set;}
    }
}