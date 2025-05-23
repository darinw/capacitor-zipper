import { registerPlugin } from '@capacitor/core';
import { IZipper, UnZipOptions, ZipOptions } from './definitions';

const ZipPlugin = registerPlugin<{
  zip: (options: ZipOptions, progress?: (data: any, error?: any) => void) => void;
  unZip: (options: UnZipOptions, progress?: (data: any, error?: any) => void) => void;
}>('Zip');

export class Zipper implements IZipper {
  public zip(options: ZipOptions, progress?: (info: { value: number }) => void): Promise<{ value: string }> {
    return new Promise((resolve, reject) => {
      ZipPlugin.zip(options, (data: any, error?: any) => {
        if (!error) {
          if (!data.completed) {
            progress?.({ value: data.progress });
          } else {
            resolve({ value: data.path });
          }
        } else {
          reject(error);
        }
      });
    });
  }

  public unZip(options: UnZipOptions, progress?: (info: { value: number }) => void): Promise<{ value: string }> {
    return new Promise((resolve, reject) => {
      ZipPlugin.unZip(options, (data: any, error?: any) => {
        if (!error) {
          if (!data.completed) {
            progress?.({ value: data.progress });
          } else {
            resolve({ value: data.path });
          }
        } else {
          reject(error);
        }
      });
    });
  }
}
