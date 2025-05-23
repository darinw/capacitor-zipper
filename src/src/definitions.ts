declare global {
  interface PluginRegistry {
    ZipperPlugin?: IZipper;
  }
}

export interface IZipper {
  zip(options: ZipOptions, progress?: Function): void;
  unZip(options: UnZipOptions, progress?: Function): void;
}

export interface ZipOptions {
  source: string;
  destination: string;
  keepParent?: boolean;
  password?: string;
}

export interface UnZipOptions {
  source: string;
  destination: string;
  overwrite?: boolean;
  password?: string;
}
