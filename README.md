# fuzzycrontab
![master build](https://github.com/oofoghlu/fuzzycrontab/actions/workflows/validation.yaml/badge.svg)

Boost your crontabs with Jenkins-style hashed cron expressions.

These hashes allow for more uniform distribution of your workloads across time. Like with Jenkins, the hashes
are deterministic based on a given string basis (with Jenkins as per-job name).

## Description

The hash is based on whatever string is given allowing for crons with the same cadence to be scheduled differently,
distributing your workloads more evenly. The hash is evaluated differently per field index in the cron expression ensuring spread from field to field when evaluated for the same range.

Given that the evaluation is deterministic based on the string provided an individual job should be evaluated the
same every time ensuring no gaps in your expected cadence.

Some sample expressions supported (along with example evaluations):

```
H H H H H
-> 20 19 11 6 4

H H * H/2 *
-> 18 17 * 1/2 *

H(5-15)/20 H/5 * * *
-> 12/20 3/5 * * *

H(0-5) * * * *
-> 4 * * * *
```