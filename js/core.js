/* global Core, CustomEvent, Elm, greeshka */
greeshka(function (add, window) {
    const document = window.document;

    function polyfill(window) {
        if (typeof window.CustomEvent === "function") return;

        function CustomEvent(event, params) {
            params = params || { bubbles: false, cancelable: false, detail: null };
            var evt = document.createEvent("CustomEvent");
            evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
            return evt;
        }

        CustomEvent.prototype = window.Event.prototype;

        window.CustomEvent = CustomEvent;
    }

    polyfill(window);

    add(function base(Y) {
        Y.log = Y.log;
        //Y.mix = Y.mix;
    });

    add(function dom(Y) {

        Y.query = function query(selector, context) {
            return (context || document).querySelector(selector);
        };

        Y.queryAll = function queryAll(selector, context) {
            return (context || document).querySelectorAll(selector);
        };

    });

    add(function pubsub$browser(Y) {
        const subs = [];
        const history = [];

        function clone(it) {
            return JSON.parse(JSON.stringify(it));
        }

        function on(channel, fn, options) {
            options = options || { replay: true };
            Y.log("pubsub.on()", channel, fn);
            const fullTopic = "topic:" + channel;

            function callback(ev) {
                history.push(clone(ev.detail));
                fn.call(null, clone(ev.detail));
            }

            document.addEventListener(fullTopic, callback);
            function dispose() {
                Y.log("pubsub.on().dispose", channel, fn);
                document.removeEventListener(fullTopic, callback);
            }
            subs.push(dispose);

            if (options.replay) {
                history.map(clone).forEach(function (entry) {
                    Y.log("pubsub.on:replaying", channel, entry);
                    fn.call(null, entry);
                });
            }
            return dispose;
        }

        function emit(topic, data) {
            Y.log("pubsub.emit()", topic, data);
            const fullTopic = "topic:" + topic;
            document.dispatchEvent(new CustomEvent(fullTopic, {
                detail: data,
            }));
        }

        Y.emit = emit;
        Y.on = on;

        return function dispose() {
            subs.forEach(function (sub) {
                sub();
            });
        };
    });

    return function finalize(_, Y, Core) {
        delete window.greeshka;
        Y.expose("Core", Object.freeze({
            widget: function widget(fn) {
                Core.use(function (use) {
                    use(fn);
                });
            }
        }));
    };
});

