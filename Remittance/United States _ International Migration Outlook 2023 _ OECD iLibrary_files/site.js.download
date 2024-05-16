var findToggleContent = function(obj) { 
    return $(obj).siblings(".togglecontent").add($(obj).parent().siblings(".togglecontent"));
};


function isEmpty(str) {
    return (!str || 0 === str.length);
}


function doubleTitleLinks(){

 /* ==================================
      double icon issue / search results due to title having link it in.
      ========================================*/
    $("[target='xrefwindow']").each(function(){
    /*  each href link to a doi in a title has span wrapped around it and parent Href given a class */
    var thisParent = $(this).parent();
    $(this).wrap("<span class='wrapTitle'></span>");
       $(".wrapTitle").prev().addClass("emptyHref"); 
    });

    // remove the link for the doi part of the title
     $("[target='xrefwindow']").children(".jp-italic").unwrap("<a></a>");

   // look through each empty href (due to an internal href in title)  
    $(".emptyHref").each(function(){
        var $this = $(this);
        var $thisParent = $(this).parent();
        var hrefT = $(this).attr("href"), hrefC = $(this).text();
        
        // $(this).parent().append(hrefT);
        $(this).parent().prepend(hrefC);
        $(this).parent().wrapInner("<a href='' class='newLinkWrapper'></a>");
        $(this).append(hrefC);
        $(this).parent().attr("href",hrefT);

        $(this).remove();

    });
    /* ==========================================================================*/


}

//anonymous function so vars are not in global scope.
(function(){
var currentUrl = window.location.href,  
    urlParts = currentUrl.split("?"),
    queryString = urlParts[1],
    queryStringParts = [],
    paramKeyValuePair = [],
    latestIssueLink = $("#currentissuetab > a").attr("href");
//if not empty or null etc
    if (queryString && latestIssueLink) {
        queryStringParts = queryString.split("&"); 
        // if no further queryStringParts
        if (queryStringParts.length === 0){
            queryStringParts[0] = queryString;  
        }

        for (var i= 0; i < queryStringParts.length; i++) {
            
            paramKeyValuePair = queryStringParts[i].split('=');
            if (paramKeyValuePair[0] === 'open' && paramKeyValuePair[1] === 'latestissue') {
                //redirect to the url of the #currentissuetab url
                window.location.href = latestIssueLink;
            }
        }
        
       
    }

})();



/**
 * Loads a JavaScript script from the cache, if available
 */
jQuery.cachedScript = function(url, options) {
    // allow user to set any option except for dataType, cache, and url
    options = $.extend(options || {}, {
        dataType : "script",
        cache : true,
        url : url
    });
    // Use $.ajax() since it is more flexible than $.getScript
    // Return the jqXHR object so we can chain callbacks
    return jQuery.ajax(options);
};


