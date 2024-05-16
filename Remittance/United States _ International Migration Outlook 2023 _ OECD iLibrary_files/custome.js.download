if (!String.prototype.endsWith) {
/* pollyfill for older browsers */
  String.prototype.endsWith = function(searchString, position) {
      var subjectString = this.toString();
      if (typeof position !== 'number' || !isFinite(position) || Math.floor(position) !== position || position > subjectString.length) {
        position = subjectString.length;
      }
      position -= searchString.length;
      var lastIndex = subjectString.lastIndexOf(searchString, position);
      return lastIndex !== -1 && lastIndex === position;
  };
}

/*js-popoverLink*/
function jspopover(){
    $('.js-nli-createalert').mouseenter(function(){
        $(this).css('cursor','pointer');
        $(this).css('text-decoration','underline');
    }).mouseleave(function(){
        $(this).css('cursor','auto');
        $(this).css('text-decoration','none');
    });

    $(".js-nli-createalert").click(function(e){
        $(this).children('[data-toggle="popover"]').popover({
            html:true,  
            trigger: 'focus',
            delay: 100
        }).focus();
    });     
    /* new class on alert link for popover element */
    $(".js-popoverLink").click(function(e){
        e.preventDefault();
    });
}
/*js-popoverLink*/


/*View all clickable action*/
var dtable = $('#view-all').DataTable({
    aoColumns: [
        null,
        null,
            { "orderSequence": [ "desc" , "asc"] },
            { "orderSequence": [ "asc", "desc"] },
        null,
        null
    ]
});

$(".js-view-all").click(function(e){
        e.preventDefault();
        var ithis = $(this);
        var ahahURL = ithis.attr('href');
        var loaderImg = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
        ithis.replaceWith(loaderImg);
        ithis.off('click');
        $.ajax({url: ahahURL,
        type:'get',
        success: function(resp){
        dtable.destroy();
            $('#view-all').find('tbody tr').find('td.Volume_issue:contains("Online")').parent().remove();
            $('#view-all').find('tbody').append(resp);
            loaderImg.remove();
            dtable = $('#view-all').DataTable( {
                destroy: true,
                 aoColumns: [
                    null,
                    null,
                        { "orderSequence": [ "desc" , "asc"] },
                        { "orderSequence": [ "asc", "desc"] },
                    null,
                    null
                ],
                "bPaginate": false,
            });
           jspopover();
        },
        error: function(resp) {
            loaderImg.remove();
            var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
            if (!$.browser.msie) {
            console.log(cMsg);
            }
        }
    });
});
/* /View all clickable action*/

jQuery(function($){
    "use strict"

    // Navigation - Countries list Filter
    function filterCountriesList(e) {
        e.preventDefault();
        e.stopPropagation();

        var _this = $(this);
        var container = _this.attr('href');

        $('.countriesList .tabs a').removeClass('selected');
        $('.countriesList .panel .li_container').removeClass('selected');

        _this.addClass('selected');
         $(container).addClass('selected');
    }
    $('.countriesList .tabs a').on('click', filterCountriesList);

    // Navigation - Theme and country clear filter
    function selectAllThemeCountry (e){
        e.preventDefault();
        e.stopPropagation();

        var _this = $(this);
        var filter = _this.attr('href');

        if(_this.hasClass('cleared')){
            _this.removeClass('cleared');
            $(filter).find('input').prop('checked', true);
        }else{
            _this.addClass('cleared');
            $(filter).find('input').prop('checked', false);
        }
        countItemsChecked ();
    }
    $('.btn-clear-filter-nav').on('click', selectAllThemeCountry);

    // Navigation - Theme and country count items checked
    function countItemsChecked (){
        var checkedThemes = $('.checkboxes-theme input:checked').length;
        var checkedCountries = $('.checkboxes-country input:checked').length;
        $('.results-filter-theme .result').html(checkedThemes);
        $('.results-filter-country .result').html(checkedCountries);
    }
    $('.theme-countries-wrapper input').on('click', countItemsChecked);

    // Carousel homepage
    if($('#carousel-home').length){
        $('#carousel-home').carousel({
            direction: 'left'
        });
    }
    

    /*mCustomScrollbar*/
    var index_Id = $('.volumeid').text();
    function initCustomScroll (){
       if ( $(".pretty-scroll").length > 0 && window.mCustomScrollbar) {
            $(".pretty-scroll").mCustomScrollbar({
                theme:"ocde-theme"
            });
       }

        if(index_Id){
            $('#'+ index_Id + ' a').trigger('click');
        }
        else{
           $('.js-volume:first-child a').trigger('click');
        }
    }
    
   //scroll to location hash (current Volume id)
    $(window).load(function(){
        if($('#'+ index_Id)){
          var target=$($('#'+ index_Id)).parents(".mCustomScrollbar");
          if(target.length){
            target.mCustomScrollbar("scrollTo",$('#'+ index_Id));
          }
        }
    });
    /*mCustomScrollbar*/


    // Infobubbles
    if($('.actions').length){
        $('.info-bubble:not(:empty)').addClass('show');
    }

    // Sortable array
    if($('#collectionsort').length) {
        $('#collectionsort').DataTable( {
            "pageLength": 20,
            "bSortable" : false,
            "ordering": false,
        });
    }
    else if($('#sortinstance').length) {
        $('#sortinstance').DataTable( {
            "bSortable" : true,
            "ordering": true,
            "bPaginate": false,
        });
    }
    else if($('#sortingAndPaginationInstance').length) {
        $('#sortingAndPaginationInstance').DataTable( {
        	"pageLength": 20,
            "bSortable" : true,
            "ordering": true,
            "bPaginate": true,
            "searching": false,
            "pagingType": "full_numbers",
            "lengthMenu": [[10,20,50,-1],[10,20,50,"All"]]
        });
    }

    // Collapse body post on mobile
    function collapseBodyPost () {
        if($('.body-item-post').length){
            var windowWidth = $(window).outerWidth();
            console.log(windowWidth);
            if(windowWidth < 1200) {
                if(!$('.body-item-post').hasClass( "collapse" )){
                    $('.body-item-post').addClass( "collapse" );
                }

            } else {
                $('.body-item-post').removeClass( "collapse" ).attr('aria-expanded', 'true').height('auto');
            }
        }
    }
    collapseBodyPost();

    // Show or hide exerpt
    if($('.excerpt-item').length){
        $('.excerpt-item .read-more').on('click', function(){
            $(this).parent().toggleClass('expanded');
        });
    }

    // Close popup
    if($('.ocde-popup').length){
        $('.ocde-popup .close-popup').on('click', function(e){
            e.preventDefault();
            $('.ocde-popup').hide();
        });
    }

    /*======================================
    =            INIT FUNCTIONS            =
    ======================================*/

    $(document).ready(function(){
        initCustomScroll();
    });

    $(window).on('load', function() {

    });

    $(window).on('resize', function() {
        collapseBodyPost();
    }); 
});

