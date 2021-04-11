#!/bin/bash
# A lame and quick script to run docker-bench-security in WebSploit Labs
# Omar Santos @santosomar

echo "Running docker-bench-security from WebSploit"

docker run --rm --net host --pid host --userns host --cap-add audit_control \
    -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
    -v /etc:/etc:ro \
    -v /lib/systemd/system:/lib/systemd/system:ro \
    -v /usr/bin/containerd:/usr/bin/containerd:ro \
    -v /usr/bin/runc:/usr/bin/runc:ro \
    -v /usr/lib/systemd:/usr/lib/systemd:ro \
    -v /var/lib:/var/lib:ro \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    --label docker_bench_security \
    docker/docker-bench-security > bench_results.txt


cat bench_results.txt | grep WARN
echo "The output above only includes the major findings. The complete results have been stored at: $(pwd)/bench_results.txt "