# Capacitor Zip

## Installation

- `npm i capacitor-zipper`

## Usage

```ts
import { Zip } from "capacitor-zipper";
const zip = new Zip();

await zip.zip(
  {
    source: source,
    destination: destination,
    keepParent: true, // Optional default true
    password: "password", // Optional
  },
  (progress) => {}
);

await zip.unZip(
  {
    source: source,
    destination: destination,
    overwrite: true, // Optional default true
    password: "password", // Optional
  },
  (progress) => {}
);
```