$(function(){
    /*For preview section*/ 
    $('.js-previewbody').html($('#previewHtml').text());
    /*For preview section*/ 

     /*For Datasets Indicator*/

    (function(){
        var elements = $(".js-furtherRea");
        var len = elements.length; 

        $.each(elements, function (i, item) {
            var ithis = $(this);
            var ahahURL = $(elements[i]).attr('href');
            var relatedString = "#related-titles";

            relatedString = relatedString.concat((i+1).toString());
            var $loaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
            ithis.replaceWith($loaderIcon);

            if(ahahURL) {
                $.ajax({url: ahahURL,
                    type:'get',
                    success: function(resp){
                        $(relatedString).html(resp);
                        $(relatedString).show();
                        $loaderIcon.remove();
                        jspopover();

                        /*For furtherreadingtables*/
                        var furtherreadelements = document.getElementById(relatedString.substring(1)).getElementsByClassName("js-furtherreadingtables");
                        var furtherreadlen = furtherreadelements.length;
                        var publicationIdentifier=relatedString.concat(" .js-furtherreadingtables");

                        $.each(furtherreadelements, function (i, item) {
                        var ithis = $(this);
                        var ahahURL = $(furtherreadelements[i]).attr('href');
                        var publicationId = $(publicationIdentifier).data('publicationid'); 
                        var $NestedloaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
                        ithis.replaceWith($NestedloaderIcon);
                            if(ahahURL) {
                                $.ajax({url: ahahURL,
                                type:'get',
                                    success: function(resp){
                                        $('#furthertable' + publicationId).html(resp);
                                        $('#furthertable' + publicationId).show(); 
                                        jspopover();
                                        $NestedloaderIcon.remove(); 
                                    },
                                    error: function(resp) {
                                        $('#furthertable' + publicationId).remove();
                                        $NestedloaderIcon.remove(); 
                                    }
                                });
                            }
                        });
                        /*For furtherreadingtables*/
                    },
                    error: function(resp) {
                        $(relatedString).remove();
                        $loaderIcon.remove();
                     }
                });
            }
        });
    })();
    /*For Datasets Indicator*/

    
    /*For furtherreadingtables under a table periodical or monographs/publication*/
    var furtherreadelements = $(".js-furtherreadingtables");
    var furtherreadlen = furtherreadelements.length;

    $.each(furtherreadelements, function (i, item) {
    var ithis = $(this);
    var ahahURL = $(furtherreadelements[i]).attr('href');
    var publicationId = $(".js-furtherreadingtables").data('publicationid'); 
    var $NestedloaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
    ithis.replaceWith($NestedloaderIcon);
        if(ahahURL) {
            $.ajax({url: ahahURL,
            type:'get',
                success: function(resp){
                    $('#furthertable' + publicationId).html(resp);
                    $('#furthertable' + publicationId).show(); 
                    jspopover();
                    $NestedloaderIcon.remove(); 
                },
                error: function(resp) {
                    $('#furthertable' + publicationId).remove();
                    $NestedloaderIcon.remove(); 
                }
            });
        }
    });
    
    

    /*For next-issue*/
    var ahahURL = $('.js-nextURL').attr('href');
    var spinnerIcon = $('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>')
    $('.js-nextURL').replaceWith(spinnerIcon);
    if(ahahURL) {
        $.ajax({url: ahahURL,
            timeout: 30000,
            type:'get',
            success: function(resp){
                $(".js-nextissue").html(resp);
                $(".js-nextissue").show();
                spinnerIcon.remove(); 
            },
            error: function(resp) {
             spinnerIcon.remove();
             $(".js-nextissue").remove();
             var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                 if (!$.browser.msie) {
                      console.log(cMsg);
                 }
             }
        });
    }
    /*For next-issue*/
    
    /*For forthcoming items*/
    var ahahURL = $('.js-forthcomingURL').attr('href');
    var spinnerIcon = $('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
    var originalURLContent=$('.js-forthcomingURL');
    $('.js-forthcomingURL').replaceWith(spinnerIcon);
    if(ahahURL) {
        $.ajax({url: ahahURL,
            timeout: 30000,
            type:'get',
            success: function(resp){
            	var resultsCount = parseInt($(resp).find('#totalResultsForAJAX').attr("data-totalresults"));
            	if(resultsCount == 0){
            		spinnerIcon.remove(); 
            		$(".js-forthcoming").remove();
            	}
            	else {
            		  $(".js-forthcoming").html(originalURLContent);
                      $(".js-forthcoming").show();
                      spinnerIcon.remove(); 
            	}
              
            },
            error: function(resp) {
             spinnerIcon.remove();
             $(".js-forthcoming").remove();
             var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                 if (!$.browser.msie) {
                      console.log(cMsg);
                 }
             }
        });
    }
    /*For forthcoming items*/



    /*Discontinued Series*/
    var ithis = $(this);
    var ahahURL = ithis.find(".js-discontinuedseries").attr('href');
    $('.js-discontinuedseries').replaceWith("<img src='/images/instance/loader.png' class='loader loader-center discont-load '/>");
    if(ahahURL) {
        $.ajax({url: ahahURL,
            timeout: 30000,
            type:'get',
            success: function(resp){
                $('.discont-load').remove();
                ithis.find(".js-discontinuedbox").html(resp);
                ithis.find(".js-discontinuedbox").show(); 
                jspopover();
            },
            error: function(resp) {
            $('.discont-load').remove();
             var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                 if (!$.browser.msie) {
                      console.log(cMsg);
                 }
             }
        });
    }
    /*Discontinued Series*/


    /*Archives section*/
    $(".js-archives").click(function(e){
        e.preventDefault();
        var ithis = $(this);
        var ahahURL = ithis.attr('href');
        var datasetsarchives = ithis.parent().siblings(".js-datasetsarchives");
        if(datasetsarchives.find('.js-archivesResultBox').length == 0){
        var $loaderImg = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
        ithis.prepend($loaderImg);
            $.ajax({url: ahahURL,
            timeout: 30000,
            type:'get',
                success: function(resp){
                    datasetsarchives.html(resp);
                    datasetsarchives.show();
                    $loaderImg.remove();
                    jspopover(); 
                },
                error: function(resp) {
                    datasetsarchives.remove();
                    $loaderImg.remove();
                    var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                        if (!$.browser.msie) {
                          console.log(cMsg);
                        }
                    }
            });
        }
    });
    /*Archives section*/

    /*most recent archive year by default open*/
        $('.js-mostrecent > div:nth-child(2)').find('.js-archives').trigger('click');
    /*most recent archive year by default open*/

    /*volume section*/
        var lastVolumeClick;
        $(".js-volume a").click(function(e){
        e.preventDefault();

        var ithis = $(this);
        var issueList = ithis.next(".issues-list");
            if(issueList.find('li').length == 0){
                lastVolumeClick = ithis; 
                var ahahURL = ithis.attr('href');
                var $spinner = $('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');

                issueList.prepend($spinner);

                $.ajax({url: ahahURL,
                timeout: 30000,
                type:'get',
                success: function(resp){
                    ithis.next(".issues-list").html(resp);
                    if(lastVolumeClick == ithis){
                        ithis.next(".issues-list").show(); 
                    }
                    $spinner.remove();
                    },
                    error: function(resp) {
                        ithis.next(".issues-list").remove();
                        $spinner.remove();
                        var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                        if (!$.browser.msie) {
                          console.log(cMsg);
                        }
                    }
                });
            }
        });
    /*volume section*/


    $(window).on('load resize',function(){
        var windowSize = $(window).width();
        if (windowSize <= 1199) {
            $(".js-volume a").click(function(){
                $(this).parent().parent().find('.collapse').hide();
            });
        }
    });


    $('.dropdown-menu').on('click',function(event) {
        if ($(this).parent('.js-item').hasClass('open')) { 
            event.stopPropagation();
        }
    });

    //stats logging for search results listing page 
    $('.js-arrow_ocde').on('click',function(event) {
    	
    	var itemid = $(this).closest(".resultItemContainer").find(".js-access-determined, .js-access-in-the-process-of-being-determined").data("itemid");
    	
    	if ($(this).hasClass('js-first-item')) {
    		//dont log event as this expands by default.  Remove this class as we want to log event if
    		//user collapses the first item and then expands it
    		$(this).removeClass('js-first-item');
    	} else if ($(this).attr('aria-expanded') === 'false') {
	            //log event
	            
	            eventLogUrl = $("meta[name='stats-meta']").data("logstatisticsurl"); 
	            eventData = {
	             "eventType": "INVESTIGATION",
	             "eventProperties.ITEM_ID": itemid,
	             "eventProperties.SOURCE": "BROWSE",
	           };
	           $.ajax({
	             url: eventLogUrl,
	             type: "GET",
	             data: eventData,
	             success: function(resp, statusText) {
	             },
	             error: function(req, statusText, errorThrown) {
	             }
	           });

    	}
    
    });

 
    //stats logging for TOC listing pages. We appear to be using a different id element so hence a bit of the 
    //repetition above
    $('#bellowheadercontainer').on('click', '.arrow-ocde', function(event) {

	    if ($(this).attr('aria-expanded') === 'false') {
	    
	    	var itemid = $(this).data("itemid");
	
	    	if (itemid != null) {
	            
	            eventLogUrl = $("meta[name='stats-meta']").data("logstatisticsurl"); 
	            eventData = {
	             "eventType": "INVESTIGATION",
	             "eventProperties.ITEM_ID": itemid,
	             "eventProperties.SOURCE": "BROWSE",
	           };
	           $.ajax({
	             url: eventLogUrl,
	             type: "GET",
	             data: eventData,
	             success: function(resp, statusText) {
	             },
	             error: function(req, statusText, errorThrown) {
	             }
	           });
	    	}
	    }
 
    });
    
    
    $("#scroll-nav a").on('click', function(event) {
        if (this.hash !== "") {
        event.preventDefault();
        var hash = this.hash;
            $('html, body').animate({
                scrollTop: $(hash).offset().top
            }, 800, function(){
                window.location.hash = hash;
            });
        } 
    });

     /*search results first section by default open*/ 
        $('#listItems').find('.js-arrow_ocde').eq(0).trigger('click');
    /*search results first section by default open*/

    
     /*In long description we need to showing more/less with description after three lines
        var fulltextNode, 
            fulltextNodeContent, 
            firstContent, 
            plusClick=true;
        
           // fulltextNode= $('.js-fulldescription > p:first');
            
            fulltextNode= $('.js-fulldescription > p')[0];
        fulltextNodeContent = fulltextNode.firstChild.nodeValue;
        var charCount = fulltextNodeContent.length;

        if(charCount < 290){
            $('.js-moreless').remove(); 
        }

        else{
            firstContent = fulltextNodeContent.substring(0, 290);
            fulltextNode.firstChild.nodeValue = firstContent;
        }
            
            */
    (function (){
            var descriptElementSelectorName = '.js-fulldescription',
                descriptionElementObj = $(descriptElementSelectorName),
                expandedDefault = false,
                moreText = 'more...', //set default value
                lessText = 'less...';
         
                if (descriptionElementObj.length > 0){
                    $(descriptionElementObj).each(function() {
                        expandedDefault = false; //reset back to default
                        moreText = 'more...'; //set default value
                        lessText = 'less...';
                        var descriptionElementObjThis = $(this);     
                             
                    
                        //descriptionElement.removeClass('js-fulldescription').addClass('js-reduceddescription');
                    if(descriptionElementObj.data('moretext'))
                        moreText = descriptionElementObjThis.data('moretext'); //re-define if data- exists!
                    
                    if (descriptionElementObj.data('lesstext'))
                        lessText = descriptionElementObjThis.data('lesstext'); //re-define if data- exists!
                    
                    if (descriptionElementObjThis.data('expandeddefault') === true)
                        expandedDefault = true; //re-define if value is true

                    $(descriptionElementObjThis).html($(descriptionElementObjThis).html().trim()); 

                    if (expandedDefault === false) 
                        descriptionElementObjThis.before(descriptionElementObjThis.clone().addClass('hidden')); 
                     else 
                         descriptionElementObjThis.before(descriptionElementObjThis.clone()); //dont hide we will hide the elipsis version.

                            $(descriptionElementObjThis).ellipsis({
                                row: 3,
                                /*char: (' ' + moreText), //concat String append with space!
                                callback: function() {
                                    var ithis = $(this),
                                        itext = ithis.text(),
                                        replaceHTML = $("<a href='#' class='js-moreless'>" + moreText +"</a>");
                                        ithis.html(itext.replace(moreText, replaceHTML.prop('outerHTML'))); 
                                }
                                */
                                callback: function() {
                                    var itext = $(this).text();
                                    //callback appears to run even when you can't elipisis text as its too short so lets check for "..." at end of string.
                                    var isEllipsised = itext != descriptionElementObjThis.siblings('.js-fulldescription').text().trim();
                                    if(isEllipsised && itext.endsWith('...')) {
                                        descriptionElementObjThis.after("<a href='#' class='js-moreless'>" + (expandedDefault === false ? moreText : lessText) +"</a>");
                                    }    
                                        if(expandedDefault === true) 
                                            descriptionElementObjThis.addClass('hidden');
                                   
                                } 
                            });
                    
                        }); //end of itterator for where there are multiple instances on the site.
                    
                        $('.js-moreless').click(function(e){
                            e.preventDefault();
                            
                            var ithis = $(this),
                                ithistext = ithis.text();
                            
                            if (ithistext === moreText)
                                ithis.text(lessText);
                            else 
                                ithis.text(moreText);
                       
                            ithis.siblings(descriptElementSelectorName).toggleClass('hidden');
                           
                        });
                
                }
    })(); 

    /*for more less description on search results page with bootstrap shown.bs.collapse*/ 
    /*$(".js-arrow_ocde").each(function() {
        $(this).one('click', function () {
            $(this).closest('.resultItemContainer').find('.description_offest').one('shown.bs.collapse', function(){
                var  moreText = 'more...', //set default value
                lessText = 'less...', descriptElementSelectorName = '.js-fulldescription', descriptionElementObj = $(descriptElementSelectorName);

                var descriptionDiv = $(this).closest('.resultItemContainer').find('.description_offest .js-fulldescription');
                var descriptionElementObjThis = descriptionDiv.last();
                if (descriptionElementObjThis.data('expandeddefault') === true)
                expandedDefault = true; //re-define if value is true
                $(descriptionElementObjThis).removeClass('hidden');

                    if(descriptionElementObj.data('moretext'))
                    moreText = descriptionElementObjThis.data('moretext'); //re-define if data- exists!

                    if (descriptionElementObj.data('lesstext'))
                        lessText = descriptionElementObjThis.data('lesstext'); //re-define if data- exists!

                $(descriptionElementObjThis).ellipsis({
                    row: 3,
                    callback: function() {
                        var itext = $(this).text();
                        //callback appears to run even when you can't elipisis text as its too short so lets check for "..." at end of string.
                        var isEllipsised = itext != descriptionElementObjThis.siblings('.js-fulldescription').text().trim();
                        if(isEllipsised && itext.endsWith('...') && !descriptionElementObjThis.siblings('.js-moreless').text()) {
                            descriptionElementObjThis.after("<a href='#' class='js-moreless'>" + (expandedDefault === false ? moreText : lessText) +"</a>");
                        }
                        if(expandedDefault === true)
                        descriptionElementObjThis.addClass('hidden');
                    }
                });
                $('.js-moreless').unbind('click').click(function(e){
                    e.preventDefault();

                    var ithis = $(this),
                        ithistext = ithis.text();

                    if (ithistext === moreText)
                        ithis.text(lessText); 
                    else
                        ithis.text(moreText);

                    ithis.siblings(descriptElementSelectorName).toggleClass('hidden');

                });
            });
        });
    });*/
    /*for more less description on search results page with bootstrap shown.bs.collapse*/ 


    (function(){
        //this is for the relatedContentDropdown.tag
        var relatedtitle = $('.js-filter-group-list li.js-relatedtitle'),
            furtherReading = $('.js-filter-group-list li.js-furtherReading'),
            databaseEditiontitle = $('.js-filter-group-list li.js-databaseEditiontitle'),
            relatedDatabasetitle = $('.js-filter-group-list li.js-relatedDatabasetitle');
            relatedIndicatortitle = $('.js-filter-group-list li.js-relatedIndicatortitle'),
            isSourceOftitle = $('.js-filter-group-list li.js-isSourceOftitle');
            if(relatedtitle.length > 1){
                    //console.log('order related titles!');
                relatedtitle.tsort('a');
            }
            if(furtherReading.length > 1){
                //console.log('order further reading!');
                furtherReading.tsort('a');
            }
            if(databaseEditiontitle.length > 1){
                //console.log('order databaseEditiontitle!');
                databaseEditiontitle.tsort('a');
            }
            if(relatedDatabasetitle.length > 1){
                //console.log('order relatedDatabasetitle!');
                relatedDatabasetitle.tsort('a');
            }
            if(relatedIndicatortitle.length > 1){
                //console.log('order relatedIndicatortitle!');
                relatedIndicatortitle.tsort('a');
            }
            if(isSourceOftitle.length > 1){
                //console.log('order isSourceOftitle!');
                isSourceOftitle.tsort('a');
            }
    })(); //self executing anonymous function.
     
    (function(){
        //this is for the relatedindicatorsanddatabases.tag
        var elementSelector = $('.js-dropdown-menu li');
            if(elementSelector.length > 1){
                elementSelector.tsort('a');
            } 
    })(); //self executing anonymous function.

    $('.js-citation-display').on('click', function(e){
        e.preventDefault();
        var ithis = $(this),
            ajaxUrl = ithis.closest('form').attr('action'),
            citationModal = ithis.next('.modal'), //next sibling
            citationTitle = ithis.data('title');
        
            
        //check both modal and ajaxURl values are NOT (null, NaN, empty, false or undefined).
        // &&
        //the class is-ajax-triggered is NOT called.
        if (ajaxUrl && citationModal && !ithis.hasClass("is-ajax-triggered")) {
            ithis.addClass('is-ajax-triggered');
            //append loader icon to dialogue
            citationModal.find('.modal-body').prepend('<i class="fa fa-spinner fa-pulse fa-3x fa-fw"></i> \
                    <span class="sr-only">Loading...</span>');
            
            //launch modal display.
            citationModal.modal(); 
            $.ajax({url: ajaxUrl,
                timeout: 30000,
                type:'get',
                success: function(resp){ 
                    //remove loader icon
                    citationModal.find('.fa-spinner').remove();
                    
                    
                    var response = $(resp); //make jQuery object
                    var appendPoint = citationModal.find('.js-citation-append');
                    
                    //append citation to dialogue!
                    appendPoint.prepend(response.filter('.js-display-citation').contents());
                    
                    //append citation export options to dialogue!
                    appendPoint.after(response.filter('.js-citation-export-options').contents());
                    
                    if (citationTitle) {
                        dataLayer.push({"customCategory" :"engagement",
                            "customAction":"citeThisDocument","customLabel": citationTitle,
                            "event":"customEvent"})
                    } 
                },
                error: function(resp) {
                    citationModal.find('.fa-spinner').remove(); //remove spinner icon
                    var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                    console.log(cMsg);
                }
            }); 
        } else if (citationModal) {
            //console.log('I got ere!');
            citationModal.modal('toggle');
        }
    }); 

    /*For periodicals navigation*/
        $(".js-navigation-trigger").click(function(e){
                e.preventDefault();
                var ithis = $(this);
                var ahahURL = ithis.attr('href');
                var navigationdetail = ithis.next(".js-navigationdetail");
                
                if(navigationdetail.find('li').length == 0){
                var spinnerIcon = $('<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
                ithis.next().prepend(spinnerIcon);

                $.ajax({url: ahahURL,
                timeout: 30000,
                type:'get',

                success: function(resp){
                    ithis.next(navigationdetail).html(resp);
                    ithis.next(navigationdetail).show(); 
                    spinnerIcon.remove();
                    },
                    error: function(resp) {
                        ithis.next(navigationdetail).remove();
                        spinnerIcon.remove();
                        var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                        if (!$.browser.msie) {
                          console.log(cMsg);
                        }
                    }
                });
            }
        });
    /*For periodicals navigation*/

    /*Coming soon*/ 
       /* $(".js-comingsoon_item li").slice(0, 3).show();
        $(".js-moreitem").on('click',function(){
            $(".js-comingsoon_item li:hidden").slideDown();
            $(this).parent().hide();
        });*/
    /*Coming soon*/  


    /* For Navigation Dropdown sorting */
        function orderThemeCountry() {
            $('.js-orderlist').each(function(){
                 var $this = $(this), 
                     collength = parseInt($this.find('ul').data("collength")),
                     statListObj = $this.find("li").detach(),
                     nodeStart = 0,
                     nodeEnd= collength,
                     statJavascriptNodeList = statListObj.get(), //converts jQuery Object into javscript nodelist.
                     statJavascriptNodeArray;
                 
                if (statJavascriptNodeList.length > 0) {
                     //reorder detached list in alphabetical order. using native js methods for maximum speed.
                     statJavascriptNodeList.sort(function(a, b) {
                           return a.innerText.localeCompare(b.innerText, lang);
                        })
                     
                     //convert ordered nodelist to an Array list to allow us to use array methods such as splice! 
                     statJavascriptNodeArray = Array.prototype.slice.call(statJavascriptNodeList);
                        
                        //loop is fixed at 2 as there are always 2 columns
                     for (var i = 0; i < 6; i++) { 
                             var colOrdered =  statJavascriptNodeArray.splice(nodeStart,nodeEnd),
                                 existingColumn = $this.find(".js-ul_cont:eq(" + i + ")");
                                //jQuery magicaly does all the work for us and converts the Array list to Jquery Object with the dollar function!
                                existingColumn.append($(colOrdered));
                         }
                }
             
            });
        }
        
        var lang = $('html').attr('lang');
        if (lang === 'fr' || lang === 'en' || lang === 'ja'){
            orderThemeCountry();
        }
    /* For Navigation Dropdown sorting */


    /*Datasets section*/
  /* Hello Rajinder now using event delegation event syntax no longer need to make call from Ajax calls */
            $(".js-hidesection, .js-nestedResultBox").on('click',".js-childlist", function(e){
                e.preventDefault();
                var ithis = $(this);
                var ahahURL = ithis.attr('href');
                var results = ithis.closest('.panel').find(".js-nestedbox");
                if(results.find('.js-nestedResultBox').length == 0){
                    var loaderImg = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
                    ithis.prepend(loaderImg);
                    $.ajax({url: ahahURL,
                    type:'get',
                    success: function(resp){
                        results.html(resp);
                        results.show();
                        loaderImg.remove();
                        jspopover();
                    },
                    error: function(resp) {
                        results.remove();
                        loaderImg.remove();
                        var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                        if (!$.browser.msie) {
                        console.log(cMsg);
                        }
                    }
                 });
                }
            });
            
            
            
    /*Datasets section*/

    (function(){
        var numAjax = 0;
        var numAjaxCompleted = 0;
        /*For Toc & summary*/
            var ahahFirstFunction = function(elem, loaderReplaceElementClass){
            var ahahURL = elem.find(loaderReplaceElementClass).attr('href');
            var $loaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
            var $loaderAppendElement= $(loaderReplaceElementClass);
            $loaderAppendElement.replaceWith($loaderIcon);
         
                if(ahahURL) {
                    numAjax++;
                    $.ajax({url: ahahURL,
                        type:'get',
                        success: function(resp){
                            elem.find(loaderReplaceElementClass+'-box').html(resp);
                            elem.find(loaderReplaceElementClass+'-box').show();
                            jspopover();
                            $loaderIcon.remove();
                            numAjaxCompleted++;
                            elem.find(loaderReplaceElementClass+'-box .js-childlist').trigger('click');
  
                        },
                        error: function(resp) {
                         var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                             if (!$.browser.msie) {
                                  console.log(cMsg);
                             }
                            numAjaxCompleted++;
                            $loaderIcon.remove();
                         }
                    });
                }
            };
            ahahFirstFunction(ithis,'.js-summary'); 
            ahahFirstFunction(ithis,'.js-toc');
                /*For Toc & summary TODO rename function*/
            
   


        /*For Tables & Graphs*/
            var ahahSecondFunction = function(elem, loaderReplaceElementClass, moreClassName, componentClassName){
                function ahahFirstMoreClass(){
                    $(moreClassName).off('click').on('click', function(e){
                    e.preventDefault();
                    var ithis = $(this);
                    var ahahURL = ithis.attr('href');
                    ithis.hide();
                    ithis.off('click');
                    var $componentLoaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
                    ithis.parents(componentClassName).append($componentLoaderIcon);
                    $.ajax({url: ahahURL,
                        type:'get',
                        success: function(resp){
                            ithis.parents(componentClassName).find('.js-remove').remove();
                            ithis.parents(componentClassName).append(resp);
                            jspopover();
                            $componentLoaderIcon.remove();

                            var component_table = ithis.parents(componentClassName).find(".js-ajax_component_thematic");
                            var componentthematiclen_table = component_table.length;

                            $.each(component_table, function (i, item) {
                                var ahahURL = $(component_table[i]).attr('href');
                                var result_table_box=componentClassName + " .ajax_component_thematic_box";
                                result_table_box=result_table_box.concat((i+1).toString());
                                $('.js-ajax_component_thematic').replaceWith("<img src='/images/instance/loader.png' class='loader loader-center'/>");
                                    if(ahahURL) {
                                        $.ajax({url: ahahURL,
                                        type:'get',
                                            success: function(resp){
                                                $(result_table_box).html(resp);
                                                $(result_table_box).show(); 
                                                jspopover();
                                                $('.loader').remove();
                                                
                                            },
                                            error: function(resp){
                                                var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                                                if (!$.browser.msie) {
                                                    console.log(cMsg);
                                                }
                                                $('.loader').remove();
                                            }
                                        });
                                    }
                                });   
                        },
                        error: function(resp) {
                               ithis.parents(componentClassName).remove();
                                var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                                if (!$.browser.msie) {
                                    console.log(cMsg);
                            }
                            $componentLoaderIcon.remove();
                        }
                    });
                    });    
                }
                ahahFirstMoreClass(); 

                var ahahURL = elem.find(loaderReplaceElementClass).attr('href');
                var $loaderIcon = $("<img src='/images/instance/loader.png' class='loader loader-center'/>");
                var $loaderAppendElement= $(loaderReplaceElementClass);
                $loaderAppendElement.replaceWith($loaderIcon);
                    if(ahahURL) {
                        numAjax++;
                        $.ajax({url: ahahURL,
                            type:'get',
                            success: function(resp){
                                elem.find(loaderReplaceElementClass+'-box').html(resp);
                                elem.find(loaderReplaceElementClass+'-box').show();
                                jspopover();
                                $loaderIcon.remove();
                                numAjaxCompleted++;
                                ahahFirstMoreClass();
                                $(componentClassName).find(".js-childlist").trigger('click');
                                
                            },
                            error: function(resp) {
                                var cMsg = "'the response was:" + resp + "' failed due to: " + resp.status + " (" + resp.statusText + ")";
                                if (!$.browser.msie) {
                                    console.log(cMsg);
                                }
                                numAjaxCompleted++;
                                $loaderIcon.remove();
                            }
                        });
                    }
            };
            ahahSecondFunction(ithis,".js-tables",".js_more_Tables",'.js-component-Tables');
            ahahSecondFunction(ithis,".js-graphs",".js_more_Graphs",'.js-component-Graphs');
        /*For Tables & Graphs*/

        var interval = setInterval(function(){        
        if(numAjaxCompleted > 0 && numAjaxCompleted == numAjax){
            var sections = ithis.find(".js-hidesection");
                sections.each(function(section){
                     if(!$(this).find('div.row').length){
                         $(this).remove();
                     }
                });
            clearInterval(interval);
            }
        },500);

    })();

    $('form[name="countryThemeForm"]').submit(function(e){
        var $this = $(this);
        var themeCount = $this.find('input[name="value1"]:checked').length;
        var countryCount = $this.find('input[name="value2"]:checked').length;

    	if(themeCount == 1 && countryCount == 0){
    	    e.preventDefault();
    	    var themeLink = $this.find('input[name="value1"]:checked').siblings('span').data('link');
    	    window.location.href = themeLink;
    	}

    	else if(themeCount == 0 && countryCount == 1){
    	    e.preventDefault();
    	    var countryLink = $this.find('input[name="value2"]:checked').siblings('span').data('link');
    	    window.location.href = countryLink;
    	}

    });
    
    $('.js-mobile-filter-table').on('change', function(e){
        var $this = $(this),
             $thisvalue = $this.val(),
             idOfTabletoSort = $('#collectionsort'),
             urlToLoad;
        //get url's from desktop table view
             
        
            switch ($thisvalue)
            {
               case "Date":
                   urlToLoad = idOfTabletoSort.find('.js-date-filter').find('.js-desc-link:not(.highlight)').attr('href');
                   if (!urlToLoad) {
                       urlToLoad = idOfTabletoSort.find('.js-date-filter').find('.js-asc-link:not(.highlight)').attr('href');
                   }
                   break;
                   
               case "Title": 
                   urlToLoad = idOfTabletoSort.find('.js-title-filter').find('.js-desc-link:not(.highlight)').attr('href');
                   if (!urlToLoad) {
                       urlToLoad = idOfTabletoSort.find('.js-title-filter').find('.js-asc-link:not(.highlight)').attr('href');
                   }
                   break;
               default:
                   break;
            }
            
            if (urlToLoad) {
                window.location.href = urlToLoad;
            }
            
            
            function sortUsingNestedText(parent, childSelector, keySelector, sortAttribute) {
            	var sortOrder=(parent.attr(sortAttribute) == 'asc' ? -1 : 1);
                var items = parent.children(childSelector).sort(function(a, b) {
                	if(sortAttribute == 'data-sortDate') {
                		var vA = new Date($(keySelector, a).text());
                        var vB = new Date($(keySelector, b).text());
                	}
                	else {
                		var vA = $(keySelector, a).text();
                        var vB = $(keySelector, b).text();	
                	}
                    
                    return (vA < vB) ? sortOrder : (vA > vB) ? -(sortOrder) : 0;
                });
                parent.append(items);
                parent.attr(sortAttribute,(sortOrder == -1 ? 'desc' : 'asc'));
                $('#defaultSelectorDropdown').prop('selectedIndex', 0);
            }

          
            switch ($thisvalue)
            {   
               case "Title": 
            	   sortUsingNestedText($('#mobileTableView'), "div", "strong.item-title", "data-sortTitle");
                   break;
               case "Date": 
            	   sortUsingNestedText($('#mobileTableView'), "div", "strong.item-date", "data-sortDate");
                   break;
               default:
                   break;
            }
            
    });
});

     


