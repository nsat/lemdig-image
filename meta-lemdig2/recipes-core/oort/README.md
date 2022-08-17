Recipe oort
====================

Simple recipe for installing oort agent and startup files.

The OORT agent is maintained in a separate git repository,
https://github.com/nsat/oort-ta-dev

The OORT agent binary is built by a concourse pipeline,
https://ci.spire.sh/teams/constellation/pipelines/oort:agent-release

The build pipeline saves the built installation package - the
agent binary along with its startup scripts - to a S3 bucket.

The bitbake recipe here pulls the installation package from S3,
extracts it, and installs the files to the appropriate places.
