import { registerPlugin } from '@capacitor/core';

import type { ZipperPlugin } from './definitions';

const Zipper = registerPlugin<ZipperPlugin>('Zipper', {
  web: () => import('./web').then((m) => new m.ZipperWeb()),
});

export * from './definitions';
export { Zipper };
