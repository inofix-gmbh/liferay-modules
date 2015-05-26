<%--
    edit_miscellaneous.jsp: Edit the miscellaneous contact information. 
    
    Created:    2015-05-16 20:06 by Christian Berndt
    Modified:   2015-05-26 17:25 by Christian Berndt
    Version:    1.0.6
--%>

<%@ include file="/html/edit_contact/init.jsp"%>

<%-- Import required classes --%>
<%@page import="java.util.TimeZone"%>

<%@page import="ch.inofix.portlet.contact.dto.ExpertiseDTO"%>
<%@page import="ch.inofix.portlet.contact.dto.HobbyDTO"%>
<%@page import="ch.inofix.portlet.contact.dto.InterestDTO"%>

<%@page import="ezvcard.parameter.ExpertiseLevel"%>
<%@page import="ezvcard.parameter.HobbyLevel"%>
<%@page import="ezvcard.parameter.InterestLevel"%>

<%
	String[] expertiseLevels = new String[] {
			ExpertiseLevel.BEGINNER.getValue(),
			ExpertiseLevel.AVERAGE.getValue(),
			ExpertiseLevel.EXPERT.getValue() };

	String[] hobbyLevels = new String[] { HobbyLevel.HIGH.getValue(),
			HobbyLevel.MEDIUM.getValue(), HobbyLevel.LOW.getValue(), };

	String[] interestLevels = new String[] {
			InterestLevel.HIGH.getValue(),
			InterestLevel.MEDIUM.getValue(),
			InterestLevel.LOW.getValue(), };
%>

<aui:fieldset label="expertise" id="expertise">
	<aui:container>
		<%
			List<ExpertiseDTO> expertises = contact_.getExpertises();

			for (ExpertiseDTO expertise : expertises) {
		%>
		<aui:row>
			<aui:col span="12">
				<div class="lfr-form-row">
					<div class="row-fields">
					
						<aui:input name="expertise" inlineField="true" label=""
							value="<%=expertise.getValue()%>"
							disabled="<%=!hasUpdatePermission%>" />
							
						<aui:select name="expertise.level" inlineField="true" label=""
							disabled="<%=!hasUpdatePermission%>">
							<%
								for (String expertiseLevel : expertiseLevels) {
							%>
							<aui:option value="<%=expertiseLevel%>"
								label="<%=expertiseLevel%>"
								selected="<%=expertiseLevel
												.equalsIgnoreCase(expertise
														.getLevel())%>" />
							<%
								}
							%>
						</aui:select>

						<liferay-ui:icon-help message="expertise-help" />
					</div>
				</div>
			</aui:col>
		</aui:row>
		<%
			}
		%>
	</aui:container>
</aui:fieldset>

<aui:fieldset label="hobbies" id="hobby">
	<aui:container>
		<%
			List<HobbyDTO> hobbies = contact_.getHobbies();

					for (HobbyDTO hobby : hobbies) {
		%>
		<aui:row>
			<aui:col span="12">
				<div class="lfr-form-row">
					<div class="row-fields">
					
						<aui:input name="hobby" inlineField="true" label=""
							value="<%=hobby.getValue()%>"
							disabled="<%=!hasUpdatePermission%>" />
							
						<aui:select name="hobby.level" inlineField="true" label=""
							disabled="<%=!hasUpdatePermission%>">
							<%
								for (String hobbyLevel : hobbyLevels) {
							%>
							<aui:option value="<%=hobbyLevel%>" label="<%=hobbyLevel%>"
								selected="<%=hobbyLevel
												.equalsIgnoreCase(hobby
														.getLevel())%>" />
							<%
								}
							%>
						</aui:select>

						<liferay-ui:icon-help message="hobby-help" />

					</div>
				</div>
			</aui:col>
		</aui:row>
		<%
			}
		%>
	</aui:container>
</aui:fieldset>


