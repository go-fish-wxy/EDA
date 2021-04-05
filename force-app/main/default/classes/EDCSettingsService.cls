public virtual with sharing class EDCSettingsService {
    /*********************************************
     * @description Instance for Singleton Pattern
     **********************************************/
    @TestVisible
    private static EDCSettingsService instance;

    /*********************************************************************
     * @description Empty constructor is not public for Singleton Pattern
     **********************************************************************/
    protected EDCSettingsService() {
    }

    /*****************************************************************************
     * @description Static method to get the current instance for Singleton pattern
     * @return The instance of AccountModelSettingsMapper.
     ******************************************************************************/
    public static EDCSettingsService getInstance() {
        if (instance == null) {
            instance = new EDCSettingsService();
        }

        return instance;
    }

    public virtual List<EDCSettingsModel> getEDCSettingsModels() {
        return this.locateEDCSettingsMapper().getEDCSettingsModels();
    }

    private EDCSettingsMapper locateEDCSettingsMapper() {
        return EDCSettingsMapper.getInstance();
    }
}
