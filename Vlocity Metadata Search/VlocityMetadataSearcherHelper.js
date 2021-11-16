({                  
	serverCall : function(component,event) {		
        var txtSearch = component.get("v.txtContact"); //component.find("txtContactName").get("v.value"); //
        var selectedOption = component.find("mySelect").get("v.value");
        var action;
        if(selectedOption == 'Cards'){
        action = component.get("c.getMetadataCards");
        action.setParams({
                search : txtSearch 
            });
        }
        else
        {
            if(selectedOption == 'DataRaptors'){
                var txtField = component.get("v.txtFiledName");
                action = component.get("c.getMetadataDataRaptor");
                action.setParams({
                        objectName : txtSearch,
                    	fieldName : txtField
                    });
            }
            else 
                if(selectedOption == 'Omniscripts'){        
                    var SelectedElement = component.find("mySelectecElement").get("v.value");
                    action = component.get("c.getMetadataOmniscripts");
                    action.setParams({
                        	search : txtSearch,
                        	strElement: SelectedElement.toString()
                            
                        	
                        });                  
                }
            	else
                   if(selectedOption == 'Templates'){        
                   	var objTemplate = component.get("v.sObjectTemplateName");
                    var txtName = objTemplate == null? '' : objTemplate.Name;
                           
                    action = component.get("c.getMetadataTemplate");
                    action.setParams({
                        	search : txtSearch,
                        	txtName : txtName
                        });                  
                }
        }
        action.setCallback(this, function(a) {    
            component.set("v.condition", true);
            component.set("v.hasError", false);
            if (a.getState() === "SUCCESS") {
                component.set("v.rows",a.getReturnValue());
                if(a.getReturnValue()[0].codError != undefined)
                {
                    component.set("v.condition", false);
                    component.set("v.hasError", true);
                    component.set("v.msjError", "No se encontraron registros para el criterio de busqueda.");
                }
            } else if (a.getState() === "ERROR") {
                component.set("v.condition", false);
                $A.log("Errors", a.getError());
            }
        });
            $A.enqueueAction(action);
	}
    
    
})