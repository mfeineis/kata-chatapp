import { add, use } from "./loader";
import { configureRuntime } from "./runtime";
import { configureRouter } from "./router";

const { document, history, location, setTimeout } = window;

const nextTick = function (next) {
    return setTimeout(next, 50);
};

const router = configureRouter(history, location, nextTick);
const query = function (select) {
    return document.querySelector(select);
};

const { declare } = configureRuntime(
    use.config,
    document.registerElement,
    setTimeout,
    query,
    router
);

const exportSymbol = function (host, name, it) {
    host[name] = it;
};

const Api = {};

exportSymbol(Api, "declare", function (name, config) {
    // FIXME: Should the config be a factory?
    config.element = name;
    declare(config);
});

exportSymbol(Api, "provide", function (name, factory) {
    // FIXME: Do we need dependency handling here?
    add(name, [], function () { return factory; });
});

if (typeof window !== "undefined" && !window["Filament"]) {
    // This global is unavoidable since that is our single point of entry
    exportSymbol(window, "Filament", Api);
}

// FIXME: Mehhh... maybe use a suitable webpack library target for "filament-core"?

