// FIXME: OMG, please validate this thoroughly
export const validateMeta = function (meta) {
    return meta && meta["element"] && meta["fragment"];
};

export function configureRuntime(configureLoader, registerElement, setTimeout, query, router) {

    const state = {
        elements: {},
        queue: [],
    };

    // FIXME: OMG, side-effects in a filter...
    const dispatchQueue = function (meta) {
        state.queue = state.queue.filter(function ({ element, next }) {
            if (meta.element === element) {
                setTimeout(function () {
                    requestFragment(element, next);
                }, 0);
                return false;
            }

            return true;
        });
    };

    // FIXME: Validation, validation, validation...
    const declare = function (meta) {
        console.log('runtime.declare', meta);

        if (state.elements[meta.element]) {
            console.error(`runtime.declare: "${meta.element}" is already defined`);
            return;
        }

        if (!validateMeta(meta)) {
            console.error(`runtime.declare: meta for "${meta.element}" invalid`);
            return;
        }

        meta.observe = meta.observe || [];

        state.elements[meta.element] = {
            meta,
        };

        if (meta.enhance) {
            // FIXME: Error handling for routes!
            const addRoute = function (routes, selectHost) {
                router.add(routes, function (route) {
                    const { host, props } = selectHost(route, query);

                    if (!host) {
                        // eslint-disable-next-line no-console
                        console.warn(`[router] route match`, route, 'with invalid host');
                        return;
                    }

                    // eslint-disable-next-line no-console
                    console.log(`[router] route match`, route, 'into', host);
                    const attrs = Object.keys(props).map(function (key) {
                        return ` ${key}=${props[key]}`;
                    }).join("");

                    host.innerHTML = `<${meta.element}${attrs}></${meta.element}>`;
                });
            };

            meta.enhance({ route: addRoute });
        }

        const connectFragment = function (element, meta) {
            const attrs = {};

            for (let name of meta.observe) {
                attrs[name] = element.getAttribute(name);
            }

            // The factory itself acts as the `conntectedCallback`
            element.proxy = meta.factory.call(null, element, attrs);
        };

        registerElement(meta.element, Object.create({
            prototype: HTMLElement.prototype,

            get observedAttributes() {
                return meta.observe;
            },

            adoptedCallback: function () {
                this.proxy && this.proxy.adopted && this.proxy.adopted.call(null, this);
            },

            attributeChangedCallback: function (name, oldValue, newValue) {
                this.proxy && this.proxy.attributeChanged && this.proxy.attributeChanged.call(null, this, name, oldValue, newValue);
            },

            // FIXME: This should probably clean up after itself
            connectedCallback: function () {
                if (meta.factory) {
                    // Fragment already loaded, short-circuiting to avoid
                    // delay and flickering
                    connectFragment(this, meta);
                    return;
                }

                // FIXME
                // Should we provide a default loading indicator
                // for the time it takes to load the fragment.
                // A placeholder would be better but how does
                // the loader know what to display? Maybe this is
                // something a registration could provide optionally.
                // After the fragment factory is called the fragment
                // itself can take over.
                requestFragment(meta.element, function (factory) {
                    meta.factory = factory;
                    connectFragment(this, meta);
                });
            },

            disconnectedCallback: function () {
                this.proxy && this.proxy.disconnected && this.proxy.disconnected.call(null, this);
                this.proxy = null;
            },
        }));

        dispatchQueue(state, meta);
    };

    // TODO: This is actually not so bad but needs refinement
    const requestFragment = function (element, next) {
        const declaration = state.elements[element];

        //console.log("requestFragment", element, registration);

        if (!declaration) {
            console.warn(`runtime.requestFragment: widget not found`);
            state.queue.push({ timestamp: Date.now(), element, next });

            console.log(`runtime.state`, state);
            return;
        }

        // Good thing that requirejs is so configurable out of the box
        const use = configureLoader({
            paths: {
                [declaration.meta.element]: declaration.meta.fragment.replace(/\.js$/, ''),
            },
        });

        use([declaration.meta.element], next);
    };

    return {
        declare,
    };
};

