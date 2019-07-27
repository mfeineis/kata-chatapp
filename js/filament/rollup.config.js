import path from "path";

import commonjs from "rollup-plugin-commonjs";
import nodeResolve from "rollup-plugin-node-resolve";

export default {
    input: path.join(__dirname, "src/index.js"),
    output: {
        file: path.join(__dirname, "dist/filament.development.js"),
        format: "iife",
        name: "Filament",
    },
    plugins: [
        nodeResolve(),
        commonjs(),
    ],
};
