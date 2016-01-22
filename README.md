# Jenkins metrics for health reporting

This project is available as a gem: `gem install jenkins-metrics-health`

## required flags

`-u` - jenkins URL
`-k` - metrics key to access metrics. See https://wiki.jenkins-ci.org/display/JENKINS/Metrics+Plugin for details.

Prints out all messages. Returns 0 if all metrics are passing, otherwise returns 1.

This script is meant to integrate into such things as consul for simple monitoring.
