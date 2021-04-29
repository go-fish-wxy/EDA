/*
    Copyright (c) 2021, Salesforce.org
    All rights reserved.
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this List of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this List of conditions and the following disclaimer in the
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
 * @date 2021
 * @group
 * @group-content ../../ApexDocContent/
 * @description Model to represent data required for Affiliations
 * created with Program Enrollments funtionality.
 */
public with sharing class AffiliationsWithProgramEnrollmentModel {
    public Boolean specifyRole { get; private set; }
    public String role { get; private set; }
    public String status { get; private set; }
    public Boolean copyEndDate { get; private set; }
    public Boolean copyStartDate { get; private set; }

    /*****************************************************************************************************************
     * @description Five argument constructor
     * @param  specifyRole A boolean value representing the Affl_ProgEnroll_Set_Role__c setting in Hierarchy Settings
     * @param  role A String representing the Affl_ProgEnroll_Role_Map__c setting in Hierarchy Settings
     * @param  status A String representing the Affl_ProgEnroll_Status_Map__c setting in Hierarchy Settings
     * @param  copyEndDate A boolean value representing the Affl_ProgEnroll_Copy_End_Date__c setting in Hierarchy Settings
     * @param  copyStartDate A boolean value representing the Affl_ProgEnroll_Start_End_Date__c setting in Hierarchy Settings
     *****************************************************************************************************************/
    public AffiliationsWithProgramEnrollmentModel(
        Boolean specifyRole,
        String role,
        String status,
        Boolean copyEndDate,
        Boolean copyStartDate
    ) {
        this.specifyRole = specifyRole;
        this.role = role;
        this.status = status;
        this.copyEndDate = copyEndDate;
        this.copyStartDate = copyStartDate;
    }
}