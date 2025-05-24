export interface ZipperPlugin {
  zip(options: ZipOptions, progress?: any): void;
  unZip(options: UnZipOptions, progress?: any): void;
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
