
export const configureRouter = function (history, location, nextTick) {
    const getFragment = function () {
        return decodeURI(location.pathname + location.search).replace(/\?(.*)$/, '');
    };

    const state = {
        activeRoute: null,
        enabled: true,
        lastFragment: null,
        routes: [],
    };

    const check = function () {
        const fragment = getFragment();

        if (fragment === state.lastFragment) {
            if (state.enabled) {
                nextTick(check);
            }

            return;
        }

        // console.log("[router] fragment changed", state.lastFragment, "->", fragment, state);

        loop: for (let routeKey in state.routes) {
            const route = state.routes[routeKey];
            const { routes } = route;

            // FIXME: Support regex matchers
            for (let matcherKey in routes) {
                const matcher = routes[matcherKey];
                if (fragment.indexOf(matcher) >= 0 && state.activeRoute !== route) {
                    state.activeRoute = route;
                    state.lastFragment = fragment;

                    // FIXME: Extract route info and pass it
                    route.handler({ test: "some-test-string" });
                    break loop;
                }
            }
        }

        if (state.enabled) {
            nextTick(check);
        }
    };

    check();

    return {
        add: function (routes, handler) {
            const entry = {
                handler,
                routes,
            };
            state.routes.push(entry);

            return function () {
                state.routes = state.routes.filter(function (it) {
                    return it !== entry;
                });
            };
        },
    };
};
