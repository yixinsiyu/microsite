﻿/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

(function()
{
    /*
     * It is possible to set things in three different places.
     * 1. As attributes in the object tag.
     * 2. As param tags under the object tag.
     * 3. As attributes in the embed tag.
     * It is possible for a single attribute to be present in more than one place.
     * So let's define a mapping between a sementic attribute and its syntactic
     * equivalents.
     * Then we'll set and retrieve attribute values according to the mapping,
     * instead of having to check and set each syntactic attribute every time.
     *
     * Reference: http://kb.adobe.com/selfservice/viewContent.do?externalId=tn_12701
     */
    var ATTRTYPE_OBJECT = 1,
        ATTRTYPE_PARAM = 2,
        ATTRTYPE_EMBED = 4;

    var attributesMap =
        {
            id : [ { type : ATTRTYPE_OBJECT, name :  'id' } ],
            width : [ { type : ATTRTYPE_OBJECT, name : 'width' }, { type : ATTRTYPE_EMBED, name : 'width' } ],
            height : [ { type : ATTRTYPE_OBJECT, name : 'height' }, { type : ATTRTYPE_EMBED, name : 'height' } ]
        };

    var names = [ 'play', 'loop', 'menu', 'quality', 'scale', 'salign', 'wmode', 'bgcolor', 'base', 'flashvars', 'allowScriptAccess',
        'allowFullScreen' ];
    for ( var i = 0 ; i < names.length ; i++ )
        attributesMap[ names[i] ] = [ { type : ATTRTYPE_EMBED, name : names[i] }, { type : ATTRTYPE_PARAM, name : names[i] } ];
    names = [ 'allowFullScreen', 'play', 'loop', 'menu' ];
    for ( i = 0 ; i < names.length ; i++ )
        attributesMap[ names[i] ][0]['default'] = attributesMap[ names[i] ][1]['default'] = true;

    var defaultToPixel = CKEDITOR.tools.cssLength;

    function loadValue( videoNode, sourceNode, paramMap )
    {//将属性以content内容区id的形式送至对话框
        console.log("loadValue");
        var attributes = attributesMap[ this.id ];
        if ( !attributes )
            return;

        var isCheckbox = ( this instanceof CKEDITOR.ui.dialog.checkbox );
        for ( var i = 0 ; i < attributes.length ; i++ )
        {
            var attrDef = attributes[ i ];
                    if ( !videoNode )
                        continue;
                    if ( videoNode.getAttribute( attrDef.name ) !== null )
                    {
                        var value = videoNode.getAttribute( attrDef.name );
                        if ( isCheckbox )
                            this.setValue( value.toLowerCase() == 'true' );
                        else
                            this.setValue( value );
                        return;
                    }
                    else if ( isCheckbox )
                        this.setValue( !!attrDef[ 'default' ] );
                    break;
        }
    }

    function commitValue( videoNode, sourceNode, paramMap )
    {//对话框中的设置的信息保存至页面内容正文区,以Content中的id一个调用一次
        console.log("commit value")
        var attributes = attributesMap[ this.id ];
        if ( !attributes )//如果没有属性
            return;

        var isRemove = ( this.getValue() === '' ),
            isCheckbox = ( this instanceof CKEDITOR.ui.dialog.checkbox );
        for ( var i = 0 ; i < attributes.length ; i++ )
        {
            var attrDef = attributes[i];

            if ( !videoNode )
                continue;
            value = this.getValue();
            if ( isRemove || isCheckbox && value === attrDef[ 'default' ] )
            {
                if ( attrDef.name in paramMap )
                    paramMap[ attrDef.name ].remove();
            }
            else
            {
                if ( attrDef.name in paramMap )
                    paramMap[ attrDef.name ].setAttribute( 'value', value );
            }

            videoNode.setAttribute( attrDef.name, value );
        }
    }

    CKEDITOR.dialog.add( 'flash', function( editor )
    {
        var makeObjectTag = !editor.config.flashEmbedTagOnly,
            makeEmbedTag = editor.config.flashAddEmbedTag || editor.config.flashEmbedTagOnly;

        var previewPreloader,
            previewAreaHtml = '<div>' + CKEDITOR.tools.htmlEncode( editor.lang.common.preview ) +'<br>' +
                '<div id="cke_FlashPreviewLoader' + CKEDITOR.tools.getNextNumber() + '" style="display:none"><div class="loading">&nbsp;</div></div>' +
                '<div id="cke_FlashPreviewBox' + CKEDITOR.tools.getNextNumber() + '" class="FlashPreviewBox"></div></div>';

        return {
            title : editor.lang.flash.title,
            minWidth : 420,
            minHeight : 310,
            onShow : function()
            {
                // Clear previously saved elements.
                this.fakeImage = this.videoNode = this.sourceNode = null;
                previewPreloader = new CKEDITOR.dom.element( 'video', editor.document );

                // Try to detect any embed or object tag that has Flash parameters.
                var fakeImage = this.getSelectedElement();
                if ( fakeImage && fakeImage.data( 'cke-real-element-type' ) && fakeImage.data( 'cke-real-element-type' ) == 'flash' )
                {
                    this.fakeImage = fakeImage;

                    var realElement = editor.restoreRealElement( fakeImage ),
                        videoNode = null, sourceNode = null, paramMap = {};
                    if ( realElement.getName() == 'cke:video' )
                    {
                        videoNode = realElement;
                        var embedList = videoNode.getElementsByTag( 'video', 'cke' );
                        if ( embedList.count() > 0 )
                            sourceNode = embedList.getItem( 0 );
                        var paramList = videoNode.getElementsByTag( 'video', 'cke' );
                        for ( var i = 0, length = paramList.count() ; i < length ; i++ )
                        {
                            var item = paramList.getItem( i ),
                                name = item.getAttribute( 'name' ),
                                value = item.getAttribute( 'value' );
                            paramMap[ name ] = value;
                        }
                    }
                    else if ( realElement.getName() == 'cke:source' )
                        sourceNode = realElement;

                    this.videoNode = videoNode;
                    this.sourceNode = sourceNode;

                    this.setupContent( videoNode, sourceNode, paramMap, fakeImage );
                }
            },
            onOk : function()
            {
                // If there's no selected object or embed, create one. Otherwise, reuse the
                // selected object and embed nodes.
                var videoNode = null,
                    sourceNode = null,
                    paramMap = null;
                if ( !this.fakeImage )
                {
                        videoNode = CKEDITOR.dom.element.createFromHtml( '<cke:video></cke:video>', editor.document );
                        var attributes = {
                            controls:"",
                            preload:"auto"
                        };
                        videoNode.setAttributes( attributes );
                        sourceNode = CKEDITOR.dom.element.createFromHtml( '<cke:source></cke:source>', editor.document );
                        sourceNode.setAttributes(
                            {
                                src:CKEDITOR.tools.htmlEncode( previewPreloader.getAttribute( 'src' ) ),
                                type : 'video/mp4'
                            } );
                    imageNode =CKEDITOR.dom.element.createFromHtml( '<cke:img></cke:img>', editor.document );
                    imageNode.setAttributes(
                        {
                            "src":ctxStatic+"/carod/video/2.jpg",
                            width:480,
                            height:320,
                            "min-width": 480,
                            "min-height" :320
                        } );
                        if ( videoNode ) {
                            console.log("video Node is not null");
                            sourceNode.appendTo(videoNode);
                            imageNode.appendTo(videoNode);
                        }
                }
                else
                {
                    videoNode = this.videoNode;
                    sourceNode = this.sourceNode;
                    imageNode=this.imageNode;
                }

                // Produce the paramMap if there's an object tag.
                if ( videoNode )
                {
                    paramMap = {};
                    var paramList = videoNode.getElementsByTag( 'video', 'cke' );
                    for ( var i = 0, length = paramList.count() ; i < length ; i++ )
                        paramMap[ paramList.getItem( i ).getAttribute( 'name' ) ] = paramList.getItem( i );
                }

                // A subset of the specified attributes/styles
                // should also be applied on the fake element to
                // have better visual effect. (#5240)
                var extraStyles = {}, extraAttributes = {};
                this.commitContent( videoNode, sourceNode, paramMap, extraStyles, extraAttributes );

                // Refresh the fake image.
                var newFakeImage = editor.createFakeElement( videoNode, 'cke_flash', 'flash', true );
                newFakeImage.setAttributes( extraAttributes );
                newFakeImage.setStyles( extraStyles );
                if ( this.fakeImage )
                {
                    newFakeImage.replace( this.fakeImage );
                    editor.getSelection().selectElement( newFakeImage );
                }
                else
                    editor.insertElement( newFakeImage );
            },

            onHide : function()
            {
                if ( this.preview )
                    this.preview.setHtml('');
            },

            contents : [
                {
                    id : 'info',
                    label : editor.lang.common.generalTab,
                    accessKey : 'I',
                    elements :
                        [
                            {
                                type : 'vbox',
                                padding : 0,
                                children :
                                    [
                                        {
                                            type : 'hbox',
                                            widths : [ '280px', '110px' ],
                                            align : 'right',
                                            children :
                                                [
                                                    {
                                                        id : 'src',
                                                        type : 'text',
                                                        label : editor.lang.common.url,
                                                        required : true,
                                                        validate : CKEDITOR.dialog.validate.notEmpty( editor.lang.flash.validateSrc ),
                                                        setup : loadValue,
                                                        commit : commitValue,
                                                        onLoad : function()
                                                        {//在ckfinder选择了视频文件后, on selected in ckfinder;在编辑器中选择视频元素，再打开对话框修改也会到这里来。
                                                            var dialog = this.getDialog(),
                                                                updatePreview = function( src ){
                                                                    // Query the preloader to figure out the url impacted by based href.
                                                                    previewPreloader.setAttribute( 'src', src );
                                                                    var ext = src.substr( (src.lastIndexOf('.') +1) );
                                                                    console.log("selected video file extention is :"+ext);
                                                                     //if it's other video file preview with videojs
                                                                        dialog.preview.setHtml( '<video  controls preload="auto"' +
                                                                            ' width="100%" height="100%"   poster='+ctxStatic+'/carod/video/2.jpg data-setup="{}">'+
                                                                            '<source src="'+CKEDITOR.tools.htmlEncode( previewPreloader.getAttribute( 'src' ) )+'" type="video/mp4">'+
                                                                            '<source src="'+CKEDITOR.tools.htmlEncode( previewPreloader.getAttribute( 'src' ) )+'" type="video/webm">'+
                                                                            + '</video>' );
                                                                };
                                                            // Preview element
                                                            dialog.preview = dialog.getContentElement( 'info', 'preview' ).getElement().getChild( 3 );

                                                            // Sync on inital value loaded.
                                                            this.on( 'change', function( evt ){

                                                                if ( evt.data && evt.data.value )
                                                                    updatePreview( evt.data.value );
                                                            } );
                                                            // Sync when input value changed.
                                                            this.getInputElement().on( 'change', function( evt ){

                                                                updatePreview( this.getValue() );
                                                            }, this );
                                                        }
                                                    },
                                                    {
                                                        type : 'button',
                                                        id : 'browse',
                                                        filebrowser : 'info:src',
                                                        hidden : true,
                                                        // v-align with the 'src' field.
                                                        // TODO: We need something better than a fixed size here.
                                                        style : 'display:inline-block;margin-top:10px;',
                                                        label : editor.lang.common.browseServer
                                                    }
                                                ]
                                        }
                                    ]
                            },
                            {
                                type : 'hbox',
                                widths : [ '25%', '25%', '25%', '25%', '25%' ],
                                children :
                                    [
                                        {
                                            type : 'text',
                                            id : 'width',
                                            style : 'width:95px',
                                            label : editor.lang.common.width,
                                            validate : CKEDITOR.dialog.validate.htmlLength( editor.lang.common.invalidHtmlLength.replace( '%1', editor.lang.common.width ) ),
                                            setup : loadValue,
                                            commit : commitValue
                                        },
                                        {
                                            type : 'text',
                                            id : 'height',
                                            style : 'width:95px',
                                            label : editor.lang.common.height,
                                            validate : CKEDITOR.dialog.validate.htmlLength( editor.lang.common.invalidHtmlLength.replace( '%1', editor.lang.common.height ) ),
                                            setup : loadValue,
                                            commit : commitValue
                                        }
                                    ]
                            },
                            {
                                type : 'vbox',
                                children :
                                    [
                                        {
                                            type : 'html',
                                            id : 'preview',
                                            style : 'width:95%;',
                                            html : previewAreaHtml
                                        }
                                    ]
                            }
                        ]
                },
                {
                    id : 'Upload',
                    hidden : true,
                    filebrowser : 'uploadButton',
                    label : editor.lang.common.upload,
                    elements :
                        [
                            {
                                type : 'file',
                                id : 'upload',
                                label : editor.lang.common.upload,
                                size : 38
                            },
                            {
                                type : 'fileButton',
                                id : 'uploadButton',
                                label : editor.lang.common.uploadSubmit,
                                filebrowser : 'info:src',
                                'for' : [ 'Upload', 'upload' ]
                            }
                        ]
                }
            ]
        };
    } );
})();
