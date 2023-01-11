<link href="<c:url value='/jquery-ui-1.13.2.custom/jquery-ui.min.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<c:url value='/jqGrid/css/ui.jqgrid.css'/>">
 
<script type="text/javascript" src="<c:url value='/jqGrid/js/i18n/grid.locale-en.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/jquery.jqGrid.min.js'/>"></script>


<script>
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
</script>