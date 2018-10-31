class AlienvaultAgent < Formula
  desc "AlienVault Agent"
  homepage "https://www.alienvault.com/"
  url "https://s3-us-west-2.amazonaws.com/ci-otxb-portal-osquery/repo/osx/alienvault-agent-2.11.2-16-g93486bcb_1.0.4.tar.gz"
  sha256 "cd34c0a5cd49ee61e6e6f33f9f193b03a19dddbdbfafddbe37805f3059fd0f66"
  version "2.11.2-16-g93486bcb_1.0.4"
  plist_options :startup => true

  bottle :unneeded

  def install
    bin.install "osqueryi"
    bin.install "osqueryd"
    bin.install "osqueryctl"
    bin.install "osqueryd-run.sh"
    bin.install "alienvault-agent.sh"
    (var/"osquery").mkpath
    (var/"osquery").install "osquery.flags.example"
    (var/"osquery/certs").mkpath
    (var/"osquery/certs").install "certs.pem"
    (var/"log/osquery").mkpath
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Disabled</key>
      <false/>
      <key>Label</key>
      <string>com.facebook.osqueryd</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/bin/osqueryd-run.sh</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>ThrottleInterval</key>
      <integer>60</integer>
    </dict>
    </plist>
    EOS
  end
end
