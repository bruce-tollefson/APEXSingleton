public class profileSingleton {
    // private static variable referencing the class
    private static profileSingleton instance = null;
    public Boolean isInProfileGrouping {get;private set;} // checks if the profile is within the metadata grouping
 
    // The constructor is private and initializes profile grouping check
    private profileSingleton(){
        isApartOfProfileGrouping();
    }
    
    private void isApartOfProfileGrouping(){
        isInProfileGrouping = false;//default to false
        String userProfileName = [Select Name from Profile where Id = :UserInfo.getProfileId()].Name;//get the current User's profile name
        Set<String> ProfileNameSet = new Set<String>();
        for(Profile_List__mdt profile :Profile_List__mdt.getAll().values()){//loop through the list of Profile MDT and check if it contains the value
            if(profile.MasterLabel == userProfileName){
            	isInProfileGrouping=true;
                break;//found a match don't need to go through the rest of the loop
            }
        }  
    }
    // a static method that returns the instance of the record type
    public static profileSingleton getInstance(){
        // lazy load the record type - only initialize if it doesn't already exist
        if(instance == null) instance = new profileSingleton();
        return instance;
    }
}
