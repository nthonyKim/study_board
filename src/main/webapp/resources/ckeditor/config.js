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
	config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';

	// Dialog windows are also simplified.
	config.removeDialogTabs = 'link:advanced';
	
	
	config.extraPlugins = 'easyimage', 'imagebase';
	
	config.easyimage = {
		cloudServices_tokenUrl: 'https://example.com/cs-token-endpoint',
		cloudServices_uploadUrl: 'https://your-organization-id.cke-cs.com/easyimage/upload/'
	}
	config.filebrowserUploadMethod = 'form';
	
	/*config.wordcount = {

	    // Whether or not you want to show the Word Count
	    showWordCount: false,

	    // Whether or not you want to show the Char Count
	    showCharCount: true,
	    
	    // Maximum allowed Word Count
	    maxWordCount: 100,

	    // Maximum allowed Char Count
	    maxCharCount: 2000
	};*/
	
	config.extraPlugins = 'autogrow';
	config.autoGrow_minHeight = 250;
	config.autoGrow_maxHeight = 600;
	
	config.enterMode = CKEDITOR.ENTER_BR;
	config.basicEntities = false;
	
	
};
