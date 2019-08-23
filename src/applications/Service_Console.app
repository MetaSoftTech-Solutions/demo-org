<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <brand>
        <headerColor>#0070D2</headerColor>
        <shouldOverrideOrgTheme>false</shouldOverrideOrgTheme>
    </brand>
    <formFactors>Large</formFactors>
    <isNavAutoTempTabsDisabled>false</isNavAutoTempTabsDisabled>
    <isNavPersonalizationDisabled>false</isNavPersonalizationDisabled>
    <label>Service Console</label>
    <navType>Console</navType>
    <tabs>standard-Account</tabs>
    <tabs>standard-Asset</tabs>
    <tabs>standard-Case</tabs>
    <uiType>Lightning</uiType>
    <utilityBar>Service_Console_UtilityBar</utilityBar>
    <workspaceConfig>
        <mappings>
            <tab>standard-Account</tab>
        </mappings>
        <mappings>
            <fieldName>AccountId</fieldName>
            <tab>standard-Asset</tab>
        </mappings>
        <mappings>
            <fieldName>AccountId</fieldName>
            <tab>standard-Case</tab>
        </mappings>
    </workspaceConfig>
</CustomApplication>
