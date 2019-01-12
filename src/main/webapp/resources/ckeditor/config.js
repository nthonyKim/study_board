/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For complete reference see:
	// https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR_config.html

	// The toolbar groups arrangement, optimized for a single toolbar row.
	config.toolbarGroups = [
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'forms' },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'styles' },
		{ name: 'colors' },
		{ name: 'tools' },
		{ name: 'others' },
		{ name: 'about' }
	];

	// The default plugins included in the basic setup define some buttons that
	// are not needed in a basic editor. They are removed here.
	config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Strike,Subscript,Superscript';

	// Dialog windows are also simplified.
	config.removeDialogTabs = 'link:advanced';	
	
	
	config.removePlugins = 'image';
	config.extraPlugins = 'easyimage';

	/*config.cloudServices_tokenUrl = 'https://36786.cke-cs.com/token/dev/HY0uayu8EoHKkSwa8CGEP5NIdC6P42g2eLBSe1Y43TECGKHGPVkTe0Wh29Dp';
	config.cloudServices_uploadUrl = 'https://36786.cke-cs.com/easyimage/upload/';*/
	
	//config.filebrowserUploadMethod = 'form';
		
	config.extraPlugins = 'autogrow';
	config.autoGrow_minHeight = 250;
	config.autoGrow_maxHeight = 600;
	
	config.enterMode = CKEDITOR.ENTER_BR;
	config.basicEntities = false;
	
	
};