<%--
    view.jsp: Default view of the social-media-portlet
    
    Created:    2015-08-19 22:17 by Christian Berndt
    Modified:   2017-02-13 15:13 by Christian Berndt
    Version:    1.0.5
--%>

<%@ include file="/html/init.jsp"%>

<%-- Import required classes --%>

<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.util.PortalUtil"%>

<%@page import="java.util.Iterator"%>

<%
	List<String> services = new ArrayList<String>(
			Arrays.asList(selectedServices));

	Iterator<String> iter = services.iterator();

	StringBuilder servicesConfig = new StringBuilder();

	servicesConfig.append("[");

	while (iter.hasNext()) {

		servicesConfig.append("&quot;");
		servicesConfig.append(iter.next());
		servicesConfig.append("&quot;");

		if (iter.hasNext()) {
			servicesConfig.append(",");
		}
	}

	servicesConfig.append("]");

	String completeURL = PortalUtil.getCurrentCompleteURL(request);
	String currentURL = PortalUtil.getCanonicalURL(completeURL,
			themeDisplay, layout);
	
	// Override currentURL with configuredUrl 
	if (Validator.isNotNull(shareUrl)) {
		currentURL = shareUrl; 
	}
	
	String cssClass="";
	if (useContainer) {
		cssClass="container"; 
	}
	
%>

<div class="portlet-social-media">

    <div class="<%=cssClass%>">

        <div class="shariff" data-backend-url="<%=backendUrl%>"
            data-fb-api-key="<%= fbApiKey %>"
            data-fb-caption="<%= fbCaption %>"
            data-fb-description="<%= fbDescription %>"
            data-fb-display="<%= fbDisplay %>"
            data-fb-from="<%= fbFrom %>" data-fb-name="<%= fbName %>"
            data-fb-picture="<%= fbPicture %>"
            data-fb-redirect-uri="<%= fbRedirectUri %>"
            data-fb-ref="<%= fbRef %>" data-fb-source="<%= fbSource %>"
            data-fb-to="<%= fbTo %>" data-url="<%=currentURL%>"
            data-mail-body="<%=mailBody%>"
            data-mail-subject="<%=mailSubject%>"
            data-mail-url="<%=mailUrl%>"
            data-orientation="<%=selectedOrientation%>"
            data-services="<%=servicesConfig%>"
            data-theme="<%=selectedTheme%>"
            data-twitter-via="<%=twitterVia%>"></div>

        <c:if test="<%= showBuildInfo %>">
            <ifx-util:build-info />
        </c:if>

    </div>
</div>
