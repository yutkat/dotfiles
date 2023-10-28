'use strict';

import App from 'resource:///com/github/Aylur/ags/app.js';
import Bar from './bar/config.js';
import { exec } from 'resource:///com/github/Aylur/ags/utils.js';

export function forMonitors(widget) {
    const ws = JSON.parse(exec('hyprctl -j monitors'));
    return ws.map((/** @type {Record<string, number>} */ mon) => widget({ monitor: mon.id }));
}

// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        forMonitors(Bar)
    ].flat(2),
};
