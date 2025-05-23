import { WebPlugin } from '@capacitor/core';
import { IZipper, ZipOptions, UnZipOptions } from './definitions';

export class ZipperPluginWeb extends WebPlugin implements IZipper {
  async zip(options: ZipOptions, progress?: (info: { value: number }) => void): Promise<{ value: string }> {
    console.log('[ZipperPluginWeb] zip called with:', options);

    // Simulated progress loop
    for (let i = 0; i <= 100; i += 25) {
      await new Promise((r) => setTimeout(r, 100));
      progress?.({ value: i });
    }

    return { value: 'simulated/path/to/zip.zip' };
  }

  async unZip(options: UnZipOptions, progress?: (info: { value: number }) => void): Promise<{ value: string }> {
    console.log('[ZipperPluginWeb] unZip called with:', options);

    // Simulated progress loop
    for (let i = 0; i <= 100; i += 25) {
      await new Promise((r) => setTimeout(r, 100));
      progress?.({ value: i });
    }

    return { value: 'simulated/path/to/unzipped/files' };
  }
}

const ZipperPlugin = new ZipperPluginWeb();

export { ZipperPlugin };
