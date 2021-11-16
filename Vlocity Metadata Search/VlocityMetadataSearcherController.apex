public class VlocityMetadataSearcherController {
    
    @AuraEnabled
    public static List<Map<String, Object>> getMetadataDataRaptor(String objectName, String fieldName){

        List<Map<String, Object>> result = new List<Map<String, Object>>();
        Map<String, Object> outMap;

        List<vlocity_cmt__DRMapItem__c> drList = [SELECT CreatedBy.UserName,Id,IsDeleted,LastModifiedBy.UserName,LastModifiedDate,Name FROM vlocity_cmt__DRMapItem__c where vlocity_cmt__DomainObjectAPIName__c = :objectName AND vlocity_cmt__DomainObjectFieldAPIName__c = :fieldName];
        for (vlocity_cmt__DRMapItem__c item : drList) {
            outMap = new Map<String, Object>();
            outMap.put('Link', URL.getSalesforceBaseUrl().toExternalForm() + '/' +item.Id);
            outMap.put('Id', item.Id);
            outMap.put('Name', item.Name);
            outMap.put('CreateBy', item.CreatedBy.UserName);
            outMap.put('LastModifyBy', item.LastModifiedBy.UserName);
            outMap.put('LastModifyDate', item.LastModifiedDate);

            result.add(outMap);
        }
        if (result.size() == 0)
        {
            outMap = new Map<String, Object>();
            outMap.put('codError', '101');
            outMap.put('descError', 'No data found.');
            result.add(outMap);
        }
        return result;
    }

    @AuraEnabled
    public static List<Map<String, Object>> getMetadataCards(String search){

        List<Map<String, Object>> result = new List<Map<String, Object>>();
        Map<String, Object> outMap;
        String searchText = search;
        Boolean isActive = true;

        List<vlocity_cmt__VlocityCard__c> objCard = [SELECT CreatedById,
                CreatedDate,
                Id,
                LastModifiedById,
                LastModifiedDate,
                Name,
                vlocity_cmt__Active__c,
                vlocity_cmt__Definition__c,
                vlocity_cmt__Type__c,
                vlocity_cmt__Version__c 
                FROM vlocity_cmt__VlocityCard__c 
                WHERE vlocity_cmt__Active__c =: isActive];

        for (vlocity_cmt__VlocityCard__c element : objCard) {
            outMap = new Map<String, Object>();
            Map<String, Object> elementProperties = new Map<String, Object>();
            
           

            if (element.vlocity_cmt__Definition__c.contains(searchText)) {
                System.debug('Elemento: '+ element.vlocity_cmt__Definition__c);
                elementProperties = (Map<String, Object>) JSON.deserializeUntyped(element.vlocity_cmt__Definition__c);
            }
        
            if (!elementProperties.isEmpty()) {
                Map<String, Object> elementProperties2 = (Map<String, Object>) elementProperties.get('dataSource');
                Map<String, Object> elementValue = (Map<String, Object>) elementProperties2.get('value');
                List<Object> listStatesProperties = (List<Object>) elementProperties.get('states');
                
                for(Object stateProperties : listStatesProperties)
                {
                    Map<String, Object> mapStateProperties = (Map<String, Object>)stateProperties;
                    outMap.put('Name', mapStateProperties.get('name'));
                    outMap.put('TemplateName', mapStateProperties.get('templateUrl'));
                    System.debug('Name: '+mapStateProperties.get('name'));
                    System.debug('Template Name: '+mapStateProperties.get('templateUrl'));
                }
                
                /*System.debug('Nombre del Card: '+element.Name);
                System.debug('ID del Card: '+element.Id);
                System.debug('DataSource Type: '+ elementProperties2.get('type'));
                System.debug('remoteClass: '+elementValue.get('remoteClass'));
                System.debug('remoteMethod: '+elementValue.get('remoteMethod'));
                System.debug('Version: '+element.get('vlocity_cmt__Version__c'));*/
                System.debug('Title: '+ elementProperties.get('title'));
                outMap.put('Title', elementProperties.get('title'));
                outMap.put('Name', element.Name);
                outMap.put('Id', element.Id);
                outmap.put('Version', element.get('vlocity_cmt__Version__c'));
                outMap.put('dataSourceType', elementProperties2.get('type'));
                outMap.put('remoteClass', elementValue.get('remoteClass'));
                outMap.put('remoteMethod', elementValue.get('remoteMethod'));
                result.add(outMap);
            } 
        }
        if (result.size() == 0)
        {
            outMap = new Map<String, Object>();
            outMap.put('codError', '101');
            outMap.put('descError', 'No data found.');
            result.add(outMap);
        }
        return result;
    }

    @AuraEnabled
    public static List<Map<String, Object>> getMetadataOmniscripts(String search, String strElement){

        List<Map<String, Object>> result = new List<Map<String, Object>>();
        Map<String, Object> outMap;
        String searchText = search;
        Boolean isActive = true;
        List<vlocity_cmt__Element__c> elements;

        if(strElement == 'C')
        {
            elements = [
                SELECT Id,
                    Name,
                    vlocity_cmt__PropertySet__c,
                    vlocity_cmt__OmniScriptId__r.Name,
                    vlocity_cmt__OmniScriptId__r.vlocity_cmt__Type__c,
                    vlocity_cmt__OmniScriptId__r.vlocity_cmt__SubType__c,
                    vlocity_cmt__OmniScriptVersion__c
                FROM vlocity_cmt__Element__c
                WHERE vlocity_cmt__Active__c = :isActive
            ];
        }
        else{
            elements = [
                SELECT Id,
                    Name,
                    vlocity_cmt__PropertySet__c,
                    vlocity_cmt__OmniScriptId__r.Name,
                    vlocity_cmt__OmniScriptId__r.vlocity_cmt__Type__c,
                    vlocity_cmt__OmniScriptId__r.vlocity_cmt__SubType__c,
                    vlocity_cmt__OmniScriptVersion__c
                FROM vlocity_cmt__Element__c
                WHERE vlocity_cmt__Type__c = :strElement
                    AND vlocity_cmt__Active__c = :isActive
            ];
        }

        for (vlocity_cmt__Element__c element : elements) {
            outMap = new Map<String, Object>();
            Map<String, Object> elementProperties = new Map<String, Object>();
            
            if (element.vlocity_cmt__PropertySet__c.contains(searchText)) {
                elementProperties = (Map<String, Object>) JSON.deserializeUntyped(element.vlocity_cmt__PropertySet__c);
            }
            
            if (!elementProperties.isEmpty()) {
                //System.Debug('elementProperties: ' + JSON.serialize(elementProperties));
                String namedCredential = (String) elementProperties.get('namedCredential');
                
                //if (String.isNotBlank(namedCredential) && namedCredential != 'tempAuth') {
                    outMap.put('namedCredential',elementProperties.get('namedCredential'));
                    outMap.put('type',element.vlocity_cmt__OmniScriptId__r.vlocity_cmt__Type__c);
                    outMap.put('subtype',element.vlocity_cmt__OmniScriptId__r.vlocity_cmt__SubType__c);
                    outMap.put('name',element.vlocity_cmt__OmniScriptId__r.Name);
                    outMap.put('version',element.vlocity_cmt__OmniScriptVersion__c);
                    outMap.put('elementName', element.Name);
                    result.add(outMap);
                //}
            }
        }
        if (result.size() == 0)
        {
            outMap = new Map<String, Object>();
            outMap.put('codError', '101');
            outMap.put('descError', 'No data found.');
            result.add(outMap);
        }
        return result;
    }

    @AuraEnabled
    public static List<Map<String, Object>> getMetadataTemplate(String search, String txtName){

        List<Map<String, Object>> result = new List<Map<String, Object>>();
        Map<String, Object> outMap;
        String searchText = search;
        Boolean isActive = true;
        List<vlocity_cmt__VlocityUITemplate__c> objCard;

        if(txtName == '' || String.isEmpty(txtName))
        {
            objCard = [SELECT Id,
                    Name,
                    vlocity_cmt__CSS__c,
                    vlocity_cmt__CustomJavascript__c,
                    vlocity_cmt__Definition__c,
                    vlocity_cmt__HTML__c,
                    vlocity_cmt__Sass__c,
                    vlocity_cmt__Type__c,
                    vlocity_cmt__Version__c 
                    FROM vlocity_cmt__VlocityUITemplate__c 
                    WHERE vlocity_cmt__Active__c =: isActive 
                    ];
        }
        else{
            objCard = [SELECT Id,
                    Name,
                    vlocity_cmt__CSS__c,
                    vlocity_cmt__CustomJavascript__c,
                    vlocity_cmt__Definition__c,
                    vlocity_cmt__HTML__c,
                    vlocity_cmt__Sass__c,
                    vlocity_cmt__Type__c,
                    vlocity_cmt__Version__c 
                    FROM vlocity_cmt__VlocityUITemplate__c 
                    WHERE vlocity_cmt__Active__c =: isActive 
                    AND Name =: txtName
                    ];
        }
        for (vlocity_cmt__VlocityUITemplate__c element : objCard) {
            Map<String, Object> elementProperties = new Map<String, Object>();
            if( element != null)
            {
                if (element.vlocity_cmt__CustomJavascript__c != null && element.vlocity_cmt__CustomJavascript__c.contains(searchText)) {
                    outMap = new Map<String, Object>();
                    System.debug('Type: JavaScript');
                    System.debug('Elemento: '+ element.get('vlocity_cmt__CustomJavascript__c'));
                    outMap.put('Id', element.get('Id'));
                    outMap.put('Name', element.get('Name'));
                    outMap.put('Type', 'JavaScript');
                    outMap.put('JavaScript', element.get('vlocity_cmt__CustomJavascript__c'));
                    outMap.put('HTML', element.get('vlocity_cmt__HTML__c'));
                    outMap.put('CSS', element.get('vlocity_cmt__CSS__c'));
                    outMap.put('Version', element.get('vlocity_cmt__Version__c'));
                    //elementProperties = (Map<String, Object>) JSON.deserializeUntyped(element.vlocity_cmt__CustomJavascript__c);
                    result.add(outMap);
                }

                if (element.vlocity_cmt__CustomJavascript__c != null && element.vlocity_cmt__HTML__c.contains(searchText)) {
                    outMap = new Map<String, Object>();
                    outMap.put('Id', element.get('Id'));
                    outMap.put('Name', element.get('Name'));
                    outMap.put('Type', 'HTML');
                    outMap.put('JavaScript', element.get('vlocity_cmt__CustomJavascript__c'));
                    outMap.put('HTML', element.get('vlocity_cmt__HTML__c'));
                    outMap.put('CSS', element.get('vlocity_cmt__CSS__c'));
                    outMap.put('Version', element.get('vlocity_cmt__Version__c'));
                    result.add(outMap);
                }
                
            }
        }
        if (result.size() == 0)
        {
            outMap = new Map<String, Object>();
            outMap.put('codError', '101');
            outMap.put('descError', 'No data found.');
            result.add(outMap);
        }
        return result;
    }
}
