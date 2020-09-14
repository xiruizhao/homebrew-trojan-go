A formula distributing pre-build binaries from [trojan-go releases](https://github.com/p4gefau1t/trojan-go/releases).

# Usage

```
brew tap xiruizhao/trojan-go
brew install trojan-go
brew services start trojan-go
```

client config example will be installed to `/usr/local/etc/trojan-go/config.json-example`. Please modify it and rename to `config.json`.

# Uninstallation

```
brew services stop trojan-go
brew remove trojan-go
brew untap xiruizhao/trojan-go
```
