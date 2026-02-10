/**
 * @title WET-BOEW Checklist plugin
 * @overview Plugin contained to show an example of a custom WET checklist plugin
 * @license wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html
 * @author @delisma
 */
( function( $, window, wb ) {
  "use strict";
  /*
   * Variable and function definitions.
   * These are global to the plugin - meaning that they will be initialized once per page,
   * not once per instance of plugin on the page. So, this is a good place to define
   * variables that are common to all instances of the plugin on a page.
   */
  var componentName = "wb-checklist",
      selector = "." + componentName,
      initEvent = "wb-init" + selector,
      $document = wb.doc,
      defaults = {
        toggle: {
          stateOn: true,
          stateOff: false
        },
      },

      /**
       * @method init
       * @param {jQuery Event} event Event that triggered the function call
       */
      init = function( event ) {
        var elm = wb.init( event, componentName, selector ),
            $elm,
            settings;

        if ( elm ) {
          $elm = $( elm );
          settings = $.extend( 
            true,
            {},
            defaults,
            window[ componentName ],
            wb.getData( $elm.find( $( ".group_checkbox" ) ) )
          );

          var $elms = $elm.find( $( "[role='checkbox']" ) );

          for ( let i = 0; i < $elms.length; i++ ) {
            this.domNode = $elms.get( i );
            this.domNode.tabIndex = 0;
            if ( !$( this.domNode ).attr( "aria-checked" ) ) {
              $( this.domNode ).attr( "aria-checked", "false" );
            }
          }
        }

        $elm.trigger( "click" );
        $elm.trigger( "keydown" );

        wb.ready( $elm, componentName );
      };
  // Add your plugin event handler
  $document.on( "click", selector, function( event ) {
    var elm = event.target,
        $elm = $( elm );
    if( $elm.attr( "aria-checked" ) === "true" ) {
      $elm.attr( "aria-checked", "false" );
    } else {
      $elm.attr( "aria-checked", "true" );
    }
  } );

  $document.on( "keydown", selector, function( event ) {
    var elm = event.target,
        which = event.which,
        $elm = $( elm ),
        flag = false;
    switch ( which ) {
      case 32:
      case 13: 
        if( $elm.attr( "aria-checked" ) === "true" ) {
          $elm.attr( "aria-checked", "false" );
        } else {
          $elm.attr( "aria-checked", "true" );
        }
        flag = true;
        break;

      default:
        break;
    }

    if ( flag ) {
      event.stopPropagation();
      event.preventDefault();
    }
  });
  // Bind the init event of the plugin
  $document.on( "timerpoke.wb " + initEvent, selector, init );
  // Add the timer poke to initialize the plugin
  wb.add( selector );
  } )( jQuery, window, wb );