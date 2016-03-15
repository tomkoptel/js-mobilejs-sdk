var JasperMobile = {
    Report: {},
    Dashboard: {},
    Callback: {
        Queue: {
            queue: [],
            dispatchTimeInterval: null,
            startExecute: function () {
                if (!this.dispatchTimeInterval) {
                    this.dispatchTimeInterval = window.setInterval(JasperMobile.Callback.Queue.execute, 200);
                }
            },
            execute: function () {
                if (JasperMobile.Callback.Queue.queue.length > 0) {
                    var callback = JasperMobile.Callback.Queue.queue.shift();
                    callback();
                } else {
                    window.clearInterval(JasperMobile.Callback.Queue.dispatchTimeInterval);
                    JasperMobile.Callback.Queue.dispatchTimeInterval = null;
                }
            },
            add: function (callback) {
                this.queue.push(callback);
                this.startExecute();
            }
        },
        createCallback: function (params) {
            var callback = "http://jaspermobile.callback/json&&" + JSON.stringify(params);
            this.Queue.add(function () {
                window.location.href = callback;
            })
        },
        onScriptLoaded: function () {
            this.createCallback(
                {
                    "command": "DOMContentLoaded",
                    "parameters": {}
                }
            );
        },
        log: function (message) {
            this.createCallback(
                {
                    "command": "logging",
                    "parameters": {
                        "message": message
                    }
                }
            );
        }
    },
    Helper: {
        collectReportParams: function (link) {
            var isValueNotArray, key, params;
            params = {};
            for (key in link.parameters) {
                if (key !== '_report') {
                    isValueNotArray = Object.prototype.toString.call(link.parameters[key]) !== '[object Array]';
                    params[key] = isValueNotArray ? [link.parameters[key]] : link.parameters[key];
                }
            }
            return params;
        },
        updateViewPortScale: function (scale) {
            var viewPortContent = 'initial-scale=' + scale + ', width=device-width, maximum-scale=2.0, user-scalable=yes';
            var viewport = document.querySelector("meta[name=viewport]");
            if (!viewport) {
                var viewport = document.createElement('meta');
                viewport.name = "viewport";
                viewport.content = viewPortContent;
                document.head.appendChild(viewport);
            } else {
                viewport.setAttribute('content', viewPortContent);
            }
        },
        updateDocumentZoom: function (zoom) {
            document.body.style.zoom = zoom;
        },
        execCustomScript: function (script, params) {
            script(params);
        },
        loadScript: function (scriptPath) {
            var isScriptAlreadyLoaded = false;
            var allScripts = document.head.getElementsByTagName("script");

            for (var i = 0; i < allScripts.length; i++) {
                var script = allScripts[i];
                if (script.src === scriptPath) {
                    isScriptAlreadyLoaded = true;
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Helper.loadScript", {
                        "params": {
                            "script_path": scriptPath
                        }
                    });
                    break;
                }
            }
            if (!isScriptAlreadyLoaded) {
                var scriptTag = document.createElement('script');
                scriptTag.src = scriptPath;
                scriptTag.onload = function () {
                    JasperMobile.Callback.Callbacks.successCompleted("JasperMobile.Helper.loadScript", {
                        "params": {
                            "script_path": scriptPath
                        }
                    });
                };
                document.head.appendChild(scriptTag);
            }
        }
    }
};

// Callbacks
JasperMobile.Callback.Listeners = {
    listener: function (listener, parameters) {
        JasperMobile.Callback.createCallback(
            {
                "command": listener,
                "parameters": parameters
            }
        );
    }
};

JasperMobile.Callback.Callbacks = {
    successCompleted: function (command, parameters) {
        JasperMobile.Callback.createCallback(
            {
                "command": command,
                "parameters": parameters
            }
        );
    },
    failedCompleted: function (command, parameters) {
        JasperMobile.Callback.createCallback(
            {
                "command": command,
                "parameters": parameters
            }
        );
    },
    successCallback: function (callback, parameters) {
        JasperMobile.Callback.createCallback(
            {
                "command": callback,
                "parameters": parameters
            }
        );
    },
    failedCallback: function (callback, parameters) {
        JasperMobile.Callback.createCallback(
            {
                "command": callback,
                "parameters": parameters
            }
        );
    }
};

// Start Point
document.addEventListener("DOMContentLoaded", function (event) {
    JasperMobile.Callback.onScriptLoaded();
});

window.onerror = function myErrorHandler(message, source, lineno, colno, error) {
    JasperMobile.Callback.Callbacks.failedCallback("JasperMobile.Events.Window.OnError", {
        "error": JSON.stringify({
            "code": "window.onerror",
            "message": message + " " + source + " " + lineno + " " + colno + " " + error,
            "source": source
        })
    });
};

JasperMobile.Report = {
    REST      : {},
    VISUALIZE : {},
    // TODO: Replace 'API' with 'VISUALIZE'
    API       : {}
};