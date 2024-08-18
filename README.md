# open_weather

A [Open Weather](https://github.com/nasa/apod-api) consumer app.

## Getting started

### Configuration

You will need an API key. You can get one [here](https://openweathermap.org/price#onecall).

After that you need to move `env-example.json` to `env.json` and fill it with key you just got.

> Or you could just use `env-example.json` as is. Just remember to provide the correct filee name in the commands bellow.

### Running

Nothing too special. Just remember to provide the env file as an argument:

```bash
flutter run --dart-define-from-file=env.json
```

### Building

Similarly to running, just use the env file:

```bash
flutter build apk --dart-define-from-file=env.json
flutter build web --dart-define-from-file=env.json
```

### Testing

#### Unit tests

Just the usual:

```bash
flutter test
```
