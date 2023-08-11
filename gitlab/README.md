## Example of gitlab runner config.toml

```
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "main runner"
  url = "https://gitlab.local.com"
  token = "<CENSORED>"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
  [runners.docker]
    tls_verify = false
    image = "ubuntu:20.04"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/etc/hosts:/etc/hosts", "/home/automation/.ssh/id_rsa:/sshkey"]
    shm_size = 0
```
