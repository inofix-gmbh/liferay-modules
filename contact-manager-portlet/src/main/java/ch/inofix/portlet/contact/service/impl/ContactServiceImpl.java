package ch.inofix.portlet.contact.service.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.service.ServiceContext;

import ch.inofix.portlet.contact.model.Contact;
import ch.inofix.portlet.contact.security.permission.ActionKeys;
import ch.inofix.portlet.contact.service.ContactLocalServiceUtil;
import ch.inofix.portlet.contact.service.ContactServiceUtil;
import ch.inofix.portlet.contact.service.base.ContactServiceBaseImpl;
import ch.inofix.portlet.contact.service.permission.ContactPermission;
import ch.inofix.portlet.contact.service.permission.ContactPortletPermission;

/**
 * The implementation of the contact remote service.
 *
 * <p>
 * All custom service methods should be put in this class. Whenever methods are
 * added, rerun ServiceBuilder to copy their definitions into the
 * {@link ch.inofix.portlet.contact.service.ContactService} interface.
 *
 * <p>
 * This is a remote service. Methods of this service are expected to have
 * security checks based on the propagated JAAS credentials because this service
 * can be accessed remotely.
 * </p>
 *
 * @author Brian Wing Shun Chan
 * @author Christian Berndt
 * @see ch.inofix.portlet.contact.service.base.ContactServiceBaseImpl
 * @see ch.inofix.portlet.contact.service.ContactServiceUtil
 * @created 2015-05-07 23:50
 * @modified 2016-11-23 19:08
 * @version 1.0.4
 */
public class ContactServiceImpl extends ContactServiceBaseImpl {
    /*
     * NOTE FOR DEVELOPERS:
     * 
     * Never reference this interface directly. Always use {@link
     * ch.inofix.portlet.contact.service.ContactServiceUtil} to access the
     * contact remote service.
     */

    /**
     * Return the added contact.
     * 
     * @param userId
     * @param groupId
     * @param card
     *            the vCard string
     * @param uid
     *            the vCard's uid
     * @return the added contact
     * @since 1.0.0
     * @throws PortalException
     * @throws SystemException
     */
    public Contact addContact(long userId, long groupId, String card,
            String uid, ServiceContext serviceContext) throws PortalException,
            SystemException {

        ContactPortletPermission.check(getPermissionChecker(), groupId,
                ActionKeys.ADD_CONTACT);

        return ContactLocalServiceUtil.addContact(userId, groupId, card, uid,
                serviceContext);

    }

    /**
     * 
     * @return
     * @since 1.0.2
     * @throws PortalException
     * @throws SystemException
     */
    public Contact createContact() throws PortalException, SystemException {

        // Create an empty contact - no permission check required
        return ContactLocalServiceUtil.createContact(0);

    }

    /**
     * 
     * @param groupId
     * @return
     * @since 1.0.4
     * @throws PortalException
     * @throws SystemException
     */
    public List<Contact> deleteAllContacts(long groupId)
            throws PortalException, SystemException {

        ContactPortletPermission.check(getPermissionChecker(), groupId,
                ActionKeys.DELETE_CONTACTS);

        List<Contact> contacts = ContactLocalServiceUtil.getContacts(groupId);

        for (Contact contact : contacts) {
            contact = ContactServiceUtil.deleteContact(contact.getContactId());
        }

        return contacts;
    }

    /**
     * Delete a specific contact version and return the deleted contact.
     * 
     * @param contactId
     * @return the deleted contact
     * @since 1.0.0
     * @throws PortalException
     * @throws SystemException
     */
    public Contact deleteContact(long contactId) throws PortalException,
            SystemException {

        ContactPermission.check(getPermissionChecker(), contactId,
                ActionKeys.DELETE);

        Contact contact = ContactLocalServiceUtil.deleteContact(contactId);

        return contact;

    }

    /**
     * Return the contact.
     * 
     * @param contactId
     * @return the latest version of a contact.
     * @since 1.0.0
     * @throws PortalException
     * @throws SystemException
     */
    public Contact getContact(long contactId) throws PortalException,
            SystemException {

        ContactPermission.check(getPermissionChecker(), contactId,
                ActionKeys.VIEW);

        return ContactLocalServiceUtil.getContact(contactId);

    }

    /**
     * 
     * @param userId
     * @param taskName
     * @param groupId
     * @param privateLayout
     * @param parameterMap
     * @param file
     * @return
     * @since 1.0.4
     * @throws PortalException
     * @throws SystemException
     */
    public long importContactsInBackground(long userId, String taskName,
            long groupId, boolean privateLayout,
            Map<String, String[]> parameterMap, File file)
            throws PortalException, SystemException {

        ContactPortletPermission.check(getPermissionChecker(), groupId,
                ActionKeys.IMPORT_CONTACTS);

        return ContactLocalServiceUtil.importContactsInBackground(userId,
                taskName, groupId, privateLayout, parameterMap, file);

    }

    /**
     * 
     * @param userId
     * @param groupId
     * @param contactId
     * @param card
     * @param uid
     * @param serviceContext
     * @return
     * @since 1.0.2
     * @throws PortalException
     * @throws SystemException
     */
    public Contact updateContact(long userId, long groupId, long contactId,
            String card, String uid, ServiceContext serviceContext)
            throws PortalException, SystemException {

        ContactPermission.check(getPermissionChecker(), contactId,
                ActionKeys.UPDATE);

        return ContactLocalServiceUtil.updateContact(userId, groupId,
                contactId, card, uid, serviceContext);

    }

    private static Log log = LogFactoryUtil.getLog(ContactServiceImpl.class
            .getName());

}
