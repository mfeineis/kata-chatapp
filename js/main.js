/* global Core, Elm */

Core.widget(function main(Y) {
    Y.log("Core.widget.main", Y);

    const app = Elm.App.init({
        flags: {},
        node: Y.query("#root")
    });

    Y.emit("page.init");
});

