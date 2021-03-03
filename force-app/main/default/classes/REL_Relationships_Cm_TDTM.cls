/*
    Copyright (c) 2013, Salesforce.org
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
 
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.org
* @date 2013
* @group Relationships
* @group-content ../../ApexDocContent/Relationships.htm
* @description Implements relationships behavior on CampaignMember.
*/
public class REL_Relationships_Cm_TDTM extends TDTM_Runnable {

    @testVisible
    private static Boolean reentrancyPrevented;

    public override DmlWrapper run(List<SObject> newList, List<SObject> oldList, 
    TDTM_Runnable.Action triggerAction, Schema.DescribeSObjectResult objResult) {

        List<CampaignMember> newListCasted = (newList == null ? new List<CampaignMember>(): (List<CampaignMember>)newList);
        List<CampaignMember> oldListCasted = (oldList == null ? new List<CampaignMember>(): (List<CampaignMember>)oldList);
        Map<Id, CampaignMember> oldMap = new Map<Id, CampaignMember>(oldListCasted);
            
        DmlWrapper dmlWrapper = new DmlWrapper();

        if (TDTM_ProcessControl.getRecursionFlag(TDTM_ProcessControl.registeredTrigger.REL_Relationships_Cm_TDTM)) {
            reentrancyPrevented = true;
            return dmlWrapper;
         }
        
        List<Id> contactIds = new List<Id>();
        List<Id> reciprocalIds = new List<Id>();
        List<String> types = new List<String>();
        List<Id> cIds = new List<Id>();  
        
        // Create Campaign map based on newMap keyset, then get type and use that map to determine if type matched
        for (CampaignMember cm : newListCasted){
            cIds.add(cm.CampaignId);
        }
        
        Map<Id, Campaign> cMap = new Map<Id, Campaign>([SELECT Id, Type FROM Campaign WHERE Id IN :cIds]);
                
        for (CampaignMember cm : newListCasted){
            // Ignore campaign members for leads
            if (cm.ContactId == null) {
                continue;
            }

            for(String s : REL_Utils.getAutoCreateMap().keySet()){
                Relationship_Auto_Create__c rac = REL_Utils.getAutoCreateMap().get(s);

                if (rac.Object__c != 'CampaignMember' || rac.Campaign_Types__c == null) {
                    continue;
                }
                
                //retrieve the campaign for matching type
                Campaign c = cMap.get(cm.CampaignId);
                UTIL_Debug.debug('****Current Campaign Type: ' + c.Type);
                
                //create a set from the rac
                List<String> cTypeList = rac.Campaign_Types__c.split(';');
                UTIL_Debug.debug('****All Campaign Types: ' + cTypeList);
                Set<String> cTypeSet = new Set<String>();
                cTypeSet.addAll(cTypeList);                            
                
                if (cTypeSet.contains(c.Type)){                     
                    Id relatedContactId;
                    try{
                        //get the id from the field                        
                        relatedContactId = (Id)cm.get(rac.Field__c);
                    }catch(Exception e) {
                        cm.addError(Label.AutoCreateFieldError); 
                    }
                    
                    if(triggerAction == TDTM_Runnable.Action.afterInsert && relatedContactId != null) {                        
                        contactIds.add(cm.ContactId);
                        reciprocalIds.add(relatedContactId);
                        types.add(rac.Relationship_Type__c);
                    } else if (triggerAction == TDTM_Runnable.Action.afterUpdate && relatedContactId != null 
                            && relatedContactId != oldMap.get(cm.id).get(rac.Field__c)){
                        contactIds.add(cm.ContactId);
                        reciprocalIds.add(relatedContactId);
                        types.add(rac.Relationship_Type__c);
                    }
                }              
            }         
        }   

        if (!contactIds.isEmpty()) {
            DmlWrapper w = REL_Relationships_Con_TDTM.createNewRelationships(contactIds, reciprocalIds, types);
            dmlWrapper.objectsToInsert.addAll(w.objectsToInsert);
        }

        TDTM_ProcessControl.setRecursionFlag(TDTM_ProcessControl.registeredTrigger.REL_Relationships_Cm_TDTM, true);
        TDTM_TriggerHandler.processDML(dmlWrapper, true);
        dmlWrapper = null;
        TDTM_ProcessControl.setRecursionFlag(TDTM_ProcessControl.registeredTrigger.REL_Relationships_Cm_TDTM, false);

        return dmlWrapper;
    }
}