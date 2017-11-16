/**
 * main.js: Functions used by the data-manager portlet.
 * 
 * Created: 	2017-11-16 20:34 by Christian Berndt
 * Modified: 	2017-11-16 20:34 by Christian Berndt
 * Version: 	1.0.0
 */

/**
 * 
 * @param event
 * @since 1.0.0
 */
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

};