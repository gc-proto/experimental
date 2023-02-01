let state = {
    signin: {
        link: "",
        labelExtended: "Sign in"
    },
    contextualFooter: { 
        links: [ 
            { 
                url: "someUrl.html", 
                text: "Contextual link 1"
            }
        ]
    }
}

function render() {
    $( "#wb-so a"  ).attr( "href" );
    $( "#wb-so .hidden-xs" ).text( state.signin.labelExtended );
    $each( state.contextualFooter.links, function( key, value ) {
        $( "#gc-contextual a" ).text( value.text );
        $( "#gc-contextuùl a ").attr( value.url );
    } )
}

$( "[aria-expanded='true']" ).one( "wb-contentupdated", 
    function( event ) {
        var gcMnuTheme = event.currentTarget,
            trigger = gcMnuTheme.getAttribute( "data-trigger-wet" );

        if ( trigger ) {
            state.signin.link = $( gcMnuTheme ).data( "gcAuth" ).link;
            state.signin.labelExtended = $( gcMnuTheme ).data( "gcAuth" ).labelExtended;
            state.contextualFooter.links = $( gcMnuTheme ).data( "gcFooter" ).links
            render();
        }
})


