package pub.mediator.security;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2015-11-24 19:14:30 IST
// -----( ON-HOST: MCINKARA01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import org.apache.axis2.context.MessageContext;
import java.util.Iterator;
import javax.xml.namespace.QName;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMAttribute;
import org.apache.axiom.om.OMNamespace;
import com.softwareag.pg.security.saml.Claim;
import com.softwareag.pg.security.saml.ClaimsIdentity;
import com.softwareag.pg.util.XMLUtils;
// --- <<IS-END-IMPORTS>> ---

public final class utils

{
	// ---( internal utility methods )---

	final static utils _instance = new utils();

	static utils _newInstance() { return new utils(); }

	static utils _cast(Object o) { return (utils)o; }

	// ---( server methods )---




	public static final void getSamlClaims (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getSamlClaims)>> ---
		// @sigtype java 3.5
		// [o] object:0:required ClaimsIdentity
		IDataCursor cur = pipeline.getCursor();
		
		 Object o = IDataUtil.get(cur, "MessageContext"); 
		 MessageContext msgCtx = null;
		if (o != null && o instanceof MessageContext) { 
		    msgCtx = (MessageContext) o;
		}
		 
		 String issuer = "";
		  QName valueTypeQName = null; 
		
		 org.apache.axiom.soap.SOAPHeader header = msgCtx.getEnvelope().getHeader();
		 
		OMElement security =  header.getFirstChildWithName(Secuity_Q);
		
		OMElement assertion =  security.getFirstChildWithName(Assertion_Q);
		 if(assertion!=null){
			 OMElement issuerEl = assertion.getFirstChildWithName(Issuer_Q);
			 if(issuerEl!=null){
			 issuer = issuerEl.getText();
			 }
			 OMElement attributeStatement = assertion.getFirstChildWithName(AttributeStatement_Q);
			 if(attributeStatement!=null){
				 ClaimsIdentity claimsIdenity = new ClaimsIdentity();
				 Iterator<OMElement> attributeItr = attributeStatement.getChildrenWithName(Attribute_Q);
				 while(attributeItr.hasNext())
				 {
					 OMElement attribute = attributeItr.next();
					 if(attribute!=null){
						 String claimType = attribute.getAttributeValue(new QName("Name"));
						 if(!claimType.equalsIgnoreCase("http://schemas.xmlsoap.org/ws/2009/09/identity/claims/actor")){
						 Claim claim = new Claim(); 
						 claim.setIssuer(issuer);
						 claim.setType(claimType);
						 OMElement attributeValueEl = attribute.getFirstChildWithName(AttributeValue_Q);
						 if(attributeValueEl!=null){
							 claim.setValue(attributeValueEl.getText());
							 if(valueTypeQName == null){
								valueTypeQName =  getValueTypeQName(attributeValueEl);
							 }
							String attrVal = attributeValueEl.getAttributeValue(valueTypeQName);
							 if(attrVal==null){
								 attrVal = DefValueType;
							 }
							 else{
								 String val[] = attrVal.split(":");
								 OMNamespace namespace = attributeValueEl.findNamespaceURI(val[0]);
								 if(namespace!=null){
									String namespaceUri = namespace.getNamespaceURI();
									attrVal = namespaceUri+"#"+val[1];
								 }
							 }
							 claim.setValueType(attrVal);
						 } 
						 claimsIdenity.addClaims(claim); 
						 
						 }
						 else{
							 OMElement attrvalEl = attribute.getFirstChildWithName(AttributeValue_Q);
							 try{
							 setActor(claimsIdenity,attrvalEl.getText(),issuer);
							 }
							 catch(Exception e){
								 e.printStackTrace();
							 }
						 }
						 IDataUtil.put(cur, "ClaimsIdentity", claimsIdenity);
						 
					 }
				 }
			 }
		 }
		
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static QName getValueTypeQName(OMElement attributeValEl){
		QName  returnType = null;
		Iterator<OMAttribute> attributes = attributeValEl.getAllAttributes();
		while(attributes.hasNext()){
			OMAttribute attribute = attributes.next();
			
			if(attribute.getLocalName().endsWith("type")){
				returnType =  attribute.getQName();
				break;
			}
		}
		return returnType;
	}
	
	private static void  setActor(ClaimsIdentity parentIdentityClaim,String attributeValue,String issuer)throws Exception {
		QName valueTypeQName = null; 
	//	System.out.println("set actor is called");
		ClaimsIdentity actor = new ClaimsIdentity();
		System.out.println(attributeValue);
		String attrValInput =attributeValue;// org.apache.commons.lang.StringEscapeUtils.unescapeHtml(attributeValue);
		//System.out.println(attrValInput);
		OMElement actorEl = XMLUtils.createOMElement(attrValInput);
		Iterator<OMElement> attributesElItr =  actorEl.getChildrenWithName(Attribute_Q);
		//System.out.println(attributesElItr.hasNext());
		while(attributesElItr.hasNext()){
			OMElement attribute = attributesElItr.next();
			 if(attribute!=null){
				 String claimType = attribute.getAttributeValue(new QName("Name"));
				 if(!claimType.equalsIgnoreCase("http://schemas.xmlsoap.org/ws/2009/09/identity/claims/actor")){
				 Claim claim = new Claim(); 
				 claim.setIssuer(issuer);
				 claim.setType(claimType);
				 OMElement attributeValueEl = attribute.getFirstChildWithName(AttributeValue_Q);
				 if(attributeValueEl!=null){
					 claim.setValue(attributeValueEl.getText());
					 if(valueTypeQName == null){
						valueTypeQName =  getValueTypeQName(attributeValueEl);
					 }
					String attrVal = attributeValueEl.getAttributeValue(valueTypeQName);
					 if(attrVal==null){
						 attrVal = DefValueType;
					 }
					 else{
						 String val[] = attrVal.split(":");
						 OMNamespace namespace = attributeValueEl.findNamespaceURI(val[0]);
						 if(namespace!=null){
							String namespaceUri = namespace.getNamespaceURI();
							attrVal = namespaceUri+"#"+val[1];
						 }
					 }
	
					 claim.setValueType(attrVal);
					// System.out.println(issuer+"Type:"+claim.getType()+claim.getValue()+claim.getValueType());
				 } 
				 actor.addClaims(claim); 
				 }
				 else{
					// System.out.println("attrbute is"+ attribute );
					 OMElement attrvalEl = attribute.getFirstChildWithName(AttributeValue_Q);
					 try{
					 setActor(actor,attrvalEl.getText(),issuer);
					 }
					 catch(Exception e){
						 e.printStackTrace();
					 }
				 }
			 }
		}
		parentIdentityClaim.setActor(actor);
		
	}
	static String DefValueType = "http://www.w3.org/2001/XMLSchema#string";
	static QName Secuity_Q = new QName(
		"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd", "Security");
	 static QName Assertion_Q = new QName(
		"urn:oasis:names:tc:SAML:2.0:assertion", "Assertion");
	 static QName Issuer_Q = new QName(
		"urn:oasis:names:tc:SAML:2.0:assertion", "Issuer");
	 static QName AttributeStatement_Q = new QName(
		"urn:oasis:names:tc:SAML:2.0:assertion", "AttributeStatement");
	 static QName Attribute_Q = new QName(
		"urn:oasis:names:tc:SAML:2.0:assertion", "Attribute");
	 static QName AttributeValue_Q = new QName(
		"urn:oasis:names:tc:SAML:2.0:assertion", "AttributeValue");
	// --- <<IS-END-SHARED>> ---
}

