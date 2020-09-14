# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class TrojanGo < Formula
  desc "A Trojan proxy written in Go. An unidentifiable mechanism that helps you bypass GFW."
  homepage "https://p4gefau1t.github.io/trojan-go"
  # download binary from upstream directly
  url "https://github.com/p4gefau1t/trojan-go/releases/download/v0.8.1/trojan-go-darwin-amd64.zip"
  version "0.8.1"
  sha256 "4baa3957037fffb08e788e831cac05b59e036c8fdb17055d2fc7f58cc6b01676"
  license "GPL-3.0"

  def install
    bin.install "trojan-go"
    pkgshare.install "geoip.dat" # installed to /usr/local/Cellar/trojan-go/{version}/share/trojan-go, symlinked to /usr/local/share/trojan-go
    pkgshare.install "geosite.dat"
    system "sed", "-i", "", "-e", "s#/usr/share/#/usr/local/share/#", "example/client.json"
    (etc/"trojan-go").mkpath
    etc.install "example/client.json" => "trojan-go/config.json-example"
  end

  def caveats
    <<~EOS
      client config example has been installed to #{etc}/trojan-go/config.json-example
      please modify it and rename to config.json
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test trojan-go`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/trojan-go", "-version"
  end

  plist_options :manual => "trojan-go -config #{HOMEBREW_PREFIX}/etc/trojan-go/config.json"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/trojan-go</string>
            <string>-config</string>
            <string>#{etc}/trojan-go/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end
