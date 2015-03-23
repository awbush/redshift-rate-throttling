## Overview

This tool uses cloudtrail logs to identify users/clients consuming the Redshift
rate throttling limit (usually Amazon's own AWS console). It runs in a few
seconds.

## Requirements

- [aws](http://aws.amazon.com/cli/)
- [jq](http://stedolan.github.io/jq/)
- [sqlite3](https://sqlite.org)

## Installation

Copy the config to `config.sh`:

	cp config.example.sh config.sh

and edit it to use your account number, region and bucket.

## Usage

Run:

	./build-db.sh

It will download the latest few hours of data, convert it to a sqlite database,
then show the most active user/client over the last few hours.

After that, you can connect to the db and run other reports, if desired.
