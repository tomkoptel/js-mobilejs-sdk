JasperMobile.Report.REST.API = {
    injectContent: function(content) {

        var div = document.getElementById('container');
        div.innerHTML = content;

        if (content == "") {
            JasperMobile.Callback.log("clear content");
        } else {
            // setup scaling
            var childs = document.getElementById('container').childNodes;
            if (childs.length > 0) {
                var secondChild = childs[1];
                if (secondChild != undefined) {
                    secondChild.style.transform = "scale(" + innerWidth / parseInt(secondChild.style.width) + ")";
                    secondChild.style.transformOrigin = "0% 0%";
                }
            }
        }
        JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.REST.API.injectContent", {});
    },
    verifyEnvironmentIsReady: function() {
        JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.REST.API.verifyEnvironmentIsReady", {
            "isReady" : document.getElementById("container") != null
        });
    },
    renderAdHocHighchart: function(script, params) {
        var containerWidth = document.getElementById("container").offsetWidth;
        var containerHeight = document.getElementById("container").offsetHeight;

        var chartDimensions = params["chartDimensions"];
        chartDimensions["width"] = containerWidth;
        chartDimensions["height"] = containerHeight;
        params["chartDimensions"] = chartDimensions;
        script(params);
        JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.REST.API.renderAdHocHighchart", {});
    },
    renderHighcharts: function(script, paramsArray) {
        for(var i=0; i < paramsArray.length; i++) {
            var params = paramsArray[i];
            script(params);
        }
        JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.REST.API.renderHighcharts", {});
    },
    renderFusionWidgets: function(paramsArray, jrsDomain) {
        for(var i=0; i < paramsArray.length; i++) {
            var params = paramsArray[i];
            params["swfUrl"] = jrsDomain + params["swfUrl"];
            JasperMobile.Report.REST.API.renderFusionWidget(params);
        }
        JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.REST.API.renderFusionWidgets", {});
    },
    renderFusionWidget: function(params) {
        FusionCharts.options.html5ChartsSrc = "../charts/FusionCharts.HC.Charts.js";
        FusionCharts.options.html5WidgetsSrc = "../widgets/FusionCharts.HC.Widgets.js";

        var chartVar = window.fc_Fusion_841726305 = new FusionCharts({
            "id"                : params["id"],
            "renderer"          : "javascript", // TODO: base on input params
            "swfUrl"            : params["swfUrl"],
            "width"             : params["width"],
            "height"            : params["height"],
            "debugMode"         : params["debugMode"],
            "registerWithJS"    : params["registerWithJS"],
            "renderAt"          : params["renderAt"],
            "allowScriptAccess" : params["allowScriptAccess"],
            "dataFormat"        : params["dataFormat"],
            "dataSource"        : "<chart showOpenValue='0' showHighLowValue='0' showCloseValue='0' lineColor='58595b' lineThickness='1' openColor='004682' closeColor='004682' anchorColor='0980ba' highColor='004682' lowColor='004682' drawAnchors='1' anchorRadius='2' bgColor='dfe0e2' exportEnabled='1' exportHandler='http://mobiledemo2.jaspersoft.com/jasperserver-pro/FCExporter' exportAtClient='0' exportAction='download' exportFileName='chart'><dataset><set value='217'/><set value='156'/><set value='197'/><set value='176'/><set value='109'/></dataset></chart>"
        });

        chartVar.addEventListener('BeforeRender', function(event, eventArgs) {
            if (eventArgs.renderer === 'javascript') {
                event.sender.setChartAttribute('exportEnabled', '0');
            }
        });

        chartVar.setTransparent(params["transparent"]);
        chartVar.render();
    },
    addHyperlinks: function(hyperlinks) {
        var allSpans = document.getElementsByTagName("span");
        for (var i = 0; i < hyperlinks.length; i++) {
            var hyperlink = hyperlinks[i];
            (function(hyperlink) {
                for (var j=0; j < allSpans.length; j++) {
                    var span = allSpans[j];
                    if (hyperlink.tooltip == span.title) {
                        // add click listener
                        span.addEventListener("click", function() {
                            console.log("click " + hyperlink.id);
                            JasperMobile.Callback.Listeners.listener("JasperMobile.listener.hyperlink", {
                                "type" : hyperlink.type,
                                "params" : hyperlink.params
                            });
                        });
                    }
                    //console.log("span: " + span.title);
                }
            })(hyperlink);
        }
    }
};