({
    changeSelected : function(component, event, helper){  
        var selectedOption = component.find("mySelect").get("v.value");
        if(selectedOption == 'Cards')
        {
            component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'Type', fieldName: 'dataSourceType', type: 'text'},
            {label: 'Apex Class', fieldName: 'remoteClass', type: 'text'},
            {label: 'Method', fieldName: 'remoteMethod', type: 'text'},
            ]);
            component.set('v.showSubOptions', false);
            component.set('v.showFiledNameText', false);
        }
        if(selectedOption == 'DataRaptors')
        {
            component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Id', fieldName: 'Link', type: 'url', typeAttributes: {label:'Id', target:'_blank'}},
            {label: 'CreateBy', fieldName: 'CreateBy', type: 'text'},
            {label: 'LastModifyBy', fieldName: 'LastModifyBy', type: 'text'},
            {label: 'LastModifyDate', fieldName: 'LastModifyDate', type: 'text'},
            ]);
            component.set('v.showSubOptions', false);
            component.set('v.showFiledNameText', true);
        }
        if(selectedOption == 'Omniscripts')
        {
            component.set('v.columns', [
            {label: 'Name Credential', fieldName: 'namedCredential', type: 'text'},
            {label: 'Type', fieldName: 'type', type: 'text'},
            {label: 'SubType', fieldName: 'subtype', type: 'text'},
            {label: 'Name', fieldName: 'name', type: 'text'},
            {label: 'Version', fieldName: 'version', type: 'text'},
            {label: 'Element Name', fieldName: 'elementName', type: 'text'},
            ]);
            component.set('v.showSubOptions', true);
            component.set('v.showFiledNameText', false);
        }
        if(selectedOption == 'Templates')
        {
            component.set('v.columns', [
            {label: 'Id', fieldName: 'Id', type: 'Id'},
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'JavaScript', fieldName: 'JavaScript', type: 'text', cellAttributes:{class:'ace_scrollbar ace_scrollbar-v ace ng-pristine ng-untouched ng-valid ace_editor ace-monokai ace_dark ng-not-empty'}},
            {label: 'HTML', fieldName: 'HTML', type: 'text'},
            {label: 'CSS', fieldName: 'CSS', type: 'text'},
            {label: 'Version', fieldName: 'Version', type: 'text'}
            ]);
            component.set('v.showSubOptions', false);
            component.set('v.showFiledNameText', true);
        }
            
    }, 
    
	search : function(component, event, helper) { 
        helper.serverCall(component,event);  
	},
    
    init: function (cmp, event, helper) {
        cmp.condition = false;
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Id', fieldName: 'Id', type: 'text'},
            {label: 'Type', fieldName: 'dataSourceType', type: 'text'},
            {label: 'Apex Class', fieldName: 'remoteClass', type: 'text'},
            {label: 'Method', fieldName: 'remoteMethod', type: 'text'},
        ]);
    },
            
    loadOptions: function (component, event, helper) {
        var opts = [
            { value: "Cards", label: "Cards" },
            { value: "DataRaptors", label: "DataRaptors" },
            { value: "Omniscripts", label: "Omniscripts" },
            { value: "Templates", label: "Templates" }
        ];
        component.set("v.options", opts);
    },
        
    loadOptionsOS: function (component, event, helper) {
        var opts2 = [
            {value:"Todos",label:"Todos"},
            {value:"Aggregate",label:"Aggregate"},
            {value:"Block",label:"Block"},
            {value:"CalculationAction",label:"CalculationAction"},
            {value:"Checkbox",label:"Checkbox"},
            {value:"Currency",label:"Currency"},
            {value:"DataRaptorExtractAction",label:"DataRaptorExtractAction"},
            {value:"DataRaptorPostAction",label:"DataRaptorPostAction"},
            {value:"Date",label:"Date"},
            {value:"Date/Time(Local)",label:"Date/Time(Local)"},
            {value:"Disclosure",label:"Disclosure"},
            {value:"DocuSignEnvelopeAction",label:"DocuSignEnvelopeAction"},
            {value:"DocuSignSignatureAction",label:"DocuSignSignatureAction"},
            {value:"DoneAction",label:"DoneAction"},
            {value:"EmailAction",label:"EmailAction"},
            {value:"Email",label:"Email"},
            {value:"File",label:"File"},
            {value:"Filter",label:"Filter"},
            {value:"FilterBlock",label:"FilterBlock"},
            {value:"Formula",label:"Formula"},
            {value:"Geolocation",label:"Geolocation"},
            {value:"Headline",label:"Headline"},
            {value:"Image",label:"Image"},
            {value:"InputBlock",label:"InputBlock"},
            {value:"LineBreak",label:"LineBreak"},
            {value:"Lookup",label:"Lookup"},
            {value:"Multi-select",label:"Multi-select"},
            {value:"Number",label:"Number"},
            {value:"OmniScript",label:"OmniScript"},
            {value:"Password",label:"Password"},
            {value:"PDFAction",label:"PDFAction"},
            {value:"PosttoObjectAction",label:"PosttoObjectAction"},
            {value:"Radio",label:"Radio"},
            {value:"Range",label:"Range"},
            {value:"RemoteAction",label:"RemoteAction"},
            {value:"RestAction",label:"RestAction"},
            {value:"ReviewAction",label:"ReviewAction"},
            {value:"Select",label:"Select"},
            {value:"SelectableItems",label:"SelectableItems"},
            {value:"SetErrors",label:"SetErrors"},
            {value:"SetValues",label:"SetValues"},
            {value:"Signature",label:"Signature"},
            {value:"Step",label:"Step"},
            {value:"Submit",label:"Submit"},
            {value:"Telephone",label:"Telephone"},
            {value:"Text",label:"Text"},
            {value:"TextArea",label:"TextArea"},
            {value:"TextBlock",label:"TextBlock"},
            {value:"Time",label:"Time"},
            {value:"TypeAheadBlock",label:"TypeAheadBlock"},
            {value:"URL",label:"URL"},
            {value:"Validation",label:"Validation"},
            {value:"EditBlock",label:"EditBlock"},
            {value:"DataRaptorTransformAction",label:"DataRaptorTransformAction"},
            {value:"MatrixAction",label:"MatrixAction"},
            {value:"IntegrationProcedureAction",label:"IntegrationProcedureAction"},
            {value:"ResponseAction",label:"ResponseAction"}
        ];
        component.set("v.ElementOptions", opts2);
    }
})