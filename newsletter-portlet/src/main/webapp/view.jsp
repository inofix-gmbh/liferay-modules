<%--
    view.jsp: Default view of the newsletter-portlet.
    
    Created:     2016-10-05 15:54 by Christian Berndt
    Modified:    2016-10-20 15:14 by Christian Berndt
    Version:     1.1.3
 --%>

<%@ include file="/html/init.jsp"%>

<%@page import="com.liferay.portal.security.auth.PrincipalException"%>

<%
    String backURL = ParamUtil.getString(request, "backURL");
    String tabs1 = ParamUtil.getString(request, "tabs1", "mailings");

    PortletURL portletURL = renderResponse.createRenderURL();
    portletURL.setParameter("tabs1", tabs1);
    portletURL.setParameter("mvcPath", "/view.jsp");
    portletURL.setParameter("backURL", backURL);

    Log log = LogFactoryUtil.getLog("docroot.view.jsp");
%>

<div id="<portlet:namespace />newsletterContainer">

    <liferay-ui:header backURL="<%=backURL%>" title="newsletter-manager" />

    <liferay-ui:tabs names="mailings,newsletters,subscribers"
        param="tabs1" url="<%=portletURL.toString()%>" />

    <c:choose>
    
        <c:when test='<%=tabs1.equals("mailings")%>'>        
            <%@include file="/html/mailings.jspf"%>
        </c:when>

        <c:when test='<%=tabs1.equals("newsletters")%>'>
            <%@include file="/html/newsletters.jspf"%>
        </c:when>

        <c:otherwise>        
            <%@include file="/html/subscribers.jspf"%>
        </c:otherwise>

    </c:choose>

    <hr>

    <ifx-util:build-info />

</div>
