Pazuzu's Gentoo Overlay
=======================

## How to

If your `/etc/portage/repos.conf` is a directory, ten simply create a file
called `pazuzu.conf` with the following contents:

```ini
[pazuzu]
location = /var/db/repos/pazuzu

sync-type = git
sync-uri = https://gitlab.fi.muni.cz/xlacko1/pazuzu-overlay
auto-sync = yes
```

Then, synchronize this repository:

```sh
emerge --sync pazuzu

# optionally update eix database:
eix-update
```

If your `/etc/portage/repos.conf` is a regular file, append the aforementioned
configuration to it.