var ingentaCMSApp = ingentaCMSApp || {
    consoleOK: (typeof console === undefined ? false : true),
    instanceprefix: $('body').data('instanceprefix'),  
    flipMoreLess: function(evt, listLinkContainerElement, toggleLinkContainerElement) {
        var $here = $(evt.target),
            maxItemsDisplayPerClick = $here.data('showMoreIncrementer');
        
            evt.stopImmediatePropagation(); // not sure we need this but i will leave just in case....
            evt.preventDefault();
  
        
    if ($.isNumeric(maxItemsDisplayPerClick)) {
          var thislistLinksContainer = $here.closest(listLinkContainerElement),
              hiddenElemIdent = toggleLinkContainerElement + ':hidden',
            hiddenElements = thislistLinksContainer.find(hiddenElemIdent); 
        if (hiddenElements.length > 0){
            hiddenElements.slice(0, maxItemsDisplayPerClick).slideDown();
            
            //re-check DOM again now we have displayed the next x number if any more to display.
            if (thislistLinksContainer.find(hiddenElemIdent).length == 0){
                //remove more link if no more to display
                $here.parent().hide();
            }
        } else {
                $here.parent().hide();

        }
           
       } else {
            if ($here.hasClass("moreLink")) {
                $here.parent().siblings(toggleLinkContainerElement).show();
                $here.hide();
                $here.siblings(".lessLink").show();
            }
            if ($here.hasClass("lessLink")) {
                $here.parent().siblings(toggleLinkContainerElement).hide();
                $here.hide();
                $here.siblings(".moreLink").show();
            }
       }    
    },
    /**
     * Changes more or less, second type
     * 
     * @param {event}        Click event
     * @param {string}       Selector 1
     * @param {string}       Selector 2
     * 
     *  */
    flipMoreLess2: function (evt, selector1, selector2) {
        var $here = $(evt.target);
        evt.stopImmediatePropagation();
        evt.preventDefault();
        if ($here.hasClass("moreLink2")) {
            $here.parent().siblings(selector1).find(selector2).show();
            $here.hide();
            $here.siblings(".lessLink2").show();
        }
        if ($here.hasClass("lessLink2")) {
            $here.parent().siblings(selector1).find(selector2).hide();
            $here.hide();
            $here.siblings(".moreLink2").show();
        }
    },
    /**
     * Add event logging any PDFs within the location
     * @param location the part of the DOM where PDF download links can be found
     */
    addPdfMessageLogging: function(location) {
        location.find(".pdf a").click(function(e) {
           if (_gaq) {
               _gaq.push(['_trackEvent', 'Download', 'PDF', this.href]);
           }
        });
    },
    siq: function(siqUrl, webId, pageTitle, doi, eventType, logPub2webEvent, searchTerm, callback) {
        //if (ingentaCMSApp.consoleOK) {console.info("siq(): " + "\n url: " + siqUrl + "\n webId: " + webId + "\n title: " + pageTitle + "\n DOI: " + doi +  "\n type: " + eventType + "\n log: " + logPub2webEvent + "\n search term: " + searchTerm + "\n callback: " + callback);}
        if (!searchTerm) {
            searchTerm = "";
        }
        // Pending items should not have any pub2web events logged
        if ($("#isPending").length > 0) {
            logPub2webEvent = 'false';
        }
        var data = {
            itemId : webId,
            pageTitle : pageTitle,
            doi : doi,
            eventType : eventType,
            logPub2webEvent : logPub2webEvent,
            searchTerm : searchTerm
        };
        // A load is required rather than get for the script element to be run by  the browser - similarly no suffixed selector is permitted
        $("#siqResponse").load(siqUrl, data, function(contents) {
            if (callback) {
                callback(contents);
            }
        });
    },
    displayGraphOrTable: function($dataTable, graphType, graphId, graphTitle, eMsg) {
        var lineData = this.extractDataFromTable($dataTable);
        try {
            this.plotGraph(graphType, graphId, lineData);
        } catch (e) {
            if (this.consoleOK) {console.log(graphId + " failed with: " + e.message);}
            this.displayTabularMetrics(graphTitle, graphId, eMsg);
        }
    },
    /**
     * Extracts data from the table of data
     *
     * @param {jQuery object} table     Table containing relevant data
     */
    extractDataFromTable: function(table) {
        var lineData = [];
        table.find("tbody tr").each(function(index) {
            var $row = $(this),
                rowData = [];
            // APPEND the individual pieces of data
            // *** Be aware that we need to force the type of the count ***
            // *** otherwise jqplot fails...                            ***
            rowData.push($row.find(":nth-child(1)").text());
            rowData.push(+$row.find(":nth-child(2)").text());
            // PREPEND each set of data...
            lineData.unshift(rowData);
        });
        return lineData;
    },
    pendingPlots: [],
    /**
     * Plots graphs for metrics (pie and line only)
     *
     * @param {string} gtype graph type: pie|other (actually 'line')
     * @param {string} target id to which to attach output
     * @param {object} data data to graph
     */
    plotGraph: function(gType, target, data) {
        function canvasSupported() {
            var canvas = document.createElement('canvas');
            return (canvas.getContext && canvas.getContext('2d'));
        }
        // Because of crossmark we have to look in both places
        if ($ != jQuery) {
            jQuery = $;
        }
        if (typeof $.jqplot === "undefined") {
            ingentaCMSApp.pendingPlots.push({
                "gType": gType,
                "target": target,
                "data": data});
            if (ingentaCMSApp.pendingPlots.length == 1) {
                var url = canvasSupported() ? 
                            "/js/" + ingentaCMSApp.instanceprefix + "/jquery.jqplot." + ingentaCMSApp.instanceprefix +".js" 
                            : "/js/" + ingentaCMSApp.instanceprefix + "/jquery.jqplot." + ingentaCMSApp.instanceprefix + ".ie8.js";
                $.ajax({
                    dataType: "script",
                    cache: true,
                    url: url,
                    success: function () {
                        for (var i = 0 ; i < ingentaCMSApp.pendingPlots.length ; i++) {
                            ingentaCMSApp.plotGraphWithJqplot($.jqplot, ingentaCMSApp.pendingPlots[i].gType, ingentaCMSApp.pendingPlots[i].target, ingentaCMSApp.pendingPlots[i].data);
                           
                        }
                        
                        
                    }
                });
            }
        } else {
            ingentaCMSApp.plotGraphWithJqplot($.jqplot, gType, target, data);
        }
    },
    /**
     * Plots graphs with jqplot for metrics (pie and line only)
     *
     * @param {object} jqplot itself
     * @param {string} gtype graph type: line|pie
     * @param {string} target id to which to attach output
     * @param {object} data data to graph
     */
    plotGraphWithJqplot: function(jqplot, gType, target, data) {
        var pieLabels = [],
            plotOptions = {},
            seriesColours = ["#1a6594", "#f0bd68", "#d6caa5"],
            total = 0,
            PLOT_MSG1 = "Unable to plot metrics: no HTML target given...";
        
        
         
     

        switch (gType) {
        case "pie":
            total = 0;
            $(data).map(function() {
                total += this[1];
            });
            pieLabels = $.makeArray($(data).map(function() {
                return this[0] + " (" + Math.round((this[1] * 100) / total) + "%)";
            }));

            plotOptions = { 
                // Define colours to use...
                seriesColors: seriesColours,
                // Define various overall defaults
                seriesDefaults: {
                    renderer: jqplot.PieRenderer,
                    rendererOptions: {
                        dataLabels: pieLabels,
                        dataLabelPositionFactor: 0.75,
                        highlightMouseDown: false,
                        highlightMouseOver: false,
                        showDataLabels: true,
                        sliceMargin: 10
                    }
                }
            };
            break;
             default:
                 // OK this is to get the max date we only want to plot up to the maximum date 
                 // since the data array is not ordered chronologically we have to do some Javascript work ....
                 var dateArray = [];
                 data.forEach( function(d) { 
                     var datePart = d[0];
                     //need to make a valid javascript date pattern 10/08/2015
                     datePart = datePart.substr(0, datePart.indexOf(' '));
                     datePart = datePart.split("-").join("/");
                     dateArray.push(new Date(datePart));
                   
                 }); 
                 
                 var maxDate=new Date(Math.max.apply(null,dateArray));
              
                 
            plotOptions = {
                // Define colours to use...
                seriesColors: seriesColours,
                // Define various other overall defaults
                seriesDefaults: {
                    shadow: false,
                    showMarker: false
                },
                // Define the defaults for both axes
                axesDefaults: {
                    tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                    tickOptions: {
                        fontSize: "10pt"
                    }
                },
                // Define specific properties for the X axis
                // tickInterval = 60 * 60 * 24 * 30 * 1000
                // (milliseconds in 30 days)...
                axes: {
                    xaxis: {
                        renderer: jqplot.DateAxisRenderer,
                        pad: 0,
                        max: maxDate,
                        tickOptions: {
                            angle: -90,
                            formatString: "%b - %Y  "
                        }
                        
                    },
                    yaxis: {
                        min: 0,
                        tickOptions: {
                            formatString: "%7d  "
                        }
                    }
                },
                highlighter: {
                    show: true,
                    sizeAdjust: 10
                },
                cursor: {
                    show: false
                }
            };
            break;
        }
        if (target) {
            var plot = jqplot(target, [data], plotOptions);
            
            $(window).resize(function() {
                plot.replot( { resetAxes: true } );
                });
        } else {
            alert(PLOT_MSG1);
        }
    },
    /**
     * Display metrics data as a table (normally following a failure with plotting)
     *
     * @param {string}  tableName
     * @param {string}  graphName
     * @param {string}  eMsg
     */
    displayTabularMetrics: function(tableName, graphName, eMsg) {
        var currTable = $("#" + tableName);
        currTable.before(eMsg);
        currTable.find("tbody .metricDate").each(function(index) {
            var currItem = $(this),
                dateStr = currItem.text(),
                mDate = new Date(dateStr.substr(0, 10));
            currItem.text(mDate.toDateString());
        });
        currTable.find(".metricDate, .totalCount").addClass("metricsErrorDesc");
        currTable.find(".metricCount").addClass("metricsErrorCount");
        currTable.addClass("metricsErrorTable");
        $("#" + graphName).addClass("hideMe");
    },
    /**
     * Handles the chevron interaction
     *
     * @param {jQuery object} $here         Current location
     */
    handleChevrons: function($here) {

        if ($here.hasClass("down")) {
            var $foundChevron = this.findChevronContent($here);
            $foundChevron.removeClass("hidden"); // KLOC : this remained hidden, so slideup / down was not shown on RWD version, so removed it here.
            $foundChevron.slideDown();
            this.changeChevronDirection($here, "down");
        } else if ($here.hasClass("up")) {
            this.findChevronContent($here).slideUp();
            this.changeChevronDirection($here, "up");
        }
    },
    /**
     * Changes the direction of the chevrons
     *
     * @param {jQuery object} $here         Current location
     * @param {string}        direction     Direction of arrow (down | up)
     */
    changeChevronDirection: function($here, direction) {
        if (direction === "down") {
            $here.removeClass("down").addClass("up").find("img").attr("src", "/images/aip/chevron_up.gif");
        } else if (direction === "up") {
            $here.removeClass("up").addClass("down").find("img").attr("src", "/images/aip/chevron_down.gif");
        }
    },
     /**
     * Displays small dialog box with variable heading and text
     *
     * @param {event object}    Event object
     * @param {string}          Heading
     * @param {string}          Anchor
     * @param {string}          (Short) text message to display
     * @param {string}          Width of dialog box (optional)
     * @param {string}          Height of dialog box (optional)
     * @param {string}          my position (optional)
     * @param {string}          at position (optional)
     * @param {string}          include Don't show again & related cookies, string is unique id (optional)
     * @param {string}          text for a Close button, only shows if this is set  (optional)
     * @param {string}          URL for destination of button, if null will close dialog
     */
    displaySmallDialog: function(e, anchor, heading, text, width, height, myPos, atPos, inclDSAid, inclCBtnText, inclCBtnLink) {
        var $this = $(e.target),
            $dialogHook = $(anchor),
            dWidth = width || 200,
            dHeight = height || 125,
            dMyPos = myPos || "left top",
            dAtPos = atPos || "left bottom",
            userName = encodeURI($('.signedinas + .signedinas').text());
        e.preventDefault();
        if ($dialogHook.length) {
            $dialogHook.dialog({
                autoOpen : false,
                height : dHeight,
                modal : false,
                position: {
                    my: dMyPos,
                    at: dAtPos,
                    of: $this
                },
                resizable : true,
                width : dWidth
            });         
            $dialogHook.find(".dialogText").remove();

            $dialogHook.dialog().parent(".ui-dialog").wrap("<div class=\"signInOrRegisterWrapper\"></div>");
            
            $dialogHook.dialog("open");

            if (heading) {
                $dialogHook.append("<h2 class=\"dialogText\">" + heading + "</h2>");
            }
            if (text) {
                $dialogHook.append("<span class=\"dialogText\">" + text + "</span>");
            }
            if (inclDSAid) {
                $dialogHook.append("<br/><input id=\"dontShowAgain\" class=\"dialogText dontShowAgain\" type=\"checkbox\" id=\""+inclDSAid+"\" checked /> <label class=\"dialogText\" for=\"dontShowAgain\">Don't show again.</label>");
                //if checkbox shown, close button is req
                $dialogHook.append("<button class=\"dialogText dontShowAgain dialog-close\">Close</button>");
                $('button.dontShowAgain').click(function(e){
                    if( $('input.dontShowAgain').prop('checked') ){
                        libCookies.setCookie(inclDSAid+userName, inclDSAid, 'Fri, 31 Dec 9999 23:59:59 GMT')
                    }
                });
                
            }
            if (inclCBtnText && !inclCBtnLink) {
                $dialogHook.append("<span class=\"dialogText\"><br/><button class=\"dialog-close\">" + inclCBtnText + "</button></span>");
            } else if (inclCBtnText && inclCBtnLink) {
                $dialogHook.append("<span class=\"dialogText\"><br/><a href=\""+inclCBtnLink+"\"><button >" + inclCBtnText + "</button></a></span>");
            }
            
            //only applies when Close button present
            $('.dialog-close').click(function(){
                $dialogHook.dialog("close");
            });
        }
    },
    /**
     * Find any content associated with the chevron
     *
     * @param {object}   jQuery context
     */
    findChevronContent: function(context) {
        return context.siblings(".chevroncontent").add(context.parent().siblings(".chevroncontent"));
    },
    /**
     * Default term gray text by case
     */
    defaultSearchTerm: "Search Sabinet",
    defaultSearchTermWithinOption: "Search",
    defaultAdvSearchTerm: "Enter Keywords/Phrases",
    defaultRefineTerm: "Refine your search",
    defaultTopicSearchTerm: "Search within topics",
    linkItemsList: [],
    searchBoxArray: ["#quickSearchBox", "#advanced-search-form #value1", "#searchRefineBox", "#topicSearchBox"],
    defaultFocusAndBlur: function(inputId){
        var checkTerm;
        switch( inputId ) {
            case '#quickSearchBox' :
                checkTerm = $('#searchBox').hasClass('withinPub') ? AIPApp.defaultSearchTermWithinOption : AIPApp.defaultSearchTerm;
                break;
            case '#searchRefineBox' :
                checkTerm = AIPApp.defaultRefineTerm;
                break;
            case '#advanced-search-form #value1' :
                checkTerm = AIPApp.defaultAdvSearchTerm;
                break;
            case '#topicSearchBox' :
                checkTerm = AIPApp.defaultTopicSearchTerm;
                break;
            default:
                return false;
        }

        // when you click into box remove default text
        $(inputId).focus(function() {
            // Check val for search text
            var $searchField = $(this);

            if ($searchField.val() ===  checkTerm || $searchField.val() === '') {
                $searchField.val("");
                $(inputId).removeClass("defaultTerm");
            }
        // add the default text back in if they click out without entering anything
        }).blur(function() {
            // Check val for search text
            var $searchField = $(this);
            
            // Check for empty input
            if ($searchField.val() === "") {
                $(inputId).addClass("defaultTerm");
                $searchField.val(checkTerm);
            }
        });
    },
    goToLocation: function(thislocation) {
        if (location.pathname.replace(/^\//,'') == thislocation.pathname.replace(/^\//,'') && location.hostname == thislocation.hostname) {
            var target = $(thislocation.hash);
            target = target.length ? target : $('[name=' + thislocation.hash.slice(1) +']');
            if (target.length) {
              $('html,body').animate({
                scrollTop: target.offset().top
              }, 1500);
              return false;
            }
        }
    },
    displayElipsisDescription: function() {
        
        //in the case when there is no description to elipses make sure the description box is still hidden!
        $('.js-browse-item .js-description:not(:has(.js-desc))').addClass('hiddenElement'); 
        
        //ok lets get rid of all the HTML formating in the description.
        var descNode = $('.js-browse-item .js-description > .js-desc');
        
        descNode.each(function( index ) {
            $(this).html($(this).text());
        });

      
        descNode.ellipsis({
            row: 3,
            char: ' Read More',
            callback: function() {
                var ithis = $(this),
                    itext = ithis.text(),
                    readMoreURL = ithis.closest('.js-browse-item').find('.js-articleTitle').children('a').attr('href'), //all otherpages
                    readMoreURLAlt = function() { return ithis.closest('.js-browse-item').find('.title').children('a').attr('href') }, //search page only
                    replaceHTML = $("<a href='" + (readMoreURL ? readMoreURL : readMoreURLAlt()) + "' class='readmore'>Read More</a>");
                    ithis.html(itext.replace('Read More', replaceHTML.prop('outerHTML')));
                    
                    
                    ithis.addClass('makevisible')
                        .parent('.js-description')
                            .addClass('hiddenElement');

                
            }
        });
        
    },
    followLink: function(link) {
    	var linkTarget = link.attr('target');
        if (linkTarget && (linkTarget).length > 1){
            this.name = "mainWindow";
            window.open(link.attr('href'), linkTarget)
        } else {
            window.location = link.attr('href');
        }
    },
    appendCSRFHiddenToken: function() {
        //this is used to create a hidden form field that is used to verify 
        //a form submission is done on the site and not by a third party site. 
        // we are re-using re-capatcha functionality for this purpose.
         $('.tokenCSRF_HiddenValue').each(function() {
             let tokenId = ($(this).text()).trim();
             if (tokenId.length > 2){
                 $(this).replaceWith('<input type="hidden" value="'+ tokenId + '" name="timer_id" id="timer_id" />')
             }
         })
    }
};


/*For Chapters tab*/
  $( "#chapters_tab" ).on( "click", function() {
    if($('input[name="articleIds"]').length)
      {
        $("#book div.toc").append('<img id="loader" src="/images/jp/spinner.gif" alt="Loading" width="21">');

        $.ajax({
          method: "GET",
          url: "/pub2web/content/ahahchapters?fmt=ahah&parentlicence=&showAuthors=false&pubIds=" + $('input[name="articleIds"]')[0].value,
            success: function(response, status){
            $('#book .toc').html(response);
          },
          error: function(error,status){}
        });
      }
  });
  /*For Chapters tab*/


    
/* ONLOAD ACTIONS */ 
$(document).ready(function() {

    ingentaCMSApp.displayElipsisDescription();
    
    
    $(".js-back-top").click(function(){
        ingentaCMSApp.goToLocation(this);
 
    });
    
    $("#publisherslistpage .pagination a").click(function(){
        ingentaCMSApp.goToLocation(this);
        
    });

    
    // a-z filter option for smaller screens
    $( ".js-a_to_z_mobile" ).on('change',function() {
        
        var url = $(this).find(':selected').data('url');
        if (!(url.indexOf('/pub2web') == 0)){
            url = $("#hiddenContext").text() + url;
        }
        window.location.href =  url;
    });
    
    var hiddenContext = $("#hiddenContext").text(),
    appUrls = {
        "autosuggest":      hiddenContext + "/search/autosuggest",
        "citations":        hiddenContext + "/content/citations",
        "commentcount1":    hiddenContext + "/commenting/comments/commentscount.action",
        "commentcount2":    hiddenContext + "/commenting/comments/jsoncommentscount.action",
        "metrics":          hiddenContext + "/metrics/metrics.action",
        "morelikethis":     hiddenContext + "/search/morelikethis",
        "search":           hiddenContext + "/search",
        "searchahah":       hiddenContext + "/search/ahahsearch.action",
        "siq":              hiddenContext + "/siq/siq.action",
        "statslogredirect": hiddenContext + "/statslogredirect",
        "statslogwrapper":  hiddenContext + "/statslogwrapper",
        "gatheritems":      hiddenContext + "/collections/gatherItems"
    },
    winProps0 = "location=no,toolbar=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes",
    winProps1 = winProps0 + ",width=700,height=600",    // RightsLink window
    winProps2 = winProps0 + ",width=1024,height=600";   // T&C window

    


     //$("#quickSearchBox").val($(".searchTextDescription").text()).removeClass("lightgrey"); // populate the search box with search term used.
     
    function retrieveAcceptedManuscripts(element){
        var $thisParent = $(element).parent().parent();
        //var dateSectionURL = $thisParent.find(".dateSectionURL").html();
        var showhideStateObj = $thisParent.find(".openCloseDateSection");
        var showhideState = showhideStateObj.html();
        var ajaxUrl = $thisParent.find(".dateSectionURL").html();
        var ajaxSpinner = $thisParent.find("ul.hidden-js-div");
        
        if (!$thisParent.hasClass("errorResp")) {
            $thisParent.find(".fastTrackArticles").slideToggle(function(){
                if (showhideState == "[+]"){
                    showhideStateObj.html("[&ndash;]");
                }else{
                    showhideStateObj.html("[+]");
                }
            });
        }
        
        if (!$thisParent.hasClass("ajaxCalled")){
            $thisParent.removeClass("errorResp");
            $thisParent.addClass("ajaxCalled");
            ajaxSpinner.removeClass("hidden-js-div");
            $thisParent.addClass("ajaxCalled");
            ajaxSpinner.addClass("ajaxCall").removeClass("hidden-js-div");
        
            $.ajax({
                type:"GET",
                url:ajaxUrl, 
                success:function(resp){
                    ajaxSpinner.remove();
                    $thisParent.find(".fastTrackArticles").html(resp);
   
                    
                },
                error:function(resp){
                    $thisParent.find(".fastTrackArticles").html("Error getting articles..");
                    $thisParent.removeClass("ajaxCalled").addClass("errorResp");
                    ajaxSpinner.addClass("hidden-js-div");
                    var errorMsg = "' failed: " + resp.status + " (" + resp.statusText + ")";
                    //console.log(errorMsg);
                }
        
            });
        }
    }
    
/*
    window.onhashchange = function(event){
      var urlPath = document.location;
      var stringLocal = urlPath.toString();
      var hash =  stringLocal.indexOf("#");
    //  console.log("$('div.itemFullTextHtml').data('fulltextcalled') = " + $("div.itemFullTextHtml").data("fulltextcalled"));
    //  var fullTextCalled= ($("div.itemFullTextHtml").data("fulltextcalled") == undefined) ? "true" : "true";
    //  if (!fullTextCalled.length > 0){
         $("#" + stringLocal.substring(parseInt(hash)+5) + " a").trigger("click");
    // }
      
    };
*/  
    
    function createCookie(name, value, days) {
    var expires;
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toGMTString();
        }
        else expires = "";
        document.cookie = name + "=" + value + expires + "; path=/";
    }

    
    //when user clicks sso sign in first save the location in cookie
    $(".ssoSignInLink").click(function(){
        var locationUrl = window.location.href;
        //console.log(locationUrl);
        createCookie("sir", locationUrl, 1);
    });

    // Replace all broken images with placeholder images
    $("img.cover").error(function() {
        $(this).unbind("error").attr("src", "/images/" + ingentaCMSApp.instanceprefix + "/placeholder-image.jpg");
    });
    
    // Replace all broken logos with a placeholder logo.
    $("img.logo").error(function() {
        $(this).unbind("error").attr("src", "/images/" + ingentaCMSApp.instanceprefix + "/placeholder-logo.png");
    });

    
    /* Bookmark dropdown */


    var timeout    = 500;
    var closetimer = 0;
    var bookmarkmenuitem = 0;

    function bookmarkmenu_close() {
        if (bookmarkmenuitem) {
            bookmarkmenuitem.css('display', 'none');
        }
    }

    function bookmarkmenu_timer() {
        closetimer = window.setTimeout(bookmarkmenu_close, timeout);
    }

    function bookmarkmenu_canceltimer() {
        if (closetimer) {
            window.clearTimeout(closetimer);
            closetimer = null;
        }
    }

    function bookmarkmenu_open() {
        bookmarkmenu_canceltimer();
        bookmarkmenu_close();
        bookmarkmenuitem = $(this).find('.moreshareoptions').css('display', 'block');
    }

    document.onclick = bookmarkmenu_close; 


    $(".viewfurthershareoptions").mouseover (bookmarkmenu_open);
    $(".viewfurthershareoptions").mouseout (bookmarkmenu_timer);
    $(".viewfurthershareoptions img").click (bookmarkmenu_open);

    $(".searchDiv .down-button").click(function() {
        return false;
    });
    
    $(".aopTocShowhide h5 a").click(function(e){
        retrieveAcceptedManuscripts($(this));
        return false;
    });

    // AHAH call for citations
    $("#cite").find("a").click(function(e) {
        
            itemId = $("#itemIdForCitations").text(),
            data = {
                "requesttype": "citations",
                "fmt": "ahah",
                "contentitem": itemId
            },
            url = $("#hiddenContext").text() + "/content/citations";


        $.ajax({
            type: "GET",
            data: data,
            url: url,
            dataType: "html",
            success: function(resp, statusText) {
                $(".citingArticlesLoading").remove();
                if (resp !== null) {
                    $("#citationContent").get(0).innerHTML = resp;
                }
            },
            error: function(req, statusText, message) {
                $(".citingArticlesLoading").remove();
            }
        });
    });


    $("#bellowheadercontainer").on("mouseover", ".Digital", function(){
        $(this).closest(".Digital_box").children(".Digital_PopUp").show();
    });
    

    $("#bellowheadercontainer").on("mouseout", ".Digital", function(){
        $(".Digital_PopUp").hide();
    });
    

    $("#bellowheadercontainer").on("mouseover", ".Print", function(){
        $(this).closest(".Print_box").children(".Print_PopUp").show();
    });
    
    
    
    $("#bellowheadercontainer").on("mouseout", ".Print", function(){
        $(".Print_PopUp").hide();
    });
    

    $("#bellowheadercontainer").on("mouseover", ".ApplicationDues", function(){
      $(this).closest(".ApplicationDues_box").children(".ApplicationDues_PopUp").show();
    });
    
    $("#bellowheadercontainer").on("mouseout", ".ApplicationDues", function(){
      $(".ApplicationDues_PopUp").hide();
    });
    
   
    $("#bellowheadercontainer").on("mouseover", ".Webinar", function(){
        $(this).closest(".Webinar_box").children(".Webinar_PopUp").show();
      });
    
   
    $("#bellowheadercontainer").on("mouseout", ".Webinar", function(){
        $(".Webinar_PopUp").hide();
      });
    
    
    // recurring confirm button. set defaults 
    $("#checkout_recurringConfirm").attr("disabled","true");
    $(".buttoncontainerConfirm .blueButtonBG").fadeTo("fast",0.23);
    $("#checkout_recurringConfirm").css("cursor","default");
    // check isnt already checked if so amend attr and fade
    if($("input[name='paymentProfileId']:checked").length > 0){
        $("#checkout_recurringConfirm").removeAttr("disabled");
        $(".buttoncontainerConfirm .blueButtonBG").fadeTo("fast",1);
        $("#checkout_recurringConfirm").css("cursor","pointer");
    }
    // if radio selected remove attr and fade in.
    $(".confirmRadioButton").click(function(){
         $("#checkout_recurringConfirm").removeAttr("disabled");
         $(".buttoncontainerConfirm .blueButtonBG").fadeTo("fast",1);
         $("#checkout_recurringConfirm").css("cursor","pointer");
    });
    
    
    var buyThisBookHeader = $("div.embodiment-header").html();
    if (buyThisBookHeader != null) {
      $(".pubtopright").prepend("<div class='embodiment-header'>" + buyThisBookHeader + "</div>");
    }

    /* Do not show recurring payment options on carts which contain items that do not support this*/
    if ($(".paymentagencies > .authorizecContainer")[0]){
        if ($("input[value='download']").length > 0 || $("input[value='hardcover']").length > 0){
             $(".authorizecContainer").hide();
             $('.radioauthorizec').removeAttr('checked');
             $('.radioauthorize').attr('checked','checked');
        }
     }

    /* Issue due to ahah call so not being bound so applied a click to Export Citations as live/on
    don't work with toggle so changed slightly. BUG 45783 */


    
  $("#bellowheadercontainer").on("click",".js-addToFavouritesButton", function(e) {
          e.preventDefault();
            var favButton = $(this);
            var span = favButton.find("span");
            if (span.length == 0) {
               span = favButton;
            }
            var postToUrl = favButton.closest(".favouritesForm").attr('action');
            var theForm = favButton.closest(".favouritesForm");
            var markedInput = theForm.find("input[name^='MARKED']");
            var event = theForm.find(".favouritestatsevent").text();           
            var statsurl = $("#hiddenContext").text() + "/statslogredirect"; // this is a hack to get it to run on dev!
            
            //this is for favourite the section heading e.g periodical.periodical - /content/periodical/22229566
            var favTitle = theForm.closest(".resume-item").children('a.intro-item').text();
           
            if (!favTitle){
                // for most listing pages.
                 favTitle = theForm.closest(".row").find('.intro-item > a').text();
            }
            if (!favTitle){
                //for search listing results page
                favTitle = theForm.closest(".row").find('.search_title > a').text();
            }
            if (!favTitle){
                // for /collection.jsp - collection.collection page
                favTitle = theForm.closest("tr").find('.title-td > a').text();
            }

            //lets temporarily replace the heart image with spinner image while the item is being set as a faviourite....
            favButton.attr('disabled', 'disabled').find('.favouritesIcon').removeClass('fa-star-o').addClass('fa-spinner fa-spin');
            
            
             
            $.ajax({
                type: "GET",
                url: postToUrl,
                data: theForm.serialize(), // serializes the form's elements.
                success: function(data) {
                    
                    favButton.removeAttr("disabled").find('.favouritesIcon').removeClass('fa-spinner fa-spin').addClass('fa-star-o');
                    /* replicate change to form */
                    if (markedInput.val() == 'on') {
                        // seems a bit counter intuitive to me but this appears 
                        // to be the state when it is added to your favs the off state!
                        if (favTitle) {
                            dataLayer.push({"customCategory" :"engagement",
                                    "customAction": "addToFavorite",
                                    "customLabel": favTitle.trim(),
                                    "event": "customEvent"})
                        }
                        markedInput.val('off');
                        span.removeClass('AddItem').addClass('RemoveItem');
                    } else if (markedInput.val() == 'off') {
                        markedInput.val('on');
                        span.removeClass('RemoveItem').addClass('AddItem');
                    }

                    //theStar.css('background', 'url("/images/sgm/icon-fa.png") no-repeat scroll transparent');

                    /* send stats data */
                    if (event) {
                        $.post(statsurl, {statsLogContents:event});
                     }
                 }
             });
            
        });

     
     
 /* START - Journal - Contents tab*/
    $(".domainListing h2").click(function(){      
       $(this).next().next(".startDiv").slideToggle();
       //$(this).next().next(".startDiv").find(".description").css("display","none");
       $(this).find(".contenttabPlus").toggle();
       $(this).find(".contenttabHide").toggle();
    });
       
     //use images for +/-
     $("#contenthometabid .contenttabPlus").html("<img src=\"/images/sgm/icon_accordion_open.png\" alt=\"[&ndash;]\" />");
     $("#contenthometabid .contenttabHide").html("<img src=\"/images/sgm/icon_accordion_close.png\" alt=\"[+]\" />").hide();
     /* END - Journal - Contents tab*/
    
    /* required to add right slice img blue buttons */
    $("#accountmanagementpage input[type='submit'], #accountdetails input[type='submit']").each(function () {
        var currentClassesButtons = $(this).attr("class");
        $(this).addClass("button-left").wrap("<span class='button-right'>");
        //$(this).parent(".button-right").wrap("<span class='clear "+currentClassesButtons+"'>")
    });
     
  /* */
   $("#value2").click(function(){
     // console.log($(this).find(":selected").attr("name"));
     var optionValue = $(this).find(":selected").attr("name");       
     $(".dropdownCover").html(optionValue);

   });
   
   $("#value2").trigger("click");
   
    
  $(".closeMembershipPopup").click(function(){
      $(this).parent().hide();
  });

    $(".searchDiv select").hover(
        function() {
            // mouseenter action
            $(this).css("cursor", "hand");
        },
        function() {
            // mouseleave action
            $(this).css("cursor", "pointer");
        }
    );

    $(".searchDiv .down-button").hover(function() {
        // mouseenter and mouseleave action
        $(this).css("cursor", "pointer");
    });



    /* Handle a dialog box for figures (and tables) in 'Figures' tabbed section */
    /* Brill provided the basis for this...bookmarkmenuitem                     */

    /* Define the basic dialog box... */
    $("#figuredialog").dialog({
        autoOpen:false,
        height:576,
        width:768,
        modal: true,
        resizable: true,
        position: {
            my: "center",
            at: "center",
            of: $("body")
        }
    });

    $(".figure .journalimg img").click(function() {

        /* Only a single instance of the dialog exists, */
        /* so remember to clear it out each time        */
        $("#figuredialog .figlegend").remove();
        $("#figuredialog .figitem").remove();
        $("#figuredialog p").remove();

        /* Set the width and height as a proportion of the current viewport size */
        var figWidth  = $(window).width()  * 0.8;
        var figHeight = $(window).height() * 0.8;

        var filetitle = $(this).attr("title");
        var filetext  = $(this).attr("alt");
        var fileurl   = $(this).attr("src");
        var filelong  = $(this).attr("longdesc");
        var citationsText= $(this).attr("citationsText");


        var newImg = new Image();
        // If the full size image is available...
        if (filelong != "") {
            newImg.src = filelong;
        } else {
            newImg.src = fileurl;
        }
        // Construct a new dialog...
        newImg.onload = function() {
            imgheight = figHeight;
            imgwidth  = figWidth;
            $("#figuredialog").append('<img class="figitem figimage" src="' + newImg.src + '" />');
            $("#figuredialog").append('<p class="figlegend"> ' + filetext + '</p>');
            $("#figuredialog").append('<p class="figlegend"><strong>Citation:</strong> ' + citationsText + '</p>');

            $("#figuredialog").dialog({ title: filetitle, height: imgheight, width: imgwidth, position: { my: 'center',at: 'center',of:  window}, modal: true, autoOpen:false });
            $("#figuredialog").dialog("open");
        };
        return false;
    });

    $(".figure .journalimg a").click(function() {

        /* Only a single instance of the dialog exists, */
        /* so remember to clear it out each time        */
        $("#figuredialog .figlegend").remove();
        $("#figuredialog .figitem").remove();
        $("#figuredialog p").remove();

        /* Set the width and height as a proportion of the current viewport size */
        var figWidth  = $(window).width()  * 0.8;
        var figHeight = $(window).height() * 0.8;
        var here = $(this).parent();
        var filetitle = here.find(".issuetocfiguretitle").html();
        var filetext  = here.find(".issuetocfiguretext").html();
        var fileurl   = here.find(".issuetocfigureurl").html();
        var filelong  = here.find(".issuetocfigurefilelong").html();
        var citationsText= here.find(".issuetocfigurecitationtext").html();

        var newImg = new Image();
        // If the full size image is available...
        if (filelong != "") {
            newImg.src = filelong;
        } else {
            newImg.src = fileurl;
        }
        // Construct a new dialog...
        newImg.onload = function() {
            imgheight = figHeight;
            imgwidth  = figWidth;
            $("#figuredialog").append('<div class="figlegend"> ' + filetext + '</div>');
            $("#figuredialog").append('<img class="figitem figimage" src="' + newImg.src + '" />');
            $("#figuredialog").append('<div class="figlegend"><strong>Citation:</strong> ' + citationsText + '</div>');

            $("#figuredialog").dialog({ title: filetitle, height: imgheight, width: imgwidth, position: { my: 'center',at: 'center',of:  window}, modal: true, autoOpen:false });
            $("#figuredialog").dialog("open");
        };
        return false;
    });

    $("#figuredialog").bind("dialogbeforeclose", function(event) {
        $("#figuredialog .figlegend").remove();
        $("#figuredialog .figitem").remove();
        $("#figuredialog p").remove();
    });

    //
    // Extract the required social bookmarks...
    //
    // set the list as global, as this is called for search results page.
    var siteListBookmarks = [ 'google','citeulike','digg','bibsonomy','delicious','reddit','researchgate'];
    $(function () {
        // jquery bookmark plugin version 1.4.0 (now a part of JP) supports all bookmarking site.
        // set the list as global, as this is called for search results page.
        $(".js-moreshareoptions").bookmark({
            icons: '/images/jp/bookmarks.png',
            sites: siteListBookmarks
        });

        $(".js-sharelinks").mouseover(function(){
            $(this).find(".js-moreshareoptions").removeClass('hidden').show();
        }).mouseout(function(){
            $(this).find(".js-moreshareoptions").hide().addClass('hidden');
        });
    });

    //
    // Allow the user to click on the fulltext icon itself...
    //

    $("body").on("click", ".fulltext li",function() {
        window.open($(this).find("a").attr("href"));
        return false;
    });

   //
   // Use a pop-up window rather than a full window...
   //
   $("a.popup").click(function(){
      var pWidth  = $(window).width()  * 0.6;
      var pHeight = $(window).height() * 0.6;
      // IF HREF to copyright clearance center, don't add the ? url bit...
      var thishref = $(this).attr("href");
      if (thishref.indexOf("?") > -1) {
         window.open(thishref,'popup','toolbar=no,width=' + pWidth + ',height=' + pHeight);
      } else {
         window.open((thishref+'?url='+window.location.href),'popup','toolbar=no,width=' + pWidth + ',height=' + pHeight);
      }
      return false;
   });

    //
    // Temporary placeholders for adverts
    //
    var emptyPtrn = /empty\.gif/;

    if ($("#OAS_Top a img").length > 0) {
        var targetAd1 = $("#OAS_Top a img");
        try {
            var emptyAd1  = targetAd1.attr("src").match(emptyPtrn);
            if (emptyAd1 == "empty.gif") {
                targetAd1.attr({
                    src:    "/images/sgm/OAS_Top.placeholder.png",
                    width:  "728",
                    height: "90"});
            }
        }
        catch (err) {
            //console.log("Leaderboard advert blocked!");
        }
    }
    if ($("#OAS_Right a img").length > 0) {
        var targetAd2 = $("#OAS_Right a img");
        try {
            var emptyAd2  = targetAd2.attr("src").match(emptyPtrn);
            if (emptyAd2 == "empty.gif") {
                targetAd2.attr({
                    src:    "/images/sgm/OAS_Right.placeholder.png",
                    width:  "120",
                    height: "600"});
            }
        }
        catch (err) {
            //console.log("Skyscraper advert blocked!");
        }
    }

    
   /* back button click in browser will load full text or data and media at the moment.
    var hashSet = false;
    var idname;

    function historyLoad(hash) {
        hash = hash.substring(4);
        if (!hashSet){
            if(hash) { 
             // console.log("hash check for back button commented double click appended, hash = " + hash);
                $("#" + hash + " a").trigger("click");
            } 
        }
    }
        
    $.history.init(historyLoad);
*/

    //
    // Marker for NOT YET IMPLEMENTED
    //
    $("a[href='/mock/notimplemented'], a[href='/pub2web/mock/notimplemented']").each(function() {
        var here = $(this);
        var title = here.attr("title");
        if (title == "") {
            here.attr("title", "FUNCTIONALITY NOT YET IMPLEMENTED");
        } else {
            here.attr("title", title + " - FUNCTIONALITY NOT YET IMPLEMENTED");
        }
    });

    //
    // Marker for EXTERNAL links opening in new window
    //
    $("a[rel='external']").each(function() {
        var here = $(this);
        var title = here.attr("title");
        if (title == "") {
            here.attr("title", "Opens in new window/tab");
        } else {
            here.attr("title", title + " - opens in new window/tab");
        }
    });
    //
    // Disable the link for Supplementary Material title
    //
    $(".supplements h5 a").each(function() {
        var title = $(this).html();
        $(this).parent('h5').html(title).css({"color":"#222222", "font-weight":"normal"});
    });

   /* customizing Affiliation hideshow to avoid conflicts with general show/more sequence */


    $("#bellowheadercontainer").on("click", ".plusaff", function(){
      var $this = $(this);
      $this.siblings(".minusaff").show();
      $this.hide();
      $this.parent().siblings(".descriptionaff").show();
   });
   
    $("#bellowheadercontainer").on("click", ".minusaff", function(){
      var $this = $(this);
      $this.siblings(".plusaff").show();
      $this.hide();
      $this.parent().siblings(".descriptionaff").hide();
   });

   /* customizing Manuscript hideshow to avoid conflicts with general show/more sequence */
 
   $("#bellowheadercontainer").on("click", ".plusmanscript", function(){
      var $this = $(this);
      $this.siblings(".minusmanscript").show();
      $this.hide();
      $this.parent().children(".versioningContainer").show();
   });
 
   $("#bellowheadercontainer").on("click", ".minusmanscript", function(){
      var $this = $(this);
      $this.siblings(".plusmanscript").show();
      $this.hide();
      $this.parent().children(".versioningContainer").hide();
   });

    //
    // Slightly modified Show/Hide sequence...
    //

    $("#bellowheadercontainer").on("click", "#showHideDetail .more",function() {
        var $this = $(this);
        $this.parent().find(".hide").show();
        $this.hide();
        $("#hiddenDetail").toggle();
    });


    
     function showDisclaimer(message){
            $("body").append("<div class=\"overlay\"><div class='disclaimer signoutmessage'>"+message+"<button class='promptBack'>Back</button></div></div>");

            // Set the width and height as a proportion of the current viewport size
            var msgWidth  = $(window).width()  * 0.25;
            var msgHeight = $(window).height() * 0.25;

            $(window).scrollTop(0);
            $(".signoutmessage").css("top", msgHeight);
            $(".signoutmessage").css("left", msgWidth);

            //hide if user clicks
            
            $("body").on("click", ".promptBack", function(){
                 hideDisclaimer();
             });
           
         }
        
        function hideDisclaimer(){
            $("body").removeClass("overlay");
            $("body .overlay").remove();
        }
        
     $("#bellowheadercontainer").on("click", "#showHideDetail .less", function() {
        $(this).parent().find(".more").show();
        $(this).hide();
       $("#hiddenDetail").toggle();
    });
     



    
    //* adding handler for related content more link on article.jsp - as defined in JP site.js was not working *//

    $("#bellowheadercontainer").on("click", "#mostcitedcontent .morelink, #mostviewed .morelink", function(e) {
        $(this).parent().find(".hide").show('blind');
        $(this).after("<div class='lesslink'><a href='#'>&lt; Less</a></div>");
    });
    
    $("#bellowheadercontainer").on("click", "#mostcitedcontent .lesslink, #mostviewed .lesslink", function(e) {
        $(this).parent().find(".hide").hide('blind');
        $(this).remove();
        $(this).find(".morelink").show();
    });
    
    
    $("#bellowheadercontainer").on("click", "#related .morelink",  function(e) {
        $(this).show();
        var element = $(e.target).attr("class");
        //console.log(element);
        if (element == 'more'){
            $(this).find(".more").addClass("hidden");
            $(this).find(".less").removeClass("hidden");
        }else{
            $(this).find(".less").addClass("hidden");
            $(this).find(".more").removeClass("hidden");
            $(this).parent().find(".hide").hide('blind');
        }

    });

    
    /* pub med related slide toggle */
     
    $("#bellowheadercontainer").on("click", "#pubmed_related_content", function(e) {
        $('#pubmed_related_content_authors').slideToggle();
        /* toggle [+] to [-] using this class pubmed_related_plus_minus */
        if ($('span.pubmed_related_plus_minus').html() == "[+]") {
            $('span.pubmed_related_plus_minus').html("[&ndash;]");
        } else {
            $('span.pubmed_related_plus_minus').html("[+]");
        }
    });
    
  //  setUpPlusMinus();    
  //  setTimeout(setUpPlusMinus, 5000); //for related content box on article page, loads after page in finished

  
    
    
    //
    // Handle AoP affiliations...
    //
    $(".author-details .plus").each(function(){
        if (!$(this).hasClass("hide")) {
            $(this).parent().parent().find(".description").hide();
        }
    });

    //
    // Search results expand collapse all
    //
    $(".showlink").click(function(){
        $(this).parent(".showhideall").find(".hidelink").removeClass("inactive");
        $(this).addClass("inactive");
        $(".searchResultItemMetadata .showhide .plus").hide();
        $(".searchResultItemMetadata .showhide .minus").show();
        $(".searchResultItemMetadata .description").slideDown();
        return false;   
    });


    $(".hidelink").click(function(){
        $(this).parent(".showhideall").find(".showlink").removeClass("inactive");
        $(this).addClass("inactive");
        $(".searchResultItemMetadata .showhide .minus").hide();
        $(".searchResultItemMetadata .showhide .plus").show();
        $(".searchResultItemMetadata .description").slideUp();
        return false;   
    });


    
    /* expand code for sections */
    /*$(".sectionsExpand").trigger('click');
    $(".sectionsExpand").click(function(){
         $(this).parent().next().slideToggle();
        if ($(this).hasClass("minusSection")) {
             $(this).removeClass("minusSection").html("[+]");
        }else{
            $(this).addClass("minusSection").html("[&ndash;]");
        }
    });*/
    
    /* make section text and symbol clickable*/
    $(".sectionsExpand").parent('h2').trigger('click');
    $(".sectionsExpand").parent('h2').hover(function () {
        $(this).css("cursor","pointer");
    });
    $(".sectionsExpand").parent('h2').click(function(){
         $(this).next().slideToggle();
        if ($(this).children(".sectionsExpand").hasClass("minusSection")) {
             $(this).children(".sectionsExpand").removeClass("minusSection").html("[+]");
        }else{
            $(this).children(".sectionsExpand").addClass("minusSection").html("[&ndash;]");
        }
    });
    
  
    /* search box - checks if blank before submission */
    $(".js-topNavSearch").click(function(){
        
        var searchBoxValue = $('#quickSearchBox').val();
        var changePlaceholderText = $('#quickSearchBox').data('placeholder');

       if (searchBoxValue === ""){
            $(this).parents('.js-input-search')
                .find('input[placeholder]')
                .attr('placeholder', changePlaceholderText);
            return false;
        } else {
            dataLayer.push({"customCategory" :"navigation",
                    "customAction":"internalSearchTerm",
                    "customLabel": encodeURIComponent(searchBoxValue),
                    "event":"customEvent"})
                //return false;
        }
    });
    
    $("#search_search_lensId").change(function(){
        //console.log(" this value is = " + $(this).val());
        if ( $(this).val() === 'cpdate') {
            $("#search_search_query_0_").val("*").removeClass("required").hide();
            $("#search_search_continDate").addClass("required").show();
            $("label.contindate").show();
        }else{
            $("#search_search_query_0_").addClass("required").show();
            $("#search_search_continDate").removeClass("required").hide();
            $("label.contindate").hide();
        }
    });
    // when page returns results show box again
    if ( $("#search_search_lensId").val() === 'cpdate') {
        $("#search_search_query_0_").val("*").removeClass("required").hide();
        $("#search_search_continDate").addClass("required").show();
        $("label.contindate").show();
    }else{
        $("#search_search_query_0_").addClass("required").show();
        $("#search_search_continDate").removeClass("required").hide();
        $("label.contindate").hide();
    }
    
    
    function pendingColors(){
        $(".qcActions .radioButtons label").eq(0).css("color","black");
        $(".qcActions .radioButtons label").eq(1).css("color","#39dd02");
        $(".qcActions .radioButtons label").eq(2).css("color","red");
        $(".publishActions .radioButtons label").eq(0).css("color","black");
        $(".publishActions .radioButtons label").eq(1).css("color","#39dd02");  
    }
    
    function pendingRequestForm() {
            var formContainer = $(".pendingForm");
            var pendingUrl = $("#hiddenContext").text() + formContainer.attr("data-item");
            
            $.ajax({
                type:"POST",
                url:pendingUrl,
                success:function(data){
                    formContainer.empty();
                    formContainer.append(data);
                    pendingColors();
                    $(".pendingSpinner").hide();
                    
                },error:function(){
                    formContainer.append("Error getting pending data, please refresh");
                }
            });
    }
    
    
    if ($(".checkBoxPending").length > 0){
        pendingColors();    
    }
    
    if($(".pendingItemForm").length > 0){
        pendingRequestForm();
    }
    
    
    $("#bellowheadercontainer").on("click", ".ahha.submitsearch", function(){
            var form = $("#approve"),
            formContainer = form.parents(".pendingItemForm"),
            spinner = formContainer.find(".pendingSpinner"),
            formStr = form.serialize(),
            formAction= form.attr("action"),
            validator = form.validate(),
            isforPublication = form.find("#approve_authorizationStatusApproved").is(':checked'),
            radioQCfailed = form.find(".radioButtons input[name=qcStatus]:eq(2)").is(':checked'),
            qcFailedAnswer = false;
            
            // radioQCfailed is done like this as the ID and value are using the full 
            // metastore URI and therefore not the best for targeting programmattically
            
            function submitData() {
                
                spinner.show();
                $.ajax({
                    type:"POST",
                    url:formAction,
                    data:formStr,
                    success:function(){
                        if (isforPublication) {
                            //this is a presumption that we dont want to present the user 
                            //with the pending approval form if they have selected publish 
                            //instead just load article.
                            location.reload();
                        } else {
                            pendingRequestForm();
                        }
                    },
                    error:function(){
                        spinner.hide();
                        formContainer.append("Error submitting pending data, please refresh");
                    }
                });
                
                
            }

            
            if (validator.form()) {
                if (isforPublication && radioQCfailed) {
                    qcFailedAnswer = confirm("You have selected status QC failed are you sure you wish to publish this article?");
                    if (qcFailedAnswer) {
                        submitData();
                    } //else do nothing!
                
                } else { 
                        submitData();
                }
            } else {
                form.find("input.error:eq(0)").focus(); //focus first element with invalid data
            }
            

    });
    


           $(".js-signinlink").click(function() {
                var $this = $(this);
                var containerWidth = $this.closest('.js-signinlinkcontainer').width();
                var formSignIn = $("#form-signin");
                var closeIcon = formSignIn.find(".js-close-panel");
                
                closeIcon.click(function() {
                    $this.trigger('click');
                    return false;
                });
        
 
            formSignIn
            .toggleClass('hidden-lg hidden-md hidden-sm loginDropdown list-group-item js-signinlinkcontainer')
            .css('width', (containerWidth + 10) + 'px');
        
        
            $("#form-signin input:first").focus();
            return false;
           });
    
         
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

    function showSignInPrompt(message){
            
            function hideSignInPrompt(){
                $("body").removeClass("overlay");
                $("body .overlay").remove();
            }
            
            $("body").addClass("overlay");
            $("body").append("<div class=\"overlay\"><div class=\"signoutmessage\"><p>"+message+"</p></div></div>");

            // Set the width and height as a proportion of the current viewport size
            var msgWidth  = $(window).width()  * 0.4;
            var msgHeight = $(window).height() * 0.4;

            $(window).scrollTop(0);
            $(".signoutmessage").css("top", msgHeight);
            $(".signoutmessage").css("left", msgWidth);

            //hide if user clicks

            
           $("body").on("click", ".promptBack", function(){
                 hideSignInPrompt();
             });
           
         }
        

         $("#bellowheadercontainer").on("click", "#fulltexttoc .toclist .sectionlink", function(e) {
             moveDocument($(this).attr("href"));
             return false;
         });

         $("#bellowheadercontainer").on("click", "#morelikethis .morelink, #mostviewed .morelink, .mostcited .morelink", function(e) {
             var here = $(this);
             here.parent().parent().find(".hide").show();
             here.hide();
             return false;
         });
         

         $("#morelikethis .morelink a").on("click", function(e) {
             var here = $(this),hereAttrClass = $(this).attr("class");
           
           if (hereAttrClass === 'more'){
              here.parent().parent().find(".hidden-js-div").css("display","block");
                 here.addClass("hidden-js-div");
             here.parent().find(".less").removeClass("hidden");
             }else{
                 here.parent().find(".more").removeClass("hidden-js-div");
                 here.addClass("hidden");
               here.parent().parent().find(".hidden-js-div").css("display","none");
             }
             return false;
         });
         

         $(".js-signoutlink").click(function(e) {
             $("#signoutform").submit();
             e.preventDefault();
        }); 

      // jquery bookmark plugin version 1.4.0 (now a part of JP) supports all bookmarking site.
 /*     $(".js-showhide").click(function(e){ 
          e.preventDefault();
          var showhide = $(this);
          showhide.siblings('.js-description').slideToggle();
     });*/
     
    $(".listingBookmarks").mouseover(function(){
      $(this).find(".moreshareoptionsListing").removeClass('hidden').show();
    }).mouseout(function(){
      $(this).find(".moreshareoptionsListing").hide().addClass('hidden');
    });

      
        /* date picker and input default for advanced search page */
     var skinPubDate = $("#skinPublishingDates").html();
     var newDateValue = skinPubDate !== null ? skinPubDate + ":+nn" : "";
   
        $(".pickdate").datepicker({showButtonPanel: true, changeMonth:true,changeYear:true, dateFormat: "yy-mm-dd",yearRange:newDateValue+":+nn"});
        
        $(".datepicker-icon").click(function() {
            $(this).parent().parent().find("input").focus();
            
        });
        
        $("#bellowheadercontainer").on("submit","#managePendingItemForm", function(e) {
            e.preventDefault();

             var form = $(this),
             formContainer = form.parents(".pendingItemForm"),
             spinner = formContainer.find(".pendingSpinner"),
             formStr = form.serialize(),
             formAction= form.attr("action")
             isforPublication = form.find("#managePendingItemForm_authorizationStatusApproved").is(':checked'),
             qcFailedAnswer = false;
             // radioQCfailed is done like this as the ID and value are using the full 
             // metastore URI and therefore not the best for targeting programmattically
             function submitData() {
                spinner.show();
                $.ajax({
                   type:"POST",
                   url:formAction,
                   data:formStr,
                   success:function() {
                      if (isforPublication) {
                         //this is a presumption that we dont want to present the user 
                         //with the pending approval form if they have selected publish 
                         //instead just load article.
                         location.reload();
                      } else {
                          spinner.hide();
                     // do nothing!
                      }
                   }, error:function() {
                      spinner.hide();
                      formContainer.append("Error submitting pending data, please refresh");
                   }
                });
             }
             
           


          
             submitData();
            
          });
      
        
     /*
      * 
      * Form Placeholder changer
      * 
      */
        
        
        
        
        
      
/*
*
*  Responsive JS code 
*
* 
*/

// Search Page    
      // MOVE TO RESPONSIVE JS when finished, Search Page Facet Modal override issue.
      // once opened and closed at mobile/tablet view, element has display:none; appended which
      // is present if resized to desktop, so if that page now is bigger than 751 the element is now forced to be show.
      if ($(".searchResultsContent").length > 0){
          $(window).resize(function(){
              var currentWindowSize = $(window).width();
             if (currentWindowSize > 992){
                  $(".modal.fade.facet-modal").css("display","block");
              }else if (currentWindowSize <= 992) {
                  $(".modal.fade.facet-modal").css("display","none");
              }
          });
      } 
      if ($("#navigateThisJournal").length > 0) {
          
              $("#navigateThisJournal .tab-menu").click(function(e){
                  var tabmenu = $(this), menustatus;
                  if (tabmenu.hasClass("opened")){
                      tabmenu.removeClass("opened");
                      menustatus = "close";
                      
                  } else {
                      tabmenu.addClass("opened");
                      menustatus = "open";
                  }
                  var hiddenMenu = tabmenu.parent(".visible-xs").siblings("li");
                  hiddenMenu.each(function( index ) {
                      var menuItem = $(this);
                      setTimeout(function(){ 
                          if (menustatus == "open") {
                              menuItem.removeClass("hidden-xs");
                          } else {
                              menuItem.addClass("hidden-xs");
                          }
                          },200*index);
                      });
              
                    e.preventDefault();
                  });

       
          
       
      }
      // search facets, show hide 'Select drop down'
      $(".facets-toggle-span").click(function(){
          $(this).children().toggleClass("fa-caret-right fa-caret-up");
          $(this).parent().find(".list-group").toggle();
      });
      
      // general change icon on Bootstrap collapse feature.
      $(".js-plus-minus-toggle-icon").click(function(e){
          $(this).find("i").toggleClass("fa-plus-square fa-minus-square");
          e.preventDefault();
      });
      
    
      $(".js-plus-minus-toggle-text").click(function(){
          $(this).children("i").toggleClass("fa-plus fa-minus");
      });
      
      
      //create an annonoymous self calling function to limit javascript variable scope.
      (function(){
          $('.js-rssFeedReader').each(function () {
            var rssReader = $(this),
            rssFeedurl = rssReader.data("rssfeedurl"),
            showAmount = rssReader.data("showamount"),
            dateformat = rssReader.data("dateformat");
            
            //if empty then put in default
            if (isEmpty(dateformat)) {
                dateformat = 'dd MMMM, yyyy hh:mm';
            }
            
            
            //this uses the zrss feed code that is taken from at the time of writing from: http://www.zazar.net/developers/jquery/zlastfm/.
          $(rssReader).rssfeed(rssFeedurl, {
                limit: showAmount, 
                sort:'date',
                header: false,
                date: true,
                dateformat: dateformat,
                sortasc: false,
                errormsg: 'Oops sorry there seemed to be a problem loading the RSS feed',
                content: false,
                titletag:'h4',
                linktarget: '_blank',
                content: true,
                snippet: true
              }); 
         });
      
      })();
      
      

  /*
  *
  *  End of Responsive JS code 
  *
  * 
  */      
      
      $('.js-postlink').click(function() {
          var url = $(this).attr('href')
          url = decodeURI(url);
          urlParts = url.split('?');
          var action = urlParts[0];
          var params = urlParts[1].split('&');
          var form = $(document.createElement('form')).attr('action', action).attr('method','post');
          $('body').append(form);
          for (var i in params) {
              var tmp= params[i].split('=');
              var key = tmp[0], value = decodeURIComponent(tmp[1]);
              $(document.createElement('input')).attr('type', 'hidden').attr('name', key).attr('value', value).appendTo(form);
          }
          $(form).submit(); 
          
          return false;
      });
      
      
      $('.js-a_to_z a').click(function(e){
          /* This function is added to fix bug 45056 all pagination now uses the faceted browse Form */
          var ithis = $(this), 
          url = ithis.attr('href');
          
          facetedbrowseform = $('#facetedbrowseform');
        //this for the case when the facets dont exist e.g no results pages!
     
          if (facetedbrowseform.length > 0) {
          
              facetedbrowseform.attr('action',url);
          
              facetedbrowseform.submit();
          
              
          } else {
              window.location.href = url;
          }
              e.preventDefault();
          //else allow default link action!
          });
       
       

       $('.browse-display-option a').click( function(e){
          var ithis = $(this),
          url = ithis.attr('href');
          
          facetedbrowseform = $('#facetedbrowseform');
          //this for the case when the facets dont exist e.g no results pages!
          console.log ("facetedbrowseform.length" + facetedbrowseform.length);
          if (facetedbrowseform.length > 0) {
          
              facetedbrowseform.attr('action',url);

              facetedbrowseform.submit();

          }  else {
              window.location.href = url;
          }
          e.preventDefault();

          
       });
       


       $(".showMoreBlogPosts").click( function(e) {
           var $this = $(this);
           e.preventDefault();
           var itemId = $this.parent().find(".hiddenWeblogWebid").text();
           var month = $this.parent().find(".hiddenWeblogMonth").text();
           var requestedPage = $this.parent(".seemoreposts").find(".hiddenRequestedPageNumber").text();
           if ( requestedPage == '') {
            requestedPage = 2;
           }
           $this.parents(".seemorepostsWrapper").append('<div class="morepostsloadingwrappper"><img class="morePostsLoading" src="/images/jp/spinner.gif" alt="Loading posts" /></div>');
           var hiddenContext = $("#hiddenContext").text()
           var url = hiddenContext + itemId + "/moreposts?month=" + month + "&requestedPage=" + requestedPage;
           $.ajax({
               type: "GET",
               url: url,
               timeout: 90000,
               success: function(resp, statusText) {
                  
                $this.parents(".publistwrapperBlog").append(resp);
                $this.parents(".seemorepostsWrapper").remove();
                
               },
               error: function(req, statusText, message) {
               },
               complete: function(req, statusText) {
                   //$(".morepostsloadingwrappper").remove();
               }
           });
           
       });  
       
       $.cookieBar();
       

  

 
       // this code is to make sure that you can only view one mobile menu navigation option at once. (I'm not sure why i have had to write this!)
  $('#navbar-mobile [data-toggle=collapse]').on('click', function (e) {
          //var target = $('#navbar-mobile [data-toggle=collapse]').not(this)
          $('#navbar-mobile [data-toggle=collapse]').not(this).each(function( index ) {
              var target = $(this).data("target");
             $(target).collapse('hide'); //collapse is bootstrap native js.
          });
     }); 
  
  /* */
  /* toggle facet item MORE for ajax retrieved only (only happens first retrieval) */
  $(document).on("click", ".seeAhahFacetsLink a", function(e) {
          var $here = $(this),
              $ahahParent = $here.parent(".seeAhahFacetsLink"),
              $ahahGrdParent = $ahahParent.parent("ul"),
              url = $ahahGrdParent.find(".ahahurl").text(),
              ids = $ahahGrdParent.find(".ahahids").text(),
              names = $ahahGrdParent.find(".ahahnames").text(),
              values = $ahahGrdParent.find(".ahahvalues").text(),
              searchUrl = $ahahGrdParent.find(".ahahsearchurl").text(),
              data = {"ids": ids,
                  "names": names,
                  "values": values,
                  "searchurl": searchUrl
              };
          e.preventDefault();
          $here.addClass("cursorWait");

          $.ajax({
              type: "POST",
              url: url,
              data: data,
              success: function(resp, statusText) {
                  $ahahParent.after(resp);
                  var newHtml = "<a href='#' title='Hide items in list' class='facethidetext std-display'><img src='/images/aip/minus_icon.gif' alt='-' /> Less</a>";
                  $(".toggleajaxfacetitem").html(newHtml);
                  $(".toggleajaxfacetitem a").show();
                  $ahahParent.hide();
              },
              error: function(req, statusText) {
              },
              complete: function(req, statusText) {
                  $here.removeClass("cursorWait");
              }
          });
  });
  
  /* see more facets link show / hide list - non ajax retrieval (or post ajax first retrieval and hide) */
  $(document).on("click", ".js-seeMoreFacetsLink a", function(e) {
      e.preventDefault();
      
      var $here = $(this),
      parentContainer = $here.closest(".js-seeMoreFacetsLink"),
      getMoreViaAhah = parentContainer.data('getMoreViaAhah'),
      maxItemsPerExpandMore = parseFloat($('#facets').data('maxItemsPerExpandMore'));
      
      //console.log (isNaN(parseFloat($('#facets').data('maxItemsPerExpandMore'))));
      
      function toggleDisplay(thislink, thislinkContainer, maxItemsDisplayPerClick){
          if (isNaN(maxItemsDisplayPerClick)) {
              //if not providing a maxItemsPerExpandMore then display / hide All
              thislink.closest("ul").find(".hiddenjsdiv").slideToggle();
              thislinkContainer.children("a").toggleClass("hiddenprop");  
          } else {
              //maxItemsPerExpandMore is a number!
              if (thislink.closest("ul").find(".hiddenjsdiv:hidden").length > 0){
                  thislink.closest("ul").find(".hiddenjsdiv:hidden").slice(0, maxItemsDisplayPerClick).slideDown();
                  //check again now we have displayed the next x number if any more to display.
                  //console.log(thislink.closest("ul").find(".hiddenjsdiv:hidden").length);
                  if (thislink.closest("ul").find(".hiddenjsdiv:hidden").length == 0){
                      thislinkContainer.children("a").toggleClass("hiddenprop");
                  }
              } else {
                  thislink.closest("ul").find(".hiddenjsdiv").slideUp();
                  thislinkContainer.children("a").toggleClass("hiddenprop");
              }
              
          }
      }
     
      //OK first things first determine if returning via AJAX
      if (getMoreViaAhah === true){
      /* ajax section - view more */
              var  url = parentContainer.data('ahahurl'),
                  ids = parentContainer.data('ahahids'),
                  names = parentContainer.data('ahahnames'),
                  values = parentContainer.data('ahahvalues'),                              
                  searchurl = parentContainer.data('ahahsearchurl'),                                
                  data = {'ids': ids, 'names': names, 'values': values, 'searchurl': searchurl};
                  parentContainer.data('getMoreViaAhah',false); // set data attribute as we no longer want it to return via Ajax

              $here.css({"cursor":"wait"});
              
              //
              // Since we want to handle failure as well as success,
              // we need to use ajax() rather than post().
              //
              // $.post fails silently on error!
              //

              $.ajax({
                  type : "POST",
                  url : url,
                  data : data,
                  success: function(resp) {
                      
                      parentContainer.before(resp);
                      $here.css({"cursor":"default"});
                      
                      toggleDisplay($here,parentContainer,maxItemsPerExpandMore);
                  },
                  error : function(resp) {
                      var cMsg = "'Facet More Terms' AJAX POST to '" + url + "' failed: " + resp.status + " (" + resp.statusText + ")";
                      //console.log(cMsg);
                      } 
  });
              

      } else { 
      
      
          toggleDisplay($here,parentContainer,maxItemsPerExpandMore,maxItemsPerExpandMore);
      
      }
  });
  
     

      
      
      $(document).on("click", "a.moreLink, a.lessLink", function(e) {
          ingentaCMSApp.flipMoreLess(e, "ul", "li.hiddenjsdiv");

      });
      
      $("#journal").find(".showOtherLatestArticles").on("click", "a.moreLink2, a.lessLink2", function(e) {
          ingentaCMSApp.flipMoreLess2(e, ".publistwrapper", "li.initialHide");
      });
  
      $(document).on("click", ".js-signInOrRegister",function(e) {
          $('.signInOrRegisterWrapper').hide();
          ingentaCMSApp.displaySmallDialog(e, $(this).siblings('.signInOrRegisterDialog'), "Sign in or Register", "Please sign in or register to use this feature", "300");
      });


      $(".toggle.expand").on("click",function(){
          $(this).nextAll(".hidden-js-div").toggle();
      });
      //responsive tabs API code.
      var Pills = {

            init: function() {
              this.bindUIfunctions();
              this.pageLoadCorrectTab();
            },

            bindUIfunctions: function() {

              // Delegation
              $(document)
                .on("click", ".pills-container a[href^='#']:not('.active, .disabled')", function(event) {
                    Pills.changeTab(this.hash);
                  event.preventDefault();
                })
              
            },

            changeTab: function(hash) {
              
               
              var anchor = $(".pills-container a[href='" + hash + "']");
              
              function displayTab(anchortab) {
                  var url = anchortab.attr("href");
                  //console.log("url" + url);
                  var divtabContent = $(url);
                  
                  // activate correct anchor (visually)
                  anchortab.addClass("active").parent().addClass("active").siblings().removeClass("active").find("a").removeClass("active");
                  

                
                  // activate correct div (visually)
                  divtabContent.addClass("active").removeClass("hidden").siblings().removeClass("active").addClass("hidden");
                  
                  anchortab.closest("ul").removeClass("open");

                  
              }
                  displayTab(anchor);

              // update history stack adding additional history entries.
              
                  // pushState is supported!
                  history.pushState(null, null,  hash);

              
              
             //We also need to handle the backstate by telling the brower to trigger the tab behaviour!   
              $(window).on('popstate', function(e) {
                 anchor = $('[href="' + document.location.hash + '"]');
                 if (anchor.length) {
                     displayTab(anchor);
                 } else {
                    defaultAnchor =  $('.pills-container li.active a');
                    displayTab(defaultAnchor);
                 }
              });

              // Close menu, in case mobile
             
              return anchor; // make property available outside the function

            },

            // If the page has a hash on load, go to that tab
            pageLoadCorrectTab: function() {
                //console.log("document.location.hash: " + document.location.hash);
              if   (document.location.hash.length > 0) {
                   var anchor = $(".pills-container a[href='" + document.location.hash + "']");
                   if (!anchor.hasClass("disabled")) {
                       var anchorTab = this.changeTab(document.location.hash);
                   
                   
                       // this is a further amendment to allow the fulltext and 
                       //(any future event if its attached) to load when bookmarking a page with a particular tab. 
                       anchorTab.trigger("click");
                   }
                }
            },

            toggleMobileMenu: function(event, el) {
              $(el).closest("ul").toggleClass("open");
            }

      }


      Modernizr.load([{
      //test
      test : Modernizr.history,
          //if yes then do nothing as nothing extra needs loading....
          
          //if no then we need to load the history API via AJAX
      nope : ['/js/' + ingentaCMSApp.instanceprefix + '/vendor/history.min.js'],
          
      complete : function() {
          
          var location = window.history.location || window.location; 
              Pills.init();

      }


      }])
       
      //end of responsive tabs API code.
      
      $("#metrics_tab").find("a").click(function(e) {
          var $metricsContainer = $(".metricsContainer"),
              startDate = $metricsContainer.find(".metricsPubDate").text(),
              endDate = $metricsContainer.find(".metricsEndDate").text(),
              webId = $metricsContainer.find(".metricsItemId").text(),
              url = appUrls.metrics + "?startDate=" + startDate + "&endDate=" + endDate + "&itemId=" + webId,
              ERR_MSGS = ["<p class='noMetricsData bg-warning'>" + $("#graph1Settings").data("nodata") + "</p>",
                          "<p class='noMetricsData bg-warning'>" + $("#graph2Settings").data("nodata") + "</p>",
                          "<p class='noMetricsData bg-warning'>" + $("#graph3Settings").data("nodata") + "</p>"
              ],
              pageTitle = $(".siqPageTitle").text(),
              doi = $(".siqDoi").text(),
              lineData1,
              lineData2,
              lineData3;

          // SIQ tagging request
          //ingentaCMSApp.siq(appUrls.siq, SIQ.webId, SIQ.pageTitle, SIQ.doi, "Metrics");

          if ($metricsContainer.hasClass("retrieveMetrics")) {
              // Make the call...
              $.ajax({
                  type: "GET",
                  url: url,
                  timeout: 90000,
                  success: function(resp, statusText) {
                      $metricsContainer.find(".metricsDetails").append(resp);
                      $metricsContainer.removeClass("retrieveMetrics");
                  },
                  error: function(req, statusText, message) {
                      $metricsContainer.find(".metricsDetails").html(ERR_MSGS[1]).addClass("ajax-error");
                  },
                  complete: function(req, statusText) {
                      $(".itemMetricsLoading").remove();
                      var $table1 = $("#abstractDayView"),
                          table1HasData = ($table1.find("td").hasClass("noMetricsData") ? false : true),
                          graph1 = "graph1Output",
                          $table2 = $("#fulltextDayView"),
                          table2HasData = ($table2.find("td").hasClass("noMetricsData") ? false : true),
                          graph2 = "graph2Output",
                          $table3 = $("#metricTotals"),
                          // Notice the negation...
                          table3HasData = (!$table3.find("td").hasClass("noMetricsData") ? true : false),
                          graph3 = "graph3Output";

                      // Plot data from  Table 1...
                      if (table1HasData) {
                          ingentaCMSApp.displayGraphOrTable($table1, "line", graph1, "abstractDayView", ERR_MSGS[2]);
                      } else {
                          $("#" + graph1).append(ERR_MSGS[0]);
                      }
                      // Plot data from Table 2...
                      if (table2HasData) {
                          ingentaCMSApp.displayGraphOrTable($table2, "line", graph2, "fulltextDayView", ERR_MSGS[2]);
                      } else {
                          $("#" + graph2).append(ERR_MSGS[1]);
                      }
                      // Plot data from  Table 3...
                      if (table3HasData) {
                          ingentaCMSApp.displayGraphOrTable($table3, "pie", graph3, "metricTotals", ERR_MSGS[2]);
                      } else {
                          $("#" + graph3).append(ERR_MSGS[2]);
                      }
                  }
              });
          }
      });
     $(".ellipseSeeMore").click(function(){
         $(this).siblings(".hidden-js-div").show();
         $(this).parent().siblings("p").show(); // some descriptions have multiple <p> tags
         $(this).remove();
     });

   //Scripts for Alerts
   function manageAlert() {
      //this Obj is the item that triggered click .contentAlertLink div
      var thisObj = $(this);
      var load = '<img class="js-settingAlert" src="/images/jp/spinner.gif" alt="Loading" />';
      
      //remove regular click functionality and add spinner
      thisObj.unbind("click");
      thisObj.before(load);
       
      //define parts of this for future use      
      var parent = thisObj.closest(".js-alertDiv");
      var alertId = parent.find(".js-alertId").text();
      var alertContext = parent.find(".js-alertContext").text();
      var alertContextTitle = parent.find(".js-alertContextTitle").text();
      var alertContentId = parent.find(".js-alertContentId").text();
      var submitUrl = parent.find(".js-submitUrl").text();
      var removeUrl = parent.find(".js-removeUrl").text();
      var contentAlert = parent.find(".js-contentAlert").text();
      var alertContextText = parent.find(".js-alertContextText").text();
      var frequencyKeyName = "freq:" + alertContentId ; 
      var data = {
         alertId : alertId,
         alertContext: alertContext,
         alertDescription: alertContextTitle,
         update: 'true',
         alertScopeObjectId: alertContentId,
         alertFrequency: 'HOUR',
         contentAlert: contentAlert
      };
      
      var nextUrl = (contentAlert == "on" ? submitUrl : removeUrl);
      
      var isContentAlertType = alertContext.match("citation|correction") !== null ? true : false;

      if (!isContentAlertType) {
         if (contentAlert == "on") {
            data["enabled:" + alertContentId ] = contentAlert;
            data[frequencyKeyName] = 'HOUR'; 
            data["description:" + alertContentId ] = alertContextTitle;
         }
      }

      $.ajax({
         type: "POST",
         url: nextUrl,
         data: data,
         timeout: 20000,
         success: function(data) {
            parent.find(".js-settingAlert").remove();
            var nextOperation = (contentAlert == "on" ? "Remove" : "Create") + " " + alertContextText ;
          
            if (contentAlert == "on") {
               parent.find(".js-contentAlert").text("");
               parent.find(".js-successMessage").text("(created)");
            } else {
               parent.find(".js-contentAlert").text("on");
               parent.find(".js-successMessage").text("(removed)");
               parent.find(".alertId").text("");
            }
            parent.find(".js-successMessage").addClass("hidden").show();
            if (parent.find(".js-contentAlertLink").children().length > 0) {
               var text = $.trim(parent.find(".js-contentAlertLink").text());
               parent.find(".js-contentAlertLink").html(parent.find(".js-contentAlertLink").html().replace(text, nextOperation));
            } else {
               parent.find(".js-contentAlertLink").text(nextOperation);
            }
            parent.find(".js-successMessage").removeClass("hidden").hide("slide", { direction: "up" }, 3000);
            thisObj.bind("click", manageAlert);
         },
         error: function(error) {
            if (error.status == "200") {
               parent.find(".js-settingAlert").remove();
               var nextOperation = (contentAlert == "on" ? "Remove" : "Create") + " " + alertContextText ;
              
               if (contentAlert == "on") {
                  parent.find(".js-contentAlert").text("");
                  parent.find(".js-successMessage").text("(created)");
               } else {
                  parent.find(".js-contentAlert").text("on");
                  parent.find(".js-successMessage").text("(removed)");
               }
               parent.find(".js-successMessage").addClass("hidden").show();
               if (parent.find(".js-contentAlertLink").children().length > 0) {
                  var text = $.trim(parent.find(".js-contentAlertLink").text());
                  parent.find(".js-contentAlertLink").html(parent.find(".js-contentAlertLink").html().replace(text, nextOperation));
               } else {
                  parent.find(".js-contentAlertLink").text(nextOperation);
               }
               parent.find(".js-successMessage").removeClass("hidden").hide("slide", { direction: "up" }, 3000);
               thisObj.bind("click", manageAlert);
            } else {
               parent.find(".js-settingAlert").remove();
               parent.find(".js-successMessage").text("(error)").removeClass("hidden").hide("slide", { direction: "up" }, 3000);
               thisObj.bind("click", manageAlert);
            }
         }
      });
      return false;
   }
   // To manage Content alerts (Citation, Correction)
   $(".js-contentAlertLink").click(manageAlert);

   $('.js-back-top').fadeOut();
   $(window).scroll(function() {
       if ($(this).scrollTop() > 160) {
           $('.js-back-top').fadeIn();
       } else {
           $('.js-back-top').fadeOut();
       }
   });

   $("#dataandmedia_tab").find("a").click(function(e) {
      if ($("#hiddenDataMediaWebid").length > 0) {
         var itemId = $("#hiddenDataMediaWebid").text(),
             url =  $("#hiddenContext").text() + itemId + "/datamedia?fmt=ahah";
         $.ajax({
            type: "GET",
            url: url,
            dataType: "text",
            success: function(resp, statusText, req) {
               var target = $(".dataandmedia").get(0);
               if (target) {
                  target.innerHTML = resp;
                  MathJax.Hub.Queue(["Typeset", MathJax.Hub, target]);
               }
            },
            complete: function(req, statusText) {
               $(".itemDataMediaLoading").remove();
               $("#hiddenDataMediaWebid").remove();
            }
         });
      }
   });
   

   $('[data-toggle="tooltip"]').tooltip();
   
  function showEmailForm() {
       var dlg = $("#myModal");
       dlg.empty();
       dlg.load($("#hiddenContext").text() + "/email/form", {}, function() {
          $("#myModal").modal('show');
       });
   }
  // We might need to clean more stuff here
    var emailIGO;
    var emailSenderIGO;
    var emailSiteUrl;
    
   $(".js-email-this").click(function(e) {
       e.preventDefault();
       ingentaCMSApp.linkItemsList = [];
       emailIGO= $(this).attr('data-igo');
       emailSenderIGO=$(this).attr('data-igoemail'); 
       emailSiteUrl=$(this).attr('data-siteurl');
       
       var item ={};
       item.link = $(e.currentTarget).prop('href');
       item.title = $(e.currentTarget).attr('data-title');
       ingentaCMSApp.linkItemsList.push(item);

       showEmailForm();
   });
   $('#myModal').on('hidden.bs.modal', function (e) {
       resetFrom();
   });
   $(".sendEmailList").click(function(e) {
       if($("input.select-item[name^='MARKED']:checked,#managedMarkedListCont input[name^='MARKED']:checked").length>0)
       {
           ingentaCMSApp.linkItemsList = [];
           emailIGO= $(this).attr('data-igo');
           emailSenderIGO=$(this).attr('data-igoemail'); 
           emailSiteUrl=$(this).attr('data-siteurl');

           $("input.select-item[name^='MARKED']:checked,#managedMarkedListCont input[name^='MARKED']:checked").each(function(index,element) {
               var item ={},
                   linksplit;
              
               item.link = $( element ).parent().parent().parent().find(".title>a").prop('href');
               item.title = $( element ).attr('data-title');

               if (item.link.indexOf('?') != -1){
                   linksplit = item.link.split('?');
                   item.link = linksplit[0];
               }
               
               //console.log('itemLink' +item.link);
               ingentaCMSApp.linkItemsList.push(item);
               //console.log ('firstItem1:' + ingentaCMSApp.linkItemsList[0].link);
           });
           
           showEmailForm();
       }
       else{
           alert("please select items for email");
       }   
   });
    
   $(".table-wrapper").on("change", "input.select-item", function(){
       var sendEmailList = $(".sendEmailList");
       var InputCheckedCount = $("input.select-item[name^='MARKED']:checked").length;
       //display count
       sendEmailList.children('.selected-count').text('('+ InputCheckedCount +')');
       
       if(InputCheckedCount>0) {
           if(!sendEmailList.hasClass('active')) {
               sendEmailList.addClass('active');
           } 
           }
           else {
           if(sendEmailList.hasClass('active')) {
               sendEmailList.removeClass('active');
               }
           }
       });
       
   $("input[name=select_deselect_all]").on("change", function(){
       var count= 0; 
       if($(this).is(":checked")) {
           $("input.select-item").prop('checked', true).trigger("change")
       } else {
           $("input.select-item").prop('checked', false).trigger("change");
       }
   });
   
   
   
   
   $("#myModal").on("submit", "#email-form", function(e) {
       e.preventDefault();
       // var oldSubject= $( "#subject").val();
       //  $( "#subject").val("At " + emailIGO + " iLibrary - " + oldSubject);
       var form = $('#email-form').clone();
       // Don't prefix Subject with anything here, should be done via blurb .
       //$(form).find('#subject').val("At " + emailIGO + " iLibrary - " + oldSubject);
       //console.log ('firstItem2:' + ingentaCMSApp.linkItemsList[0].link);
       var totalItems = document.createElement('input')
       $(totalItems).attr("type", "hidden").attr("name", 'totalItems').attr("value",ingentaCMSApp.linkItemsList.length );
       form.append(totalItems);
       
       var igo = document.createElement('input')
       $(igo).attr("type", "hidden").attr("name", 'igo').attr("value", emailIGO);
       form.append(igo);
        
       var mainSenderEmail = document.createElement('input')
       $(mainSenderEmail).attr("type", "hidden").attr("name", 'mainSenderEmail').attr("value", emailSenderIGO);
       form.append(mainSenderEmail);
       
       for(var i = 0;i<ingentaCMSApp.linkItemsList.length;i++){
           
            
           var title = document.createElement('input')
           $(title).attr("type", "hidden").attr("name", 'title'+i).attr("value", ingentaCMSApp.linkItemsList[i].title);
           form.append(title);

           var link = document.createElement('input')
           $(link).attr("type", "hidden").attr("name", 'link'+i).attr("value", ingentaCMSApp.linkItemsList[i].link);
           form.append(link);
       }
       var siteUrl = document.createElement('input')
       $(siteUrl).attr("type", "hidden").attr("name", 'siteUrl').attr("value", emailSiteUrl);
       form.append(siteUrl);

       $.ajax({ 
           type: 'post',
           url: $("#hiddenContext").text() + '/email/send',
           data: form.serialize(),
           success: function (html) {
               $( "#myModal" ).modal('hide');
               ingentaCMSApp.linkItemsList = [];
               dataLayer.push({"customCategory" :"engagement",
                   "customAction":"share",
                   "customLabel":"eMailThisPage",
                   "event":"customEvent"});
               alert("Email sent successfully");
             
           },error: function (request, error) {
               $( "#myModal" ).modal('hide');
               ingentaCMSApp.linkItemsList = [];
               alert("Error in sending email");
           }   
      }); 
   });
   
  
   $(document).on("change",'select.counter-year-end', function() {
		  
	   var monthSelectDropdown = $(this).closest('.row').find('select.counter-month-end')[0];
	   monthDropdownChanger(monthSelectDropdown,$(this));
   });
   
   $(document).on("change",'select.counter-year-start', function() {
	   var monthSelectDropdown = $(this).closest('.row').find('select.counter-month-start')[0];
	   monthDropdownChanger(monthSelectDropdown,$(this));
   });
   
   function monthDropdownChanger(monthSelectDropdown, yearSelectDropdown) {
	   const monthNames = ["January", "February", "March", "April", "May", "June",
	                       "July", "August", "September", "October", "November", "December"
	                     ];
            var selectedYear = parseInt(yearSelectDropdown.val(),10);
            var currentDateTime = new Date();
            var currentYear = currentDateTime.getFullYear();
            var currentMonth = currentDateTime.getMonth() + 1;
            
           
            if(selectedYear === currentYear) {
            	for(let i= 12;i>=currentMonth;i--) {
            		
            		monthSelectDropdown.remove(i-1);
            	}
            }
            else if(monthSelectDropdown.length < 12){
            	
            	for(let i= currentMonth;i<=12;i++) {
            		let option = document.createElement("option");
            		option.text = monthNames[i-1];
            		option.value = i;
            		monthSelectDropdown.add(option);
            	}
            	
            }
           
     
   }

   function resetFrom()
   {
       $( "#sendButton").prop("disabled",false);
   }
   
   $("#bellowheadercontainer").on("click", ".js-citation-export-format", function(e){
       e.preventDefault();
       dataLayer.push({"customCategory" :"engagement",
               "customAction":"downloadCitation",
                "customLabel": $(this).text(),
                 "event":"customEvent"});
           // normal function of link after that.
           ingentaCMSApp.followLink($(this));
   });
   
   $( ".js-social-links a").on("click", function(e){
       e.preventDefault();
       var social_iden = $(this).data('socialiden');
       if (social_iden){
           dataLayer.push({"customCategory" :"engagement",
               "customAction":"share",
               "customLabel": social_iden,
               "event":"customEvent"});
           // normal function of link after that.
           ingentaCMSApp.followLink($(this));
       }
   });

   $( ".js-desc-fade").each(function() {
       const ithis = $(this);
       //if description fits in its minumum container of which size is set to the following pixel value dont display more/less navigation
       if (ithis[0].scrollHeight <= 68.531) {
            ithis.find('.more_less').remove();
       }
   });


   $("a.js-more-less-toggle-link").on("click", function(e){
     e.preventDefault();
     const iThis = $(this);
     iThis.closest('.js-desc-fade').toggleClass('show-all');
     iThis.find('.fa').toggleClass('fa-angle-down').toggleClass('fa-angle-up');
     if(iThis.hasClass('open')){
        iThis.removeClass('open').find('span').text(iThis.data('more'));
     } else {
        iThis.addClass('open').find('span').text(iThis.data('less'));
     }

   });
   
       $("#bellowheadercontainer").on("click", "a[class^='action-']", function(e){
           e.preventDefault();
           var f = this.className.substring(this.className.indexOf('-') + 1, 
                           this.className.indexOf(' '));
           if (f){
           var formatLabel = (f === 'read' ? 'readOnline' : 
                                f === 'externalhtml' ? 'readOnline' :
                                  f === 'xls' ? 'downloadXLS' : 
                                    f === 'pdf' ? 'downloadPDF' :
                                      f === 'epub' ? 'downloadEPUB' : 
                                        f === 'mpeg' ? 'downloadMPEG' : 
                                         f === 'csv' ? 'downloadCSV' : 
                                           f === 'web' ? 'accessHTML' : 
                                              f.indexOf('data') !== -1 ? 'downloadData' : '')
           } 
    
               if (formatLabel) {
               dataLayer.push({"customCategory" :"engagement",
                   "customAction":"clickToAccess",  
                    "customLabel": formatLabel,
                     "event":"customEvent"});
               } 
            // normal function of link after that.
               ingentaCMSApp.followLink($(this));
           });
       
      //show modal when it exsits!
       $("#itemAddedToCart").modal('show');

     //this is for the related content template Update ticket see PLAT-9327 currently only publications.jsp and periodical.jsp uses this
     //the requirment is now to get the latest article.
      const relatedImagetobeAddedViaAjax =  $('.related-content-list .js-link-to-be-added-via-ajax');
       if(relatedImagetobeAddedViaAjax.length > 0) {
           let idList = "";
            $(relatedImagetobeAddedViaAjax).each(function( index ) {
                idList = idList + (index > 0 ? ',' : '') + $(this).data('id');
            });

            if (idList.length > 2){
                    //now run ajax to get book covers back.
                   const data = {
                        "fmt": "ahah",
                        "ids": idList
                    }

                    $.ajax({
                        type: "GET",
                        data: data,
                        url: '/content/relatedcoverimages',
                        dataType: "html",
                        success: function(resp, statusText) {
                            const response = $(resp);
                            let webId, title;
                            $(response.find('li')).each(function( index ) {
                                //first replace the content with what ever is returned as long as not empty.
                                if (($(this).html()).length > 0){
                                    $(relatedImagetobeAddedViaAjax[index]).html($(this).html()); 
                                }
                               
                            });

                        },
                        error: function(req, statusText) {
                            // lets just do nothing if there is an error.
                        }
                        
                    });

            }


       }
          
       
    });
