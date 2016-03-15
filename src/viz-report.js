JasperMobile.Report.API = {
    report: null,

    runReport: function(params) {
        var successFn = function(status) {
            JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.runReport", {
                "status" : status,
                "pages" : JasperMobile.Report.API.report.data().totalPages
            });
        };
        var errorFn = function(error) {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.runReport", {
                "error" : JSON.stringify({
                    "code" : error.errorCode,
                    "message" : error.message
                })
            });
        };
        var events = {
            reportCompleted: function(status) {
                JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.API.run.reportCompleted", {
                    "status" : status,
                    "pages" : JasperMobile.Report.API.report.data().totalPages
                });
            },
            changePagesState: function(page) {
                JasperMobile.Callback.log("Event: changePagesState");
                JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.API.run.changePagesState", {
                    "page" : page
                });
            }
        };
        var linkOptionsEventsClick = function(event, link){
            var type = link.type;

            switch (type) {
                case "ReportExecution": {
                    var data = {
                        resource: link.parameters._report,
                        params: JasperMobile.Helper.collectReportParams(link)
                    };
                    var dataString = JSON.stringify(data);
                    JasperMobile.Callback.log("Event: linkOption - ReportExecution");
                    JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.API.run.linkOptions.events.ReportExecution", {
                        "data" : dataString
                    });
                    break;
                }
                case "LocalAnchor": {
                    report
                        .pages({
                            anchor: link.anchor
                        })
                        .run()
                        .fail(function(error) {
                            JasperMobile.Callback.log(error);
                        });
                    break;
                }
                case "LocalPage": {
                    report.pages(link.pages)
                        .run()
                        .fail(function(error) {
                            JasperMobile.Callback.log(error);
                        })
                        .done(function() {
                            JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.API.run.linkOptions.events.LocalPage", {
                                "page" : link.pages
                            });
                        });
                    break;
                }
                case "Reference": {
                    var href = link.href;
                    JasperMobile.Callback.Callbacks.successCallback("JasperMobile.Report.API.run.linkOptions.events.Reference", {
                        "location" : href
                    });
                    break;
                }
                default: {
                    defaultHandler.call(this);
                }
            }
        };

        var reportStruct = {
            resource: params["uri"],
            params: params["params"],
            pages: params["pages"],
            scale: "width",
            container: "#container",
            success: successFn,
            error: errorFn,
            events: events,
            linkOptions: {
                events: {
                    click : linkOptionsEventsClick
                }
            }
        };
        var auth = {};

        if (params["is_for_6_0"]) {
            auth = {
                auth: {
                    loginFn: function(properties, request) {
                        return (new Deferred()).resolve();
                    }
                }
            };
        } else {
            reportStruct.chart = {
                animation : false,
                zoom : false
            };
        }

        var runFn = function (v) {
            // save link for reportObject
            JasperMobile.Report.API.report = v.report(reportStruct);
        };
        visualize(auth, runFn, errorFn);
    },
    cancel: function() {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.cancel()
                .done(function () {
                    JasperMobile.Callback.log("success cancel");
                })
                .fail(function (error) {
                    JasperMobile.Callback.log("failed cancel with error: " + error);
                });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.cancel", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    },
    refresh: function() {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.refresh()
                .done( function() {
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.refresh", {
                        "status": status,
                        "pages": JasperMobile.Report.API.report.data().totalPages
                    });
                }).fail( function(error) {
                    JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.refresh", {
                        "error": JSON.stringify({
                            "code" : error.errorCode,
                            "message" : error.message
                        })
                    });
                });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.refresh", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    },
    applyReportParams: function(params) {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.params(params).run()
                .done(function (reportData) {
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.applyReportParams", {
                        "pages": reportData.totalPages
                    });
                })
                .fail(function (error) {
                    JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.applyReportParams", {
                        "error": JSON.stringify({
                            "code" : error.errorCode,
                            "message" : error.message
                        })
                    });
                });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.applyReportParams", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    },
    selectPage: function(page) {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.pages(page).run()
                .done(function (reportData) {
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.selectPage", {
                        "page": parseInt(JasperMobile.Report.API.report.pages())
                    });
                })
                .fail(function (error) {
                    JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.selectPage", {
                        "error": JSON.stringify({
                            "code" : error.errorCode,
                            "message" : error.message
                        })
                    });
                });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.selectPage", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    },
    exportReport: function(format) {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.export({
                outputFormat: format
            }).done(function (link) {
                JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.run", {
                    "link" : link.href
                });
            });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.exportReport", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    },
    destroyReport: function() {
        if (JasperMobile.Report.API.report) {
            JasperMobile.Report.API.report.destroy()
                .done(function() {
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Report.API.destroyReport", {});
                })
                .fail(function(error) {
                    JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.destroyReport", {
                        "error" : JSON.stringify({
                            "code" : error.errorCode,
                            "message" : error.message
                        })
                    });
                });
        } else {
            JasperMobile.Callback.Callbacks.failedCompleted("JasperMobile.Report.API.destroyReport", {
                "error": JSON.stringify({
                    "code" : "visualize.error",
                    "message" : "JasperMobile.Report.API.report == nil"
                })
            });
        }
    }
};