<aui:fieldset label="interests" id="interest">
	<aui:container>
		<%
			List<InterestDTO> interests = contact_.getInterests();

			for (InterestDTO interest : interests) {
		%>
		<aui:row>
			<aui:col span="12">
				<div class="lfr-form-row">
					<div class="row-fields">
					
						<aui:input name="interest" inlineField="true" label=""
							value="<%=interest.getValue()%>"
							disabled="<%=!hasUpdatePermission%>" />
							
						<aui:select name="interest.level" inlineField="true" label=""
							disabled="<%=!hasUpdatePermission%>">
							<%
								for (String interestLevel : interestLevels) {
							%>
							<aui:option value="<%=interestLevel%>" label="<%=interestLevel%>"
								selected="<%=interestLevel
												.equalsIgnoreCase(interest
														.getLevel())%>" />
							<%
								}
							%>
						</aui:select>

						<liferay-ui:icon-help message="interest-help" />

					</div>
				</div>
			</aui:col>
		</aui:row>
		<%
			}
		%>
	</aui:container>
</aui:fieldset>

<aui:fieldset label="time-zone">
	<aui:container>
		<aui:row>
			<aui:col width="100">
				<aui:select name="timezone" label="" inlineField="true"
				    disabled="<%= !hasUpdatePermission %>">
					<%
						String[] timezones = TimeZone.getAvailableIDs();
						for (String timezone : timezones) {
					%>
					<aui:option value="<%=timezone%>" label="<%=timezone%>"
						selected="<%=timezone.equalsIgnoreCase(contact_.getTimezone())%>" />
					<%
						}
					%>
				</aui:select>
                <liferay-ui:icon-help message="timezone-help"/>
			</aui:col>
		</aui:row>
	</aui:container>
</aui:fieldset>

<aui:fieldset label="related-assets" helpMessage="related-assets-help">

	<liferay-ui:input-asset-links
		className="<%= Contact.class.getName() %>"
		classPK="<%= contact_.getContactId() %>" />

</aui:fieldset>

<aui:model-context model="<%= Contact.class %>"/>

<aui:fieldset label="categorization">

	<aui:input classPK="<%=contact_.getContactId()%>" name="categories"
		type="assetCategories" inlineField="true"
		disabled="<%= !hasUpdatePermission %>"/>
	
	<aui:input classPK="<%=contact_.getContactId()%>" name="tags"
		type="assetTags" helpMessage="asset-tags-help" 
		disabled="<%= !hasUpdatePermission %>"/>
</aui:fieldset>


<%-- Configure autofields --%>
<aui:script use="liferay-auto-fields">

    var expertiseAutoFields = new Liferay.AutoFields({
        contentBox : 'fieldset#<portlet:namespace />expertise',
        namespace : '<portlet:namespace />',
        on : {
            'clone' : function(event) {
                restoreOriginalNames(event);
            }
        }
    }).render();

    var hobbyAutoFields = new Liferay.AutoFields({
        contentBox : 'fieldset#<portlet:namespace />hobby',
        namespace : '<portlet:namespace />',
        on : {
            'clone' : function(event) {
                restoreOriginalNames(event);
            }
        }
    }).render();
    
    var interestAutoFields = new Liferay.AutoFields({
        contentBox : 'fieldset#<portlet:namespace />interest',
        namespace : '<portlet:namespace />',
        on : {
            'clone' : function(event) {
                restoreOriginalNames(event);
            }
        }
    }).render();

    function restoreOriginalNames(event) {

        // liferay-auto-fields by default adds index numbers
        // to the cloned row's inputs which is here undone.
        var row = event.row;
        var guid = event.guid;

        var inputs = row.all('input, select, textarea');

        inputs.each(function(item) {
            var name = item.attr('name') || item.attr('id');
            var original = name.replace(guid, '');
            item.set('name', original);
            item.set('id', original);
        });

    }
</aui:script>
