<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="../init.jsp" %>

<%
long entryId = ParamUtil.getLong(renderRequest, "entryId");

long guestbookId = ParamUtil.getLong(renderRequest, "guestbookId");

Entry entry = null;

if (entryId > 0) {
	entry = EntryLocalServiceUtil.getEntry(entryId);

	entryId = entry.getEntryId();
}

entry = EntryLocalServiceUtil.getEntry(entryId);
entry = entry.toEscapedModel();

AssetEntry assetEntry = AssetEntryLocalServiceUtil.getEntry(
Entry.class.getName(), entry.getEntryId());

PortalUtil.addPortletBreadcrumbEntry(request, entry.getMessage(),
                currentURL);

PortalUtil.setPageSubtitle(entry.getMessage(), request);
PortalUtil.setPageDescription(entry.getMessage(), request);

List<AssetTag> assetTags = AssetTagLocalServiceUtil.getTags(
                Entry.class.getName(), entry.getEntryId());
PortalUtil.setPageKeywords(ListUtil.toString(assetTags, "name"),
                request);

%>

<liferay-portlet:renderURL varImpl="viewEntryURL">
	<portlet:param name="mvcPath" value="/html/guestbookmvcportlet/view_entry.jsp" />
	<portlet:param name="entryId" value="<%= String.valueOf(entryId) %>" />
</liferay-portlet:renderURL>

<liferay-portlet:renderURL varImpl="viewURL">
    <portlet:param name="mvcPath" value="/html/guestbookmvcportlet/view.jsp" />
</liferay-portlet:renderURL>

<liferay-ui:header
    backURL="<%= viewURL.toString() %>"
   	title="<%= entry.getName() %>"
/>

    <dl>
            <dt>Guestbook</dt>
            <dd><%= GuestbookLocalServiceUtil.getGuestbook(entry.getGuestbookId()).getName() %></dd>
            <dt>Name</dt>
            <dd><%= entry.getName() %></dd>
            <dt>Message</dt>
            <dd><%= entry.getMessage() %></dd>
    </dl>

<liferay-ui:social-bookmarks
	contentId="<%= String.valueOf(assetEntry.getEntryId()) %>"
	displayStyle="menu"
	target="_blank"
	title="<%= String.valueOf(entry.getName()) %>"
	url="<%= PortalUtil.getCanonicalURL((PortalUtil.getCurrentURL(request)), themeDisplay, layout) %>" 
/>

    <liferay-ui:asset-links
            assetEntryId="<%= (assetEntry != null) ? assetEntry.getEntryId() : 0 %>"
            className="<%= Entry.class.getName() %>"
            classPK="<%= entry.getEntryId() %>" />