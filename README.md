# validator_lint

## Features

Lint that informs the user when a TextFormField has no validator.

## Getting started

## Installation

1. Add `validator_lint` and `custom_lint` as a dev dependency in your project's `pubspec.yaml`.

   ```sh
   dart pub add validator_lint custom_lint --dev
   ```

2. In your `analysis_options.yaml` add `include: package:validator_lint/analysis_options.yaml`. You might want to exclude some files
   (e.g generated json serializable) from analysis.

3. Enable the `custom_lint` analyzer plugin in `analysis_options.yaml`. You can customize lint rules by adding a `custom_lint` config
   with a `rules` section.

4. Run `flutter pub get` in your project main directory and restart your IDE. You're ready to go!

## Usage

Example `analysis_options.yaml`:

```yaml

custom_lint:
  rules:
    - validator_lint: true

analyzer:
  plugins:
    # Required for our custom lints support
    - custom_lint
  exclude:
    - '**/*.g.dart'
```
