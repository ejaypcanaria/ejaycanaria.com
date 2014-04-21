/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For the complete reference:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config
  // config.extraPlugins = 'syntaxhighlight';

  config.toolbar = [
    { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','-','RemoveFormat' ] },
    { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote',
    '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
    { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
    { name: 'insert', items : [ 'Image','Table','HorizontalRule','SpecialChar','PageBreak' ] },
    '/',
    { name: 'clipboard', items : [ 'Undo','Redo' ] },
    { name: 'styles', items : [ 'Styles','Format','FontSize' ] },
    { name: 'colors', items : [ 'TextColor','BGColor' ] },
    { name: 'document', items : [ 'Source' ] }
  ];

  config.uiColor = '#FFFFFF';
};
