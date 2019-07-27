/* global Core, Elm, ElmElements, Filament */

Core.widget(function main(Y) {
    Y.log("Core.widget.main", Y, { Elm, Filament, Core, ElmElements });

    const app = Elm.App.init({
        flags: {},
        node: Y.query("#root")
    });

    Y.emit("page.init");
});